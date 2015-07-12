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
static const CGFloat BORDER_STROKE_WIDTH = 10;

- (nonnull instancetype)initWithStartAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle odd:(BOOL)isOdd {
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
        [self updatePhysicsBody];
        self.fillColor = [SKColor clearColor];
        self.strokeColor = [PBColorsFactory borderColor:isOdd];
        self.lineWidth = BORDER_STROKE_WIDTH;
    }
    
    return self;
}

- (void)updatePhysicsBody
{
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromPath:self.path];
    self.physicsBody.friction = 0.0;
    self.physicsBody.categoryBitMask = BORDER_PHYSICS_CATEGORY;
    self.physicsBody.collisionBitMask = BALL_PHYSICS_CATEGORY;
    self.physicsBody.contactTestBitMask = BALL_PHYSICS_CATEGORY;
}

@end
