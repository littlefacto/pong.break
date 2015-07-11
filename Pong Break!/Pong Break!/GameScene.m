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

@interface GameScene () <SKPhysicsContactDelegate>

@property (nonatomic, strong) SKNode *ballNode;
@property (nonatomic, strong) NSMutableArray *borderNodes;

@property (nonatomic) CGPoint borderSpeed;
@property (nonatomic) CGFloat borderAngle;

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

-(void)didMoveToView:(SKView *)view {
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                    action:@selector(handlePanGesture:)];
    
    [self.view addGestureRecognizer:panRecognizer];
    
    /* Setup your scene here */
    [self setUpGameScene];
    
    [self setUpGameLevel:1];
    
    [self.ballNode.physicsBody applyImpulse:CGVectorMake(-5, 0)];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    
}

static const CGFloat DECELERATION_FACTOR = 2;
static const NSInteger GESTURE_TO_SPEED_FACTOR = 200000;

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    self.borderSpeed = CGPointMake(self.borderSpeed.x / DECELERATION_FACTOR, self.borderSpeed.y);
    self.borderAngle += self.borderSpeed.x / GESTURE_TO_SPEED_FACTOR;
    
    CGAffineTransform transform = CGAffineTransformMakeRotation(self.borderAngle);
    
    [self.borderNodes enumerateObjectsUsingBlock:^(id  __nonnull obj, NSUInteger idx, BOOL * __nonnull stop) {
        PBBorderNode *borderNode = (PBBorderNode *)obj;
        
        borderNode.path = CGPathCreateCopyByTransformingPath(borderNode.path, &transform);
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
        
        [self removeChildrenInArray:@[borderNode]];
    }
    
    if (firstBody.categoryBitMask == BALL_PHYSICS_CATEGORY && secondBody.categoryBitMask == SCENE_PHYSICS_CATEGORY) {
        [self showGameOver];
    }
}

#pragma mark - UIPanGestureRecognizer

- (void)handlePanGesture:(UIPanGestureRecognizer *)gesture
{
    self.borderSpeed = [gesture velocityInView:self.view];
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
}

- (void)setUpGameLevel:(NSInteger)level
{
    self.backgroundColor = [PBColorsFactory sceneBackgroundColorForLevel:level];

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

- (void)showGameOver
{
    NSLog(@"Game Over!");
}

@end
