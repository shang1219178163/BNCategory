
//
//  NSTimer+Helper.m
//  HuiZhuBang
//
//  Created by BIN on 2018/5/7.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "NSTimer+Helper.h"

@implementation NSTimer (Helper)

+ (NSTimer *)BN_timeInterval:(NSTimeInterval)interval
                       block:(void(^)(NSTimer *timer))block
                     repeats:(BOOL)repeats{
    return [self scheduledTimerWithTimeInterval:interval
                                         target:self
                                       selector:@selector(BN_handleInvoke:)
                                       userInfo:[block copy]
                                        repeats:repeats];
}

+ (void)BN_handleInvoke:(NSTimer *)timer {
    void(^block)(NSTimer *timer) = timer.userInfo;
    if(block) {
        block(timer);
    }
}

+ (void)stopTimer:(NSTimer *)timer{
    [timer invalidate];
    timer = nil;
    
//    DDLog(@"timer stop!!!");
}

+ (dispatch_source_t)counterWithTimer:(dispatch_source_t)timer handler:(void (^)(void))handler{
    if (!timer) {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
        dispatch_source_set_timer(timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
        dispatch_source_set_event_handler(timer, ^{
            dispatch_async(dispatch_get_main_queue(), handler);
            
        });
        dispatch_resume(timer); // 启动定时器
    }
    return timer;
}

+(void)destoryTimer:(dispatch_source_t)timer{
    if (timer) {
        dispatch_source_cancel(timer);
        timer = nil;
    }
}

@end
