//
//  GameOverScene.m
//  Pong Break!
//
//  Created by Vincent on 12/07/2015.
//  Copyright © 2015 Vincent. All rights reserved.
//

#import "GameOverScene.h"
#import "GameScene.h"
#import "PBColorsFactory.h"
#import "PBGameManager.h"

@implementation GameOverScene

#pragma mark - SKScene

- (void)didMoveToView:(nonnull SKView *)view
{
    [self setUpGameScene];
}

static NSString *TRY_GAIN_BUTTON_NAME = @"tryAgainButton";

- (void)touchesBegan:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInNode:self];
    SKNode *touchedNode = [self nodeAtPoint:touchPoint];
    
    if ([touchedNode.name isEqualToString:TRY_GAIN_BUTTON_NAME]) {
        SKLabelNode *tryAgainNode = (SKLabelNode *) touchedNode;
        tryAgainNode.fontColor = [tryAgainNode.fontColor colorWithAlphaComponent:0.4];
    }
}

- (void)touchesCancelled:(nullable NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInNode:self];
    SKNode *touchedNode = [self nodeAtPoint:touchPoint];
    
    if ([touchedNode.name isEqualToString:TRY_GAIN_BUTTON_NAME]) {
        SKLabelNode *tryAgainNode = (SKLabelNode *) touchedNode;
        tryAgainNode.fontColor = [tryAgainNode.fontColor colorWithAlphaComponent:1.0];
    }
}

- (void)touchesEnded:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInNode:self];
    SKNode *touchedNode = [self nodeAtPoint:touchPoint];
    
    if ([touchedNode.name isEqualToString:TRY_GAIN_BUTTON_NAME]) {
        [self startNewGame];
    }
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
    
    NSString *bestScoreText = [NSString stringWithFormat:@"Best Score: %d", [[PBGameManager sharedInstance] bestScore]];
    SKLabelNode *bestScoreLabelNode = [SKLabelNode labelNodeWithText:bestScoreText];
    bestScoreLabelNode.fontSize = 64;
    bestScoreLabelNode.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    bestScoreLabelNode.position = CGPointMake(0, self.frame.size.height/4 - mainTextLabelNode.frame.size.height - 12);
    
    [self addChild:bestScoreLabelNode];
    
    SKLabelNode *tryAgainLabelNode = [SKLabelNode labelNodeWithText:@"Try Again?"];
    tryAgainLabelNode.name = TRY_GAIN_BUTTON_NAME;
    tryAgainLabelNode.fontSize = 64;
    tryAgainLabelNode.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    tryAgainLabelNode.position = CGPointMake(0, 0);
    
    [self addChild:tryAgainLabelNode];
}

- (void)startNewGame
{
    SKTransition *transition = [SKTransition fadeWithDuration:0.0];
    GameScene *gameOverScene = [[GameScene alloc] initWithSize:self.frame.size];
    [self.scene.view presentScene:gameOverScene transition:transition];
}

@end
