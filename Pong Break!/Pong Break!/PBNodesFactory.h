//
//  PBNodesFactory.h
//  Pong Break!
//
//  Created by Vincent on 11/07/2015.
//  Copyright © 2015 Vincent. All rights reserved.
//

#import <Foundation/Foundation.h>
@import SpriteKit;

@interface PBNodesFactory : NSObject

+ (SKNode *)ballNode;
+ (SKNode *)completeBorderNodeForLevel:(NSInteger)level;
+ (NSArray *)separatedBorder:(SKShapeNode *)border afterImpactAtAngle:(CGFloat)angle forLevel:(NSInteger)level;

@end
