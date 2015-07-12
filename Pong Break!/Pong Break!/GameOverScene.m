//
//  GameOverScene.m
//  Pong Break!
//
//  Created by Vincent on 12/07/2015.
//  Copyright © 2015 Vincent. All rights reserved.
//

#import "GameOverScene.h"
#import "PBColorsFactory.h"
#import "PBGameManager.h"

@implementation GameOverScene

#pragma mark - SKScene

- (void)didMoveToView:(nonnull SKView *)view
{
    [self setUpGameScene];
}

#pragma mark - Private Methods

- (void)setUpGameScene
{
    self.scaleMode = SKSceneScaleModeAspectFill;
    self.anchorPoint = CGPointMake(0.5, 0.5);
    
    self.backgroundColor = [PBColorsFactory sceneBackgroundColor];
    
    
    SKLabelNode *mainTextLabelNode = [SKLabelNode labelNodeWithText:@"Game Over!"];
    mainTextLabelNode.fontSize = 64;
    mainTextLabelNode.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    mainTextLabelNode.position = CGPointMake(0, self.frame.size.height/4);
    
    [self addChild:mainTextLabelNode];
    
    NSString *bestScoreText = [NSString stringWithFormat:@"Best Score: %02d", [[PBGameManager sharedInstance] bestScore]];
    SKLabelNode *bestScoreLabelNode = [SKLabelNode labelNodeWithText:bestScoreText];
    bestScoreLabelNode.fontSize = 64;
    bestScoreLabelNode.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    bestScoreLabelNode.position = CGPointMake(0, self.frame.size.height/4 - mainTextLabelNode.frame.size.height - 12);
    
    [self addChild:bestScoreLabelNode];
}

@end
