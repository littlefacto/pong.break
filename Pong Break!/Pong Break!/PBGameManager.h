//
//  PBGameManager.h
//  Pong Break!
//
//  Created by Vincent on 12/07/2015.
//  Copyright © 2015 Vincent. All rights reserved.
//

#import "PBSharedInstance.h"

@interface PBGameManager : PBSharedInstance

@property (nonatomic, readonly) NSInteger currentLevel;
@property (nonatomic, readonly) NSInteger bestScore;

- (void)completedCurrentLevel;
- (void)failedCurrentLevel;

@end
