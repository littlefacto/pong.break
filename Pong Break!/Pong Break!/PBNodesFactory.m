//
//  PBNodesFactory.m
//  Pong Break!
//
//  Created by Vincent on 11/07/2015.
//  Copyright © 2015 Vincent. All rights reserved.
//

#import "PBNodesFactory.h"
#import "PBColorsFactory.h"
#import "PBConstants.h"

@implementation PBNodesFactory

static const NSInteger BALL_WIDTH = 25;

+ (SKNode *)ballNode
{
    SKShapeNode *node = [[SKShapeNode alloc] init];
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, BALL_WIDTH, BALL_WIDTH)];
    
    node.path = [path CGPath];
    node.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:BALL_WIDTH/2];
    node.physicsBody.categoryBitMask = BALL_PHYSICS_CATEGORY;
    node.physicsBody.contactTestBitMask = BORDER_PHYSICS_CATEGORY;
    node.fillColor = [PBColorsFactory ballColor];
    node.strokeColor = [PBColorsFactory ballColor];
    
    return node;
}

static const CGFloat BORDER_WIDTH = 200.0;
static const CGFloat BORDER_STROKE_WIDTH = 5;

+ (SKNode *)completeBorderNodeForLevel:(NSInteger)level
{
    SKShapeNode *node = [[SKShapeNode alloc] init];
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointZero
                                                        radius:BORDER_WIDTH
                                                    startAngle:0
                                                      endAngle:2*M_PI
                                                     clockwise:YES];
    
    node.path = [path CGPath];
    node.physicsBody = [SKPhysicsBody bodyWithEdgeChainFromPath:[path CGPath]];
    node.physicsBody.categoryBitMask = BORDER_PHYSICS_CATEGORY;
    node.physicsBody.contactTestBitMask = BALL_PHYSICS_CATEGORY;
    node.fillColor = [SKColor clearColor];
    node.strokeColor = [PBColorsFactory borderColorForLevel:level];
    node.lineWidth = BORDER_STROKE_WIDTH;
    
    return node;
}

@end
