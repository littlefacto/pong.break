//
//  PBNodesFactory.h
//  Pong Break!
//
//  Created by Vincent on 11/07/2015.
//  Copyright © 2015 Vincent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PBBorderNode.h"
@import SpriteKit;

@interface PBNodesFactory : NSObject

+ (SKNode *)ballNode;
+ (NSArray *)borderNodesForLevel:(NSInteger)level;

@end
