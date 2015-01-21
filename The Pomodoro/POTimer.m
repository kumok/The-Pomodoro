//
//  POTimer.m
//  The Pomodoro
//
//  Created by Duc Ho on 1/20/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "POTimer.h"

NSString * const TimerCompleteNotification = @"TimerComplete";
NSString * const SecondTickNotification = @"SecondTick";


@interface POTimer()

@property (assign, nonatomic) BOOL on;

@end

@implementation POTimer

+ (POTimer *)sharedInstance {
    static POTimer *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [POTimer new];
    });
    
    return sharedInstance;
}

- (void)startTimer {
    self.on = YES;
//    NSLog(@"%ld %ld", (long)[POTimer sharedInstance].minutes, (long)[POTimer sharedInstance].seconds);
    [self checkActive];
    
}

- (void)endTimer {
    self.on = NO;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:TimerCompleteNotification object:nil userInfo:nil];
}

- (void)cancelTimer {
    self.on = NO;
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(decreaseSecond) object:nil];
}

- (void)checkActive {
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    if (self.on == YES) {
        [self decreaseSecond];
        [self performSelector:@selector(checkActive) withObject:nil afterDelay:1.0];
    }
}

- (void)decreaseSecond {
    
    if (self.seconds > 0){
        self.seconds--;
    }
    
    if (self.minutes > 0){
        if (self.seconds == 0){
            self.seconds = 59;
            self.minutes--;
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:SecondTickNotification object:nil userInfo:nil];
    } else {
        if (self.seconds == 0) {
            [self endTimer];
        }
    }
    
}

@end
