//
//  PBBorderNode.h
//  Pong Break!
//
//  Created by Vincent on 11/07/2015.
//  Copyright © 2015 Vincent. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface PBBorderNode : SKShapeNode

// Designated initializer
- (nonnull instancetype)initWithStartAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle forLevel:(NSInteger)level;

+ (NSArray * __nonnull)separatedBorder:(PBBorderNode * __nonnull)border afterImpactAtAngle:(CGFloat)angle forLevel:(NSInteger)level;

@end
