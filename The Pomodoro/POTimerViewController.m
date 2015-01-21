//
//  POTimerViewController.m
//  The Pomodoro
//
//  Created by Duc Ho on 1/20/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>


#import "POTimerViewController.h"
#import "POTimer.h"
#import "POHistoryViewController.h"

@interface POTimerViewController ()

@property (strong, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) IBOutlet UIButton *button;

@end

@implementation POTimerViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self registerForNotification];
    }
    
    return self;
}

-(void)registerForNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newRound:) name:@"newRound" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateButton) name:SecondTickNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateLabel) name:TimerCompleteNotification object:nil];
    
    
}


-(void)unRegisterForNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"newRound" object:nil];
    //    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"button" object:nil];
    //    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"label" object:nil];
    
}

-(void)dealloc {
    [self unRegisterForNotification];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self updateLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)buttonPressed:(id)sender {
    [[POTimer sharedInstance] startTimer];
    self.button.enabled = NO;
    [self.button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];

}



-(void)newRound:(NSNotification *)notification {
    [self updateLabel];
    [self updateButton];
}

-(void)updateButton {
    self.button.enabled = YES;
    [self.button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
}

-(void)updateLabel {
    if ([POTimer sharedInstance].seconds < 10) {
        self.label.text = [NSString stringWithFormat:@"%ld:0%ld",(long)[POTimer sharedInstance].minutes, (long)[POTimer sharedInstance].seconds];
    }
    else {
        self.label.text = [NSString stringWithFormat:@"%ld:%ld",(long)[POTimer sharedInstance].minutes, (long)[POTimer sharedInstance].seconds];
    }
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
