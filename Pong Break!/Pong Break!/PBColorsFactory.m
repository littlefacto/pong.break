//
//  PBColorsFactory.m
//  Pong Break!
//
//  Created by Vincent on 11/07/2015.
//  Copyright © 2015 Vincent. All rights reserved.
//

#import "PBColorsFactory.h"

@implementation PBColorsFactory

+ (SKColor *)sceneBackgroundColorForLevel:(NSInteger)level
{
    return [SKColor redColor];
}

+ (SKColor *)ballColor
{
    return [SKColor whiteColor];
}

+ (SKColor *)borderColorForLevel:(NSInteger)level
{
    return [SKColor blueColor];
}

@end
