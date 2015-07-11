//
//  GameScene.m
//  Pong Break!
//
//  Created by Vincent on 11/07/2015.
//  Copyright (c) 2015 Vincent. All rights reserved.
//

#import "GameScene.h"
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
    self.anchorPoint = CGPointMake(0.5, 0.5);
    self.physicsWorld.contactDelegate = self;
    
    /* Ball Node */
    self.ballNode = [PBNodesFactory ballNode];
    self.ballNode.position = CGPointMake(-self.ballNode.frame.size.width/2, -self.ballNode.frame.size.height/2);
    
    [self addChild:self.ballNode];
    
    /* Initial Boder Node */
    SKNode *initialBorder = [PBNodesFactory completeBorderNodeForLevel:0];
    
    [self.borders addObject:initialBorder];
    [self addChild:initialBorder];
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
    NSLog(@"Contact!");
}

@end
