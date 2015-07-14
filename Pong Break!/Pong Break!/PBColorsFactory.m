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
    return [SKColor colorWithRed:225.0/255.0 green:91.0/255.0 blue:108.0/255.0 alpha:1.0];
}

+ (SKColor *)ballColor
{
    return [SKColor whiteColor];
}

+ (UIColor *)borderColor:(BOOL)isOdd
{
    if (isOdd) {
        return [SKColor colorWithRed:230.0/255.0 green:229.0/255.0 blue:188.0/255.0 alpha:1.0];
    } else {
        return [SKColor colorWithRed:53.0/255.0 green:136.0/255.0 blue:174.0/255.0 alpha:1.0];
    }
}

@end
