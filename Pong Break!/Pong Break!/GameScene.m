//
//  GameScene.m
//  Pong Break!
//
//  Created by Vincent on 11/07/2015.
//  Copyright (c) 2015 Vincent. All rights reserved.
//

#import "GameScene.h"
#import "PBConstants.h"
#import "PBUtils.h"
#import "PBColorsFactory.h"
#import "PBNodesFactory.h"

@interface GameScene () <SKPhysicsContactDelegate>

@property (nonatomic, strong) SKNode *ballNode;
@property (nonatomic, strong) NSMutableArray *borders;

@end

@implementation GameScene

#pragma mark - Properties

- (NSMutableArray *)borders
{
    if (!_borders) {
        _borders = [[NSMutableArray alloc] init];
    }
    
    return _borders;
}

#pragma mark - SKScene

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    self.backgroundColor = [PBColorsFactory sceneBackgroundColorForLevel:0];
    self.scaleMode = SKSceneScaleModeAspectFill;
    self.anchorPoint = CGPointMake(0.5, 0.5);
    self.physicsWorld.contactDelegate = self;
    self.physicsWorld.gravity = CGVectorMake(0, 0);
    
    /* Ball Node */
    self.ballNode = [PBNodesFactory ballNode];
    self.ballNode.position = CGPointMake(-self.ballNode.frame.size.width/2, -self.ballNode.frame.size.height/2);
    
    [self addChild:self.ballNode];
    
    /* Initial Boder Node */
    SKNode *initialBorder = [PBNodesFactory completeBorderNodeForLevel:0];
    
    [self.borders addObject:initialBorder];
    [self addChild:initialBorder];
    
    [self.ballNode.physicsBody applyImpulse:CGVectorMake(5, 5)];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
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
    
    if ((firstBody.categoryBitMask & BORDER_PHYSICS_CATEGORY) != 0)
    {
        
    }
    
    if ((firstBody.categoryBitMask & BALL_PHYSICS_CATEGORY) != 0)
    {
        
    }
}

@end
