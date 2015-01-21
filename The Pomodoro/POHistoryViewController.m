//
//  POHistoryViewController.m
//  The Pomodoro
//
//  Created by Duc Ho on 1/20/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "POHistoryViewController.h"
#import "PORoundsDataSource.h"
#import "POTimer.h"
#import "POTimerViewController.h"


@interface POHistoryViewController () <UITableViewDelegate>

@property (nonatomic, strong) PORoundsDataSource *dataSource;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation POHistoryViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self registerForNotification];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataSource = [PORoundsDataSource new];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    
    self.tableView.dataSource = self.dataSource;
    self.tableView.delegate = self;
    [self.dataSource registerTableView:self.tableView];
    
    [self selectCurrentRound];
    [self postMinute];

}

-(void)postMinute {
    [[POTimer sharedInstance] cancelTimer];
    [POTimer sharedInstance].minutes = [[self.dataSource roundAtIndex:self.dataSource.currentRound] integerValue];
    [POTimer sharedInstance].seconds = 0;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"newRound" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.dataSource.currentRound = indexPath.row;
    [self postMinute];
}

-(void)registerForNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endRound:) name:TimerCompleteNotification object:nil];
}

-(void)unRegisterForNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:TimerCompleteNotification object:nil];
}

-(void)dealloc {
    [self unRegisterForNotification];
}

-(void)endRound:(NSNotification *)notification {
    self.dataSource.currentRound++;
    [self selectCurrentRound];
    [self postMinute];

}

-(void)selectCurrentRound {
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:self.dataSource.currentRound inSection:0]
                                    animated:NO
                            scrollPosition:UITableViewScrollPositionTop];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
