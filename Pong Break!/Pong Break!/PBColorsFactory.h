//
//  PBColorsFactory.h
//  Pong Break!
//
//  Created by Vincent on 11/07/2015.
//  Copyright © 2015 Vincent. All rights reserved.
//

#import <Foundation/Foundation.h>
@import SpriteKit;

@interface PBColorsFactory : NSObject

+ (SKColor *)sceneBackgroundColorForLevel:(NSInteger)level;
+ (SKColor *)ballColor;
+ (SKColor *)borderColor:(BOOL)isOdd;

@end
