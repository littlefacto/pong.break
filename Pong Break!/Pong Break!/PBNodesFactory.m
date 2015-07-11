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
    node.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:BALL_WIDTH/2 center:CGPointMake(node.frame.size.width/2, node.frame.size.height/2)];
    node.physicsBody.friction = 0.0;
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

+ (NSArray *)borderNodesForLevel:(NSInteger)level
{
    NSMutableArray *nodes = [[NSMutableArray alloc] init];
    
    CGFloat offset = 2*M_PI/(8*level);
    
    for (int i = 0; i < level * 8; i++) {
        PBBorderNode *node = [[PBBorderNode alloc] initWithStartAngle:i*offset
                                                             endAngle:(i+1)*offset
                                                             forLevel:level];
        
        [nodes addObject:node];
    }
    
    return nodes;
}

@end
