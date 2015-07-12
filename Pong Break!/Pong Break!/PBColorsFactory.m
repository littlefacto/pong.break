//
//  PBColorsFactory.m
//  Pong Break!
//
//  Created by Vincent on 11/07/2015.
//  Copyright © 2015 Vincent. All rights reserved.
//

#import "PBColorsFactory.h"

@implementation PBColorsFactory

+ (SKColor *)sceneBackgroundColor
{
    return [SKColor colorWithRed:255.0/255.0 green:96/255.0 blue:79/255.0 alpha:1.0];
}

+ (SKColor *)ballColor
{
    return [SKColor whiteColor];
}

+ (UIColor *)borderColor:(BOOL)isOdd
{
    if (isOdd) {
        return [SKColor colorWithRed:104.0/255.0 green:102.0/255.0 blue:255.0/255.0 alpha:1.0];
    } else {
        return [SKColor colorWithRed:212.0/255.0 green:79.0/255.0 blue:232.0/255.0 alpha:1.0];
    }
}

@end
