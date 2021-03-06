//
//  GameScene.m
//  Pong Break!
//
//  Created by Vincent on 11/07/2015.
//  Copyright (c) 2015 Vincent. All rights reserved.
//

#import "GameScene.h"
#import "PBConstants.h"
#import "PBColorsFactory.h"
#import "PBNodesFactory.h"
#import "PBGameManager.h"
#import "GameOverScene.h"
#import <AVFoundation/AVFoundation.h>

@interface GameScene () <SKPhysicsContactDelegate>

@property (nonatomic, strong) UIPanGestureRecognizer* panGesture;

@property (nonatomic, strong) SKLabelNode *readyNode;
@property (nonatomic, strong) SKLabelNode *scoreNode;
@property (nonatomic, strong) SKAction *breakSound;
@property (nonatomic, strong) SKAction *levelCompleteSound;
@property (nonatomic, strong) SKNode *ballNode;
@property (nonatomic, strong) NSMutableArray *borderNodes;

@property (nonatomic) CGPoint borderSpeed;
@property (nonatomic) CGFloat borderAngle;

@property (nonatomic,getter=isGameStarted) BOOL gameStarted;

@end

@implementation GameScene

#pragma mark - Properties

- (NSMutableArray *)borderNodes
{
    if (!_borderNodes) {
        _borderNodes = [[NSMutableArray alloc] init];
    }
    
    return _borderNodes;
}

#pragma mark - SKScene

- (void)didMoveToView:(SKView *)view {
    self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                              action:@selector(handlePanGesture:)];
    
    [self.view addGestureRecognizer:self.panGesture];
    
    /* Setup your scene here */
    [self setUpGameScene];
    
    [self setUpGameLevel:[[PBGameManager sharedInstance] currentLevel]];
}

- (void)touchesBegan:(nonnull NSSet *)touches withEvent:(nullable UIEvent *)event
{
    if (![self isGameStarted]) {
        [self lauchGame];
    }
}

- (void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    CGAffineTransform transform = CGAffineTransformMakeRotation(self.borderAngle);
    
    [self.borderNodes enumerateObjectsUsingBlock:^(id  __nonnull obj, NSUInteger idx, BOOL * __nonnull stop) {
        PBBorderNode *borderNode = (PBBorderNode *)obj;
        
        borderNode.path = CGPathCreateCopyByTransformingPath(borderNode.path, &transform);
        [borderNode updatePhysicsBody];
    }];
}

#pragma mark - SKPhysicsContactDelegate

- (void)didBeginContact:(nonnull SKPhysicsContact *)contact
{
    SKPhysicsBody *firstBody, *secondBody;
    
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask)
    {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    }
    else
    {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    
    if (firstBody.categoryBitMask == BALL_PHYSICS_CATEGORY && secondBody.categoryBitMask == BORDER_PHYSICS_CATEGORY)
    {
        PBBorderNode *borderNode = (PBBorderNode *)secondBody.node;
        
        if (borderNode) {
            [self removeChildrenInArray:@[borderNode]];
            [self.borderNodes removeObject:borderNode];
            
            [[PBGameManager sharedInstance] borderDestroyed];
            self.scoreNode.text = [NSString stringWithFormat:@"%02d", [[PBGameManager sharedInstance] currentScore]];
            [self runAction:self.breakSound];
            
            if ([self.borderNodes count] == 0) {
                [self levelHasBeenCompleted];
            }
        }
    }
    
    if (firstBody.categoryBitMask == BALL_PHYSICS_CATEGORY && secondBody.categoryBitMask == SCENE_PHYSICS_CATEGORY) {
        [self showGameOver];
    }
}

#pragma mark - UIPanGestureRecognizer

static const NSInteger GESTURE_TO_SPEED_FACTOR = 2000;


- (void)handlePanGesture:(UIPanGestureRecognizer *)gesture
{
    self.borderSpeed = [gesture velocityInView:self.view];
    self.borderAngle += [gesture translationInView:self.view].x / GESTURE_TO_SPEED_FACTOR;
    [gesture setTranslation:CGPointZero inView:self.view];
}

#pragma mark - Private Methods

- (void)setUpGameScene
{
    self.scaleMode = SKSceneScaleModeAspectFill;
    self.anchorPoint = CGPointMake(0.5, 0.5);
    
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    self.physicsBody.categoryBitMask = SCENE_PHYSICS_CATEGORY;
    self.physicsBody.contactTestBitMask = BALL_PHYSICS_CATEGORY;
    
    self.physicsWorld.contactDelegate = self;
    self.physicsWorld.gravity = CGVectorMake(0, 0);
    
    self.readyNode = [[SKLabelNode alloc] initWithFontNamed:@"HelveticaNeue-UltraLight"];
    self.readyNode.text = @"Touch the screen to start!";
    self.readyNode.fontSize = 40;
    self.readyNode.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    self.readyNode.position = CGPointMake(0, self.frame.size.height/3);
    
    [self addChild:self.readyNode];
    
    self.scoreNode = [[SKLabelNode alloc] initWithFontNamed:@"HelveticaNeue-UltraLight"];
    self.scoreNode.text = [NSString stringWithFormat:@"%02ld", (long)[[PBGameManager sharedInstance] currentScore]];
    self.scoreNode.fontSize = 64;
    self.scoreNode.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    
    [self addChild:self.scoreNode];
    
    self.breakSound = [SKAction playSoundFileNamed:@"break_sound.wav" waitForCompletion:NO];
}

- (void)setUpGameLevel:(NSInteger)level
{
    self.backgroundColor = [PBColorsFactory sceneBackgroundColor];

    /* Ball Node */
    self.ballNode = [PBNodesFactory ballNode];
    self.ballNode.position = CGPointMake(-self.ballNode.frame.size.width/2, -self.ballNode.frame.size.height/2);
    
    [self addChild:self.ballNode];
    
    /* Initial Boder Node */
    [self.borderNodes addObjectsFromArray:[PBNodesFactory borderNodesForLevel:level]];
    [self.borderNodes enumerateObjectsUsingBlock:^(id  __nonnull obj, NSUInteger idx, BOOL * __nonnull stop) {
        [self addChild:obj];
    }];
}

- (void)clearGame
{
    if (self.ballNode) {
        [self removeChildrenInArray:@[self.ballNode]];
    }
    
    [self removeChildrenInArray:self.borderNodes];
    
    [self addChild:self.readyNode];
    
    [self setGameStarted:NO];
}

static const CGFloat INITIAL_IMPULSE = 7.5;

- (void)lauchGame
{
    CGFloat randomAngle = ((arc4random()%RAND_MAX)/(RAND_MAX*1.0)) * (2 * M_PI);
    [self.ballNode.physicsBody applyImpulse:CGVectorMake(INITIAL_IMPULSE * cos(randomAngle), INITIAL_IMPULSE * sin(randomAngle))];
    [self setGameStarted:YES];
    [self removeChildrenInArray:@[self.readyNode]];
    
}

- (void)showGameOver
{
    [self.view removeGestureRecognizer:self.panGesture];
    [[PBGameManager sharedInstance] failedCurrentLevel];
    
    SKTransition *transition = [SKTransition fadeWithDuration:0.0];
    GameOverScene *gameOverScene = [[GameOverScene alloc] initWithSize:self.frame.size];
    [self.scene.view presentScene:gameOverScene transition:transition];
}

- (void)levelHasBeenCompleted
{
    [self runAction:self.levelCompleteSound];
    [[PBGameManager sharedInstance] completedCurrentLevel];
    
    [self clearGame];
    [self setUpGameLevel:[[PBGameManager sharedInstance] currentLevel]];
}

@end
