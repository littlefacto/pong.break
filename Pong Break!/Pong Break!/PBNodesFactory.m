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
#import "PBBorderNode.h"

@implementation PBNodesFactory

static const NSInteger BALL_WIDTH = 25;

+ (SKNode *)ballNode
{
    SKShapeNode *node = [[SKShapeNode alloc] init];
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, BALL_WIDTH, BALL_WIDTH)];
    
    node.path = [path CGPath];
    node.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:BALL_WIDTH/2];
    node.physicsBody.restitution = 1.0;
    node.physicsBody.linearDamping = 0.0;
    node.physicsBody.angularDamping = 0.0;
    node.physicsBody.categoryBitMask = BALL_PHYSICS_CATEGORY;
    node.physicsBody.collisionBitMask = BORDER_PHYSICS_CATEGORY;
    node.physicsBody.contactTestBitMask = BORDER_PHYSICS_CATEGORY;
    node.fillColor = [PBColorsFactory ballColor];
    node.strokeColor = [PBColorsFactory ballColor];
    
    return node;
}



+ (SKNode *)completeBorderNodeForLevel:(NSInteger)level
{
    SKNode *node = [[PBBorderNode alloc] initWithStartAngle:0
                                                endAngle:2*M_PI
                                                forLevel:level];
    
    return node;
}

+ (NSArray *)separatedBorder:(PBBorderNode *)border afterImpactAtAngle:(CGFloat)angle forLevel:(NSInteger)level
{
    return [PBBorderNode separatedBorder:border afterImpactAtAngle:angle forLevel:level];
}

@end
