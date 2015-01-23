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
#import "CircleView.h"

@interface POTimerViewController ()

@property (strong, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) IBOutlet UIButton *button;
@property (nonatomic, strong) CircleView * cv;
@property (nonatomic, strong) NSTimer * t;


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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newRound:) name:NewRoundTimeNotificationName object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateLabel) name:SecondTickNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateButton) name:TimerCompleteNotification object:nil];
    
    
}


-(void)unRegisterForNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NewRoundTimeNotificationName object:nil];
    //    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"button" object:nil];
    //    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"label" object:nil];
    
}

-(void)dealloc {
    [self unRegisterForNotification];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.label.layer.cornerRadius = 100;
    self.label.layer.masksToBounds = YES;
    
    CircleView * cv = [[CircleView alloc] initWithFrame:CGRectMake(self.label.frame.origin.x -20, self.label.frame.origin.y -20, 240 , 240)];
    
    cv.percent = 1.0/60.0;
    [self.view insertSubview:cv belowSubview:self.label];
    self.cv = cv;
    cv.backgroundColor = [UIColor whiteColor];
    
    cv.backgroundColor = self.view.backgroundColor;
    
    
    
    [self updateLabel];
}

-(void)onSecond {
    float cur = self.cv.percent;
    float new = cur+ (1.0/60.0);
    if (new > 1.0f) new = 0;
    self.cv.percent = new;
    [self.cv setNeedsDisplay];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)buttonPressed:(id)sender {
    [[POTimer sharedInstance] startTimer];
    NSTimer * t =[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(onSecond) userInfo:nil repeats:YES];
    self.t = t;
    self.button.enabled = NO;
    [self.button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];

}


-(void)newRound:(NSNotification *)notification {
    [self updateLabel];
    [self updateButton];
}



-(void)updateLabel {
    if ([POTimer sharedInstance].seconds < 10) {
        self.label.text = [NSString stringWithFormat:@"%ld:0%ld",(long)[POTimer sharedInstance].minutes, (long)[POTimer sharedInstance].seconds];
    }
    else {
        self.label.text = [NSString stringWithFormat:@"%ld:%ld",(long)[POTimer sharedInstance].minutes, (long)[POTimer sharedInstance].seconds];
    }
}

-(void)updateButton {
    self.button.enabled = YES;
    [self.button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
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
