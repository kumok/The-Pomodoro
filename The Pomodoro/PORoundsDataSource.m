//
//  PORoundsDataSource.m
//  The Pomodoro
//
//  Created by Duc Ho on 1/20/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "PORoundsDataSource.h"


@implementation PORoundsDataSource 

-(id)init {
    if (self = [super init]) {
        self.currentRound = [[NSUserDefaults standardUserDefaults] integerForKey:@"CurrentRound"];
    }
    
    return self;
}
- (void)registerTableView:(UITableView *)tableView {
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self time].count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    
//    Entry *entry = [EntryController sharedInstance].entries[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",[self time][indexPath.row]];
    
    return cell;
}

-(NSArray *)time {
    return @[@25,@5,@25,@5,@25,@15];

}

-(NSNumber *)roundAtIndex:(NSInteger)index {
    return [self time][index];
}


-(void)selectCurrentRound:(NSInteger)currentRound {
    if (currentRound >= [self time].count) {
        _currentRound =0;
    }
    else {
        _currentRound = currentRound;
    }
    
    [[NSUserDefaults standardUserDefaults] setValue:@(currentRound) forKey:@"CurrentRound"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

@end
