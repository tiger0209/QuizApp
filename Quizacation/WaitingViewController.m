//
//  WaitingViewController.m
//  Quizacation
//
//  Created by Maksym on 2/16/15.
//  Copyright © 2015 Maksym. All rights reserved.
//

#import "WaitingViewController.h"
#import "GameSet.h"
#import "LogInSuccessViewController.h"

@interface WaitingViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UIImageView *bg_imgView;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UIButton *canceBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconImageView_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *icon_imageView_height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentLabel_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cancelBtn_bottom;


@end

@implementation WaitingViewController

@synthesize m_category_id;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    switch (m_category_id) {
        case CTGY_SCIENCE:
            self.iconImageView.image = [UIImage imageNamed:@"h2h_wait_science_icon"];
            self.bg_imgView.image = [UIImage imageNamed:@"h2h_wait_science_bg"];
            break;
        case CTGY_ELECTIVES:
            self.iconImageView.image = [UIImage imageNamed:@"h2h_wait_elec_icon"];
            self.bg_imgView.image = [UIImage imageNamed:@"h2h_wait_elec_bg"];
            break;
        case CTGY_ENGLISH:
            self.iconImageView.image = [UIImage imageNamed:@"h2h_wait_elec_icon"];
            self.bg_imgView.image = [UIImage imageNamed:@"h2h_wait_elec_bg"];
            break;
        case CTGY_HISTORY:
            self.iconImageView.image = [UIImage imageNamed:@"h2h_wait_history_icon"];
            self.bg_imgView.image = [UIImage imageNamed:@"h2h_wait_history_bg"];
            break;
        case CTGY_MATH:
            self.iconImageView.image = [UIImage imageNamed:@"h2h_wait_math_icon"];
            self.bg_imgView.image = [UIImage imageNamed:@"h2h_wait_math_bg"];
            break;
        case CTGY_SPORTS:
            self.iconImageView.image = [UIImage imageNamed:@"h2h_wait_sport_icon"];
            self.bg_imgView.image = [UIImage imageNamed:@"h2h_wait_sport_bg"];
            break;
        case CTGY_ART:
            self.iconImageView.image = [UIImage imageNamed:@"h2h_wait_art_icon"];
            self.bg_imgView.image = [UIImage imageNamed:@"h2h_wait_art_bg"];
            break;
            
        default:
            break;
    }
    
    [self adjust_constraints];
    g_GameSet.g_cur_viewcontroller = self;
}

- (void) loadNewScreen
{
    switch (m_category_id) {
        case CTGY_SCIENCE:
            self.iconImageView.image = [UIImage imageNamed:@"h2h_wait_science_icon"];
            self.bg_imgView.image = [UIImage imageNamed:@"h2h_wait_science_bg"];
            break;
        case CTGY_ELECTIVES:
            self.iconImageView.image = [UIImage imageNamed:@"h2h_wait_elec_icon"];
            self.bg_imgView.image = [UIImage imageNamed:@"h2h_wait_elec_bg"];
            break;
        case CTGY_ENGLISH:
            self.iconImageView.image = [UIImage imageNamed:@"h2h_wait_elec_icon"];
            self.bg_imgView.image = [UIImage imageNamed:@"h2h_wait_elec_bg"];
            break;
        case CTGY_HISTORY:
            self.iconImageView.image = [UIImage imageNamed:@"h2h_wait_history_icon"];
            self.bg_imgView.image = [UIImage imageNamed:@"h2h_wait_history_bg"];
            break;
        case CTGY_MATH:
            self.iconImageView.image = [UIImage imageNamed:@"h2h_wait_math_icon"];
            self.bg_imgView.image = [UIImage imageNamed:@"h2h_wait_math_bg"];
            break;
        case CTGY_SPORTS:
            self.iconImageView.image = [UIImage imageNamed:@"h2h_wait_sport_icon"];
            self.bg_imgView.image = [UIImage imageNamed:@"h2h_wait_sport_bg"];
            break;
        case CTGY_ART:
            self.iconImageView.image = [UIImage imageNamed:@"h2h_wait_art_icon"];
            self.bg_imgView.image = [UIImage imageNamed:@"h2h_wait_art_bg"];
            break;
            
        default:
            break;
    }

}

- (void) adjust_constraints
{
    if (g_GameSet.g_curDeviceModel == IPHONE_5) {
        
    }
    else if (g_GameSet.g_curDeviceModel == IPHONE_6) {
        
        self.iconImageView_top.constant *= 1.2f;
        self.icon_imageView_height.constant *= 1.2f;
        self.commentLabel_top.constant *= 1.2f;
        self.cancelBtn_bottom.constant *= 1.2f;
        
        [self.commentLabel setFont:[UIFont systemFontOfSize:18]];
        [self.canceBtn.titleLabel setFont:[UIFont systemFontOfSize:25]];
    }
    else if (g_GameSet.g_curDeviceModel == IPHONE_6_PLUS) {
        self.iconImageView_top.constant *= 1.3f;
        self.icon_imageView_height.constant *= 1.3f;
        self.commentLabel_top.constant *= 1.3f;
        self.cancelBtn_bottom.constant *= 1.3f;
        
        [self.commentLabel setFont:[UIFont systemFontOfSize:18]];
        [self.canceBtn.titleLabel setFont:[UIFont systemFontOfSize:25]];

    }
    else if (g_GameSet.g_curDeviceModel == IPHONE_4) {
        self.iconImageView_top.constant *= 0.8f;
        self.icon_imageView_height.constant *= 0.8f;
        self.commentLabel_top.constant *= 0.8f;
        self.cancelBtn_bottom.constant *= 0.8f;
        
        [self.commentLabel setFont:[UIFont systemFontOfSize:13]];
        [self.canceBtn.titleLabel setFont:[UIFont systemFontOfSize:18]];

    }
    
}

- (IBAction)onCancelBtn:(id)sender {
    
//    UIStoryboard *storyboard;
//    if (g_GameSet.g_curDeviceModel == IPAD)
//    {
//        storyboard = [UIStoryboard storyboardWithName:@"Main_iPad"
//                                               bundle:nil];
//        
//    }else{
//        storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone"
//                                               bundle:nil];
//    }
//
//    LogInSuccessViewController *spinView =
//    (LogInSuccessViewController *)
//    [storyboard instantiateViewControllerWithIdentifier:@"LogInSuccessViewController"];
//    
//    [g_GameSet.g_cur_viewcontroller showViewController:spinView sender:nil];
    
    //////Notification
    [self inform_cancel_toAnother];
    
//    [g_GameSet h2h_cofig_init];

}


- (void)inform_cancel_toAnother
{
    //////mmm mmm mmm
    NSString *user_id, *invite_id;

    user_id = g_GameSet.g_user_id;
    invite_id = g_GameSet.g_h2h_invite_user_id;

//    if (g_GameSet.g_is_master) {
//        user_id = g_GameSet.g_user_id;
//        invite_id = g_GameSet.g_h2h_invite_user_id;
//    }else{
//        invite_id = g_GameSet.g_user_id;
//        user_id = g_GameSet.g_h2h_invite_user_id;
//    }
    
    NSString *strReqeust = [NSString stringWithFormat:@"invite_user_id=%@&user_id=%@&request_type=10",invite_id, user_id];
    NSData *requestData = [strReqeust dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%ld", [requestData length]];
    
    NSMutableURLRequest* theRequest = [NSMutableURLRequest requestWithURL:H2H_MODE_URL];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [theRequest setHTTPBody:requestData];
    [NSURLConnection connectionWithRequest:theRequest delegate:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
