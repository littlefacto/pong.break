//
//  PBUtils.m
//  Pong Break!
//
//  Created by Vincent on 11/07/2015.
//  Copyright © 2015 Vincent. All rights reserved.
//

#import "PBUtils.h"

@implementation PBUtils

+ (CGPoint)centeredCoordinatesForNode:(SKNode *)node
{
    return CGPointMake(-node.frame.size.width/2, -node.frame.size.height/2);
}

@end
