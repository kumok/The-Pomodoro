//
//  PORoundsDataSource.h
//  The Pomodoro
//
//  Created by Duc Ho on 1/20/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PORoundsDataSource : NSObject <UITableViewDataSource>

- (void)registerTableView:(UITableView *)tableView;
@property (nonatomic, assign) NSInteger currentRound;

-(NSNumber *)roundAtIndex:(NSInteger)index;

-(void)selectCurrentRound:(NSInteger)currentRound;
@end
