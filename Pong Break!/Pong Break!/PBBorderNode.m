//
//  PBBorderNode.m
//  Pong Break!
//
//  Created by Vincent on 11/07/2015.
//  Copyright © 2015 Vincent. All rights reserved.
//

#import "PBBorderNode.h"
#import "PBConstants.h"
#import "PBColorsFactory.h"

@interface PBBorderNode ()

@property (nonatomic) CGFloat startAngle;
@property (nonatomic) CGFloat endAngle;

@end

@implementation PBBorderNode

static const CGFloat BORDER_WIDTH = 200.0;
static const CGFloat BORDER_STROKE_WIDTH = 5;

- (nonnull instancetype)initWithStartAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle forLevel:(NSInteger)level {
    self = [super init];
    
    if (self) {
        
        self.startAngle = startAngle;
        self.endAngle = endAngle;
        
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointZero
                                                            radius:BORDER_WIDTH
                                                        startAngle:startAngle
                                                          endAngle:endAngle
                                                         clockwise:YES];
        
        self.path = [path CGPath];
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromPath:[path CGPath]];
        self.physicsBody.friction = 0.0;
        self.physicsBody.categoryBitMask = BORDER_PHYSICS_CATEGORY;
        self.physicsBody.collisionBitMask = BALL_PHYSICS_CATEGORY;
        self.physicsBody.contactTestBitMask = BALL_PHYSICS_CATEGORY;
        self.fillColor = [SKColor clearColor];
        self.strokeColor = [PBColorsFactory borderColorForLevel:level];
        self.lineWidth = BORDER_STROKE_WIDTH;
    }
    
    return self;
}

@end
