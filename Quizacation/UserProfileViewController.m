//
//  UserProfileViewController.m
//  Quizacation
//
//  Created by Maksym on 12/30/15.
//  Copyright © 2015 Maksym. All rights reserved.
//

#import "UserProfileViewController.h"
#import "GameSet.h"


@interface UserProfileViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *q_small_charac_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *q_small_charac_leading;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *q_small_charac_height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *q_small_charac_width;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *title_label_leading;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *title_label_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *title_label_height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *title_label_width;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *total_point_btn_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *total_point_btn_bottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sub_stat_btn_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *h2h_btn_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *medals_btn_top;



@property (weak, nonatomic) IBOutlet UILabel *title_label;
@property (weak, nonatomic) IBOutlet UILabel *user_name_label;
@property (weak, nonatomic) IBOutlet UIButton *total_point_btn;
@property (weak, nonatomic) IBOutlet UIButton *sub_stat_btn;
@property (weak, nonatomic) IBOutlet UIButton *h2h_btn;
@property (weak, nonatomic) IBOutlet UIButton *medals_btn;


@end

@implementation UserProfileViewController

@synthesize q_small_charac_height, q_small_charac_leading, q_small_charac_top, q_small_charac_width, title_label_top, title_label, title_label_height, title_label_leading, title_label_width, total_point_btn, total_point_btn_bottom, total_point_btn_top, sub_stat_btn, sub_stat_btn_top, h2h_btn, h2h_btn_top, medals_btn, medals_btn_top;

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
        self.q_small_charac_top.constant *= 1.2f;
        self.q_small_charac_leading.constant *= 1.2f;
        self.q_small_charac_height.constant *= 1.2f;
        self.q_small_charac_width.constant *= 1.2f;
        self.title_label_leading.constant *= 1.2f;
        self.title_label_top.constant *= 1.2f;
        self.title_label_height.constant *= 1.2f;
//        self.title_label_width.constant *= 1.2f;
        self.total_point_btn_top.constant *= 1.2f;
        self.total_point_btn_bottom.constant *= 1.2f;
        self.sub_stat_btn_top.constant *= 1.2f;
        self.h2h_btn_top.constant *= 1.2f;
        self.medals_btn_top.constant *= 1.2f;
        
        
        
        [self.title_label setFont:[UIFont systemFontOfSize:30]];
        [self.user_name_label setFont:[UIFont systemFontOfSize:30]];
        
        [self.total_point_btn.titleLabel setFont:[UIFont systemFontOfSize:30]];
        [self.sub_stat_btn.titleLabel setFont:[UIFont systemFontOfSize:30]];
        [self.h2h_btn.titleLabel setFont:[UIFont systemFontOfSize:30]];
        [self.medals_btn.titleLabel setFont:[UIFont systemFontOfSize:30]];
    }
    else if (g_GameSet.g_curDeviceModel == IPHONE_6_PLUS) {
        self.q_small_charac_top.constant *= 1.3f;
        self.q_small_charac_leading.constant *= 1.3f;
        self.q_small_charac_height.constant *= 1.3f;
        self.q_small_charac_width.constant *= 1.3f;
        self.title_label_leading.constant *= 1.3f;
        self.title_label_top.constant *= 1.3f;
        self.title_label_height.constant *= 1.3f;
//        self.title_label_width.constant *= 1.3f;
        self.total_point_btn_top.constant *= 1.3f;
        self.total_point_btn_bottom.constant *= 1.3f;
        self.sub_stat_btn_top.constant *= 1.3f;
        self.h2h_btn_top.constant *= 1.3f;
        self.medals_btn_top.constant *= 1.3f;
        
        
        
        [self.title_label setFont:[UIFont systemFontOfSize:30]];
        [self.user_name_label setFont:[UIFont systemFontOfSize:30]];
        
        [self.total_point_btn.titleLabel setFont:[UIFont systemFontOfSize:30]];
        [self.sub_stat_btn.titleLabel setFont:[UIFont systemFontOfSize:30]];
        [self.h2h_btn.titleLabel setFont:[UIFont systemFontOfSize:30]];
        [self.medals_btn.titleLabel setFont:[UIFont systemFontOfSize:30]];
    }
    else if (g_GameSet.g_curDeviceModel == IPHONE_4) {
        self.q_small_charac_top.constant *= 0.8f;
        self.q_small_charac_leading.constant *= 0.8f;
        self.q_small_charac_height.constant *= 0.8f;
        self.q_small_charac_width.constant *= 0.8f;
        self.title_label_leading.constant *= 0.8f;
        self.title_label_top.constant *= 0.8f;
        self.title_label_height.constant *= 0.8f;
//        self.title_label_width.constant *= 0.8f;
        self.total_point_btn_top.constant *= 0.8f;
        self.total_point_btn_bottom.constant *= 0.8f;
        self.sub_stat_btn_top.constant *= 0.8f;
        self.h2h_btn_top.constant *= 0.8f;
        self.medals_btn_top.constant *= 0.8f;
        
        
        
//        [self.title_label setFont:[UIFont systemFontOfSize:35]];
//        [self.user_name_label setFont:[UIFont systemFontOfSize:27]];
//        
//        [self.total_point_btn.titleLabel setFont:[UIFont systemFontOfSize:30]];
//        [self.sub_stat_btn.titleLabel setFont:[UIFont systemFontOfSize:30]];
//        [self.h2h_btn.titleLabel setFont:[UIFont systemFontOfSize:30]];
//        [self.medals_btn.titleLabel setFont:[UIFont systemFontOfSize:30]];

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
