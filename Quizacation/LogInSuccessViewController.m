//
//  LogInSuccessViewController.m
//  Quizacation
//
//  Created by Maksym on 12/30/15.
//  Copyright © 2015 Maksym. All rights reserved.
//

#import "LogInSuccessViewController.h"
#import "GameSet.h"

@interface LogInSuccessViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *title_label_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *large_q_charac_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *large_q_charac_height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *user_name_label_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *user_name_label_bottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *play_btn_top;

@property (weak, nonatomic) IBOutlet UILabel *user_name_label;
@property (weak, nonatomic) IBOutlet UILabel *title_label;
@property (weak, nonatomic) IBOutlet UILabel *welcome_label;

@property (weak, nonatomic) IBOutlet UIButton *view_profile_btn;
@property (weak, nonatomic) IBOutlet UIButton *play_btn;


@end

@implementation LogInSuccessViewController

@synthesize title_label_top, large_q_charac_top, large_q_charac_height, user_name_label, user_name_label_bottom, user_name_label_top, play_btn, play_btn_top, view_profile_btn;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.user_name_label.text = g_GameSet.g_cur_username;
    
    [self adjust_constraints];
    
    g_GameSet.g_cur_viewcontroller = self;
}

- (void) adjust_constraints
{
    if (g_GameSet.g_curDeviceModel == IPHONE_5) {
        
        
    }
    else if (g_GameSet.g_curDeviceModel == IPHONE_6) {
        self.title_label_top.constant *= 1.2f;
        self.large_q_charac_top.constant *= 1.2f;
        self.large_q_charac_height.constant *= 1.2f;
        self.user_name_label_top.constant *= 1.2f;
        self.user_name_label_bottom.constant *= 1.2f;
        self.play_btn_top.constant *= 1.2f;
        
        [self.title_label setFont:[UIFont systemFontOfSize:50]];
        
        [self.welcome_label setFont:[UIFont systemFontOfSize:25]];
        [self.user_name_label setFont:[UIFont systemFontOfSize:30]];
        
        [self.view_profile_btn.titleLabel setFont:[UIFont systemFontOfSize:30]];
        [self.play_btn.titleLabel setFont:[UIFont systemFontOfSize:30]];
    }
    else if (g_GameSet.g_curDeviceModel == IPHONE_6_PLUS) {
        self.title_label_top.constant *= 1.3f;
        self.large_q_charac_top.constant *= 1.3f;
        self.large_q_charac_height.constant *= 1.3f;
        self.user_name_label_top.constant *= 1.3f;
        self.user_name_label_bottom.constant *= 1.3f;
        self.play_btn_top.constant *= 1.3f;
        
        [self.title_label setFont:[UIFont systemFontOfSize:50]];
        
        [self.welcome_label setFont:[UIFont systemFontOfSize:25]];
        [self.user_name_label setFont:[UIFont systemFontOfSize:30]];
        
        [self.view_profile_btn.titleLabel setFont:[UIFont systemFontOfSize:30]];
        [self.play_btn.titleLabel setFont:[UIFont systemFontOfSize:30]];
        
    }
    else if (g_GameSet.g_curDeviceModel == IPHONE_4) {
        self.title_label_top.constant *= 0.8f;
        self.large_q_charac_top.constant *= 0.8f;
        self.large_q_charac_height.constant *= 0.95f;
        self.user_name_label_top.constant *= 0.8f;
        self.user_name_label_bottom.constant *= 0.8f;
        self.play_btn_top.constant *= 0.8f;
        
//        [self.title_label setFont:[UIFont systemFontOfSize:50]];
//        
//        [self.welcome_label setFont:[UIFont systemFontOfSize:25]];
//        [self.user_name_label setFont:[UIFont systemFontOfSize:30]];
//        
//        [self.view_profile_btn.titleLabel setFont:[UIFont systemFontOfSize:30]];
//        [self.play_btn.titleLabel setFont:[UIFont systemFontOfSize:30]];

    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
