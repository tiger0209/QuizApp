//
//  ViewController.m
//  Quizacation
//
//  Created by Maksym on 12/30/15.
//  Copyright © 2015 Maksym. All rights reserved.
//

#import "LogInSignUpViewController.h"
#import "GameSet.h"


@interface LogInSignUpViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *large_q_charac_Top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *large_q_charac_height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *login_btn_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *signup_btn_top;
@property (weak, nonatomic) IBOutlet UILabel *welcome_label;
@property (weak, nonatomic) IBOutlet UILabel *title_label;
@property (weak, nonatomic) IBOutlet UIButton *log_in_btn;
@property (weak, nonatomic) IBOutlet UIButton *sign_up_btn;

@end

@implementation LogInSignUpViewController
@synthesize large_q_charac_Top, large_q_charac_height, login_btn_top, signup_btn_top;
@synthesize welcome_label, title_label;
@synthesize log_in_btn, sign_up_btn;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self adjust_constraints];


}

- (void) adjust_constraints
{
    if (g_GameSet.g_curDeviceModel == IPHONE_5) {
        
        
    }
    else if (g_GameSet.g_curDeviceModel == IPHONE_6) {
        self.large_q_charac_Top.constant *= 1.2f;
        self.large_q_charac_height.constant *= 1.2f;
        self.login_btn_top.constant *= 1.2f;
        self.signup_btn_top.constant *= 1.2f;
        
        [self.welcome_label setFont:[UIFont systemFontOfSize:25]];
        [self.title_label setFont:[UIFont systemFontOfSize:50]];
        
        [self.log_in_btn.titleLabel setFont:[UIFont systemFontOfSize:30]];
        [self.sign_up_btn.titleLabel setFont:[UIFont systemFontOfSize:30]];
    }
    else if (g_GameSet.g_curDeviceModel == IPHONE_6_PLUS) {
        self.large_q_charac_Top.constant *= 1.3f;
        self.large_q_charac_height.constant *= 1.3f;
        self.login_btn_top.constant *= 1.3f;
        self.signup_btn_top.constant *= 1.3f;
        
        [self.welcome_label setFont:[UIFont systemFontOfSize:25]];
        [self.title_label setFont:[UIFont systemFontOfSize:50]];
        
        [self.log_in_btn.titleLabel setFont:[UIFont systemFontOfSize:30]];
        [self.sign_up_btn.titleLabel setFont:[UIFont systemFontOfSize:30]];

    }
    else if (g_GameSet.g_curDeviceModel == IPHONE_4) {
        self.large_q_charac_Top.constant *= 0.8f;
        self.large_q_charac_height.constant *= 0.95f;
        self.login_btn_top.constant *= 0.8f;
        self.signup_btn_top.constant *= 0.8f;
        
//        [self.welcome_label setFont:[UIFont systemFontOfSize:25]];
//        [self.title_label setFont:[UIFont systemFontOfSize:50]];
//        
//        [self.log_in_btn.titleLabel setFont:[UIFont systemFontOfSize:30]];
//        [self.sign_up_btn.titleLabel setFont:[UIFont systemFontOfSize:30]];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
