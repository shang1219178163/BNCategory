//
//  CAAnimationGroup+Helper.h
//  ProductTemplet
//
//  Created by BIN on 2018/9/29.
//  Copyright © 2018年 BN. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CAAnimationGroup (Helper)

+(CAAnimationGroup *)animateWithDuration:(CFTimeInterval)duration
                            autoreverses:(BOOL)autoreverses
                             repeatCount:(float)repeatCount
                                fillMode:(NSString *)fillMode
                     removedOnCompletion:(BOOL)removedOnCompletion;

+(CAAnimationGroup *)animList:(NSArray<CAAnimation *> *)list
                     duration:(CFTimeInterval)duration
                 autoreverses:(BOOL)autoreverses
                  repeatCount:(float)repeatCount
                     fillMode:(NSString *)fillMode
          removedOnCompletion:(BOOL)removedOnCompletion;

+(CAAnimationGroup *)animList:(NSArray<CAAnimation *> *)list
                     duration:(CFTimeInterval)duration
                 autoreverses:(BOOL)autoreverses
                  repeatCount:(float)repeatCount;
    
@end
