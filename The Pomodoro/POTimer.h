//
//  POTimer.h
//  The Pomodoro
//
//  Created by Duc Ho on 1/20/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const TimerCompleteNotification;
extern NSString * const SecondTickNotification;

@interface POTimer : NSObject

@property (assign, nonatomic) NSInteger minutes;
@property (assign, nonatomic) NSInteger seconds;

+ (POTimer *)sharedInstance;

- (void)startTimer;
- (void)cancelTimer;


@end
