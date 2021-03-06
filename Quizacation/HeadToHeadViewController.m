//
//  HeadToHeadViewController.m
//  Quizacation
//
//  Created by Maksym on 12/30/15.
//  Copyright © 2015 Maksym. All rights reserved.
//

#import "HeadToHeadViewController.h"
#import "GameSet.h"
#import "JSON.h"

@interface HeadToHeadViewController ()
{
    NSMutableData      *receivedHomeViewData;
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *q_small_charac_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *q_small_charac_height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *q_small_charac_width;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *h2h_label_leading;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *h2h_label_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *h2h_label_height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *h2h_label_width;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *h2h_table_frame_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *h2h_table_frame_height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *h2h_table_frame2_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *h2h_table_frame2_height;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *player1_label_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *player1_label_height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *player1_point_label_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *player1_point_label_height;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *player2_label_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *player2_label_height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *player2_point_label_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *player2_point_label_height;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *science_icon_leading;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *math_icon_leading;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *science_icon_leading1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *math_icon_leading1;

////////////
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *science_icon_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *science_icon_height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *elective_icon_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *elective_icon_height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *eng_icon_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *eng_icon_height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *art_icon_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *art_icon_height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *math_icon_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *math_icon_height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sport_icon_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sport_icon_height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *history_icon_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *history_icon_height;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *science_icon_top_1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *science_icon_height_1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *elective_icon_top_1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *elective_icon_height_1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *eng_icon_top_1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *eng_icon_height_1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *art_icon_top_1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *art_icon_height_1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *math_icon_top_1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *math_icon_height_1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sport_icon_top_1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sport_icon_height_1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *history_icon_top_1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *history_icon_height_1;
////////////

@property (weak, nonatomic) IBOutlet UILabel *h2h_label;
@property (weak, nonatomic) IBOutlet UILabel *player1_label;
@property (weak, nonatomic) IBOutlet UILabel *player1_point_label;
@property (weak, nonatomic) IBOutlet UILabel *player2_label;
@property (weak, nonatomic) IBOutlet UILabel *player2_point_label;

@property (weak, nonatomic) IBOutlet UIImageView *main_elective;
@property (weak, nonatomic) IBOutlet UIImageView *main_science;
@property (weak, nonatomic) IBOutlet UIImageView *main_english;
@property (weak, nonatomic) IBOutlet UIImageView *main_history;
@property (weak, nonatomic) IBOutlet UIImageView *main_math;
@property (weak, nonatomic) IBOutlet UIImageView *main_sports;
@property (weak, nonatomic) IBOutlet UIImageView *main_art;


@property (weak, nonatomic) IBOutlet UIImageView *invite_elective;
@property (weak, nonatomic) IBOutlet UIImageView *invite_science;
@property (weak, nonatomic) IBOutlet UIImageView *invite_english;
@property (weak, nonatomic) IBOutlet UIImageView *invite_history;
@property (weak, nonatomic) IBOutlet UIImageView *invite_math;
@property (weak, nonatomic) IBOutlet UIImageView *invite_sports;
@property (weak, nonatomic) IBOutlet UIImageView *invite_art;


@end

@implementation HeadToHeadViewController

@synthesize q_small_charac_width, q_small_charac_top, q_small_charac_height, h2h_label_height, h2h_label_leading, h2h_label_top, h2h_label_width, h2h_table_frame2_height, h2h_table_frame2_top, h2h_table_frame_height, h2h_table_frame_top, h2h_label;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self getStealCrownData];
    
    [self adjust_constraints];
    
    self.player1_label.text = g_GameSet.g_cur_username;
    self.player2_label.text = g_GameSet.g_h2h_invite_user_name;
    
    self.player1_point_label.text = [NSString stringWithFormat: @"%d", g_GameSet.g_h2h_steal_crown_main_score];
    self.player2_point_label.text = [NSString stringWithFormat: @"%d", g_GameSet.g_h2h_steal_crown_invite_score];
    
    
    
    
    g_GameSet.g_cur_viewcontroller = self;

}


- (void) adjust_constraints
{
    if (g_GameSet.g_curDeviceModel == IPHONE_5) {
        
        
    }
    else if (g_GameSet.g_curDeviceModel == IPHONE_6) {
        self.q_small_charac_top.constant *= 1.2f;
        self.q_small_charac_height.constant *= 1.2f;
        self.q_small_charac_width.constant *= 1.2f;
        self.h2h_label_leading.constant *= 1.2f;
        self.h2h_label_top.constant *= 1.2f;
        self.h2h_label_height.constant *= 1.2f;
        self.h2h_label_width.constant *= 1.2f;
        self.h2h_table_frame_top.constant *= 1.2f;
        self.h2h_table_frame_height.constant *= 1.2f;
        self.h2h_table_frame2_top.constant *= 1.2f;
        self.h2h_table_frame2_height.constant *= 1.2f;

        self.player1_label_top.constant *= 1.2f;
        self.player1_label_height.constant *= 1.2f;
        self.player1_point_label_top.constant *= 1.2f;
        self.player1_point_label_height.constant *= 1.2f;
        self.player2_label_top.constant *= 1.2f;
        self.player2_label_height.constant *= 1.2f;
        self.player2_point_label_top.constant *= 1.2f;
        self.player2_point_label_height.constant *= 1.2f;

        self.science_icon_leading.constant *= 1.2f;
        self.math_icon_leading.constant *= 1.2f;
        self.science_icon_leading1.constant *= 1.2f;
        self.math_icon_leading1.constant *= 1.2f;

        self.science_icon_top.constant *= 1.2f;
        self.science_icon_height.constant *= 1.2f;
        self.elective_icon_top.constant *= 1.2f;
        self.elective_icon_height.constant *= 1.2f;
        self.eng_icon_top.constant *= 1.2f;
        self.eng_icon_height.constant *= 1.2f;
        self.art_icon_top.constant *= 1.2f;
        self.art_icon_height.constant *= 1.2f;
        self.math_icon_top.constant *= 1.2f;
        self.math_icon_height.constant *= 1.2f;
        self.sport_icon_top.constant *= 1.2f;
        self.sport_icon_height.constant *= 1.2f;
        self.history_icon_top.constant *= 1.2f;
        self.history_icon_height.constant *= 1.2f;

        self.science_icon_top_1.constant *= 1.2f;
        self.science_icon_height_1.constant *= 1.2f;
        self.elective_icon_top_1.constant *= 1.2f;
        self.elective_icon_height_1.constant *= 1.2f;
        self.eng_icon_top_1.constant *= 1.2f;
        self.eng_icon_height_1.constant *= 1.2f;
        self.art_icon_top_1.constant *= 1.2f;
        self.art_icon_height_1.constant *= 1.2f;
        self.math_icon_top_1.constant *= 1.2f;
        self.math_icon_height_1.constant *= 1.2f;
        self.sport_icon_top_1.constant *= 1.2f;
        self.sport_icon_height_1.constant *= 1.2f;
        self.history_icon_top_1.constant *= 1.2f;
        self.history_icon_height_1.constant *= 1.2f;

        [self.h2h_label setFont:[UIFont systemFontOfSize:30]];
        [self.player1_label setFont:[UIFont systemFontOfSize:25]];
        [self.player1_point_label setFont:[UIFont systemFontOfSize:25]];
        [self.player2_label setFont:[UIFont systemFontOfSize:25]];
        [self.player2_point_label setFont:[UIFont systemFontOfSize:25]];
        
    }
    else if (g_GameSet.g_curDeviceModel == IPHONE_6_PLUS) {
        self.q_small_charac_top.constant *= 1.3f;
        self.q_small_charac_height.constant *= 1.3f;
        self.q_small_charac_width.constant *= 1.3f;
        self.h2h_label_leading.constant *= 1.3f;
        self.h2h_label_top.constant *= 1.3f;
        self.h2h_label_height.constant *= 1.3f;
        self.h2h_label_width.constant *= 1.3f;
        self.h2h_table_frame_top.constant *= 1.3f;
        self.h2h_table_frame_height.constant *= 1.3f;
        self.h2h_table_frame2_top.constant *= 1.3f;
        self.h2h_table_frame2_height.constant *= 1.3f;
        
        self.player1_label_top.constant *= 1.3f;
        self.player1_label_height.constant *= 1.3f;
        self.player1_point_label_top.constant *= 1.3f;
        self.player1_point_label_height.constant *= 1.3f;
        self.player2_label_top.constant *= 1.3f;
        self.player2_label_height.constant *= 1.3f;
        self.player2_point_label_top.constant *= 1.3f;
        self.player2_point_label_height.constant *= 1.3f;

        self.science_icon_leading.constant *= 1.3f;
        self.math_icon_leading.constant *= 1.3f;
        self.science_icon_leading1.constant *= 1.3f;
        self.math_icon_leading1.constant *= 1.3f;

        self.science_icon_top.constant *= 1.3f;
        self.science_icon_height.constant *= 1.3f;
        self.elective_icon_top.constant *= 1.3f;
        self.elective_icon_height.constant *= 1.3f;
        self.eng_icon_top.constant *= 1.3f;
        self.eng_icon_height.constant *= 1.3f;
        self.art_icon_top.constant *= 1.3f;
        self.art_icon_height.constant *= 1.3f;
        self.math_icon_top.constant *= 1.3f;
        self.math_icon_height.constant *= 1.3f;
        self.sport_icon_top.constant *= 1.3f;
        self.sport_icon_height.constant *= 1.3f;
        self.history_icon_top.constant *= 1.3f;
        self.history_icon_height.constant *= 1.3f;
        
        self.science_icon_top_1.constant *= 1.3f;
        self.science_icon_height_1.constant *= 1.3f;
        self.elective_icon_top_1.constant *= 1.3f;
        self.elective_icon_height_1.constant *= 1.3f;
        self.eng_icon_top_1.constant *= 1.3f;
        self.eng_icon_height_1.constant *= 1.3f;
        self.art_icon_top_1.constant *= 1.3f;
        self.art_icon_height_1.constant *= 1.3f;
        self.math_icon_top_1.constant *= 1.3f;
        self.math_icon_height_1.constant *= 1.3f;
        self.sport_icon_top_1.constant *= 1.3f;
        self.sport_icon_height_1.constant *= 1.3f;
        self.history_icon_top_1.constant *= 1.3f;
        self.history_icon_height_1.constant *= 1.3f;

        [self.h2h_label setFont:[UIFont systemFontOfSize:30]];
        [self.player1_label setFont:[UIFont systemFontOfSize:25]];
        [self.player1_point_label setFont:[UIFont systemFontOfSize:25]];
        [self.player2_label setFont:[UIFont systemFontOfSize:25]];
        [self.player2_point_label setFont:[UIFont systemFontOfSize:25]];
    }
    else if (g_GameSet.g_curDeviceModel == IPHONE_4) {
        self.q_small_charac_top.constant *= 0.8f;
        self.q_small_charac_height.constant *= 0.8f;
        self.q_small_charac_width.constant *= 0.8f;
        self.h2h_label_leading.constant *= 0.8f;
        self.h2h_label_top.constant *= 0.8f;
        self.h2h_label_height.constant *= 0.8f;
//        self.h2h_label_width.constant *= 0.8f;
        self.h2h_table_frame_top.constant *= 0.8f;
        self.h2h_table_frame_height.constant *= 0.8f;
        self.h2h_table_frame2_top.constant *= 0.8f;
        self.h2h_table_frame2_height.constant *= 0.8f;

        self.science_icon_leading.constant *= 2.2f;
        self.math_icon_leading.constant *= 2.2f;
        self.science_icon_leading1.constant *= 2.2f;
        self.math_icon_leading1.constant *= 2.2f;

        self.player1_label_top.constant *= 0.8f;
        self.player1_label_height.constant *= 0.8f;
        self.player1_point_label_top.constant *= 0.8f;
        self.player1_point_label_height.constant *= 0.8f;
        self.player2_label_top.constant *= 0.8f;
        self.player2_label_height.constant *= 0.8f;
        self.player2_point_label_top.constant *= 0.8f;
        self.player2_point_label_height.constant *= 0.8f;
       
        self.science_icon_top.constant *= 0.8f;
        self.science_icon_height.constant *= 0.8f;
        self.elective_icon_top.constant *= 0.8f;
        self.elective_icon_height.constant *= 0.8f;
        self.eng_icon_top.constant *= 0.8f;
        self.eng_icon_height.constant *= 0.8f;
        self.art_icon_top.constant *= 0.8f;
        self.art_icon_height.constant *= 0.8f;
        self.math_icon_top.constant *= 0.8f;
        self.math_icon_height.constant *= 0.8f;
        self.sport_icon_top.constant *= 0.8f;
        self.sport_icon_height.constant *= 0.8f;
        self.history_icon_top.constant *= 0.8f;
        self.history_icon_height.constant *= 0.8f;
        
        self.science_icon_top_1.constant *= 0.8f;
        self.science_icon_height_1.constant *= 0.8f;
        self.elective_icon_top_1.constant *= 0.8f;
        self.elective_icon_height_1.constant *= 0.8f;
        self.eng_icon_top_1.constant *= 0.8f;
        self.eng_icon_height_1.constant *= 0.8f;
        self.art_icon_top_1.constant *= 0.8f;
        self.art_icon_height_1.constant *= 0.8f;
        self.math_icon_top_1.constant *= 0.8f;
        self.math_icon_height_1.constant *= 0.8f;
        self.sport_icon_top_1.constant *= 0.8f;
        self.sport_icon_height_1.constant *= 0.8f;
        self.history_icon_top_1.constant *= 0.8f;
        self.history_icon_height_1.constant *= 0.8f;

//        [self.h2h_label setFont:[UIFont systemFontOfSize:30]];
//        [self.player1_label setFont:[UIFont systemFontOfSize:25]];
//        [self.player1_point_label setFont:[UIFont systemFontOfSize:25]];
//        [self.player2_label setFont:[UIFont systemFontOfSize:25]];
//        [self.player2_point_label setFont:[UIFont systemFontOfSize:25]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)getStealCrownData
{
    NSString *strReqeust = [NSString stringWithFormat:@"user_id=%@&blog_id=%@&request_type=3",g_GameSet.g_user_id, g_GameSet.g_blog_id];
    
    
    NSData *requestData = [strReqeust dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%ld", [requestData length]];
    
    NSMutableURLRequest* theRequest = [NSMutableURLRequest requestWithURL:PROFILE_MODE_URL];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [theRequest setHTTPBody:requestData];
    [NSURLConnection connectionWithRequest:theRequest delegate:self];
}

#pragma mark Json
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    receivedHomeViewData = [[NSMutableData alloc] init];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (data != nil)
    {
        [receivedHomeViewData appendData:data];
    }
}


#pragma mark - NSURLConnectionDataDelegate
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString     *strResult = [[NSString alloc] initWithData:receivedHomeViewData encoding:NSUTF8StringEncoding];
    NSDictionary *dic = [[NSDictionary alloc] init];
    SBJSON *jsonParse = [SBJSON new];
    dic = [jsonParse objectWithString:strResult];
    
    NSDictionary *v_data = [dic objectForKey:@"data"];
    
    
    NSDictionary     *v_last_player_info    = [v_data objectForKey:@"last_player_info"];
    NSArray          *last_player_crowns    = [v_last_player_info objectForKey:@"crowns"];
    NSString         *last_player_points    = [v_last_player_info objectForKey:@"total_points"];
    NSString         *last_player_name      = [v_last_player_info objectForKey:@"name"];


    
    NSDictionary     *v_cur_user_info       = [v_data objectForKey:@"user_info"];
    NSArray          *cur_user_crowns       = [v_cur_user_info objectForKey:@"crowns"];
    NSString         *cur_user_points       = [v_cur_user_info objectForKey:@"total_points"];
    NSString         *cur_user_name         = [v_cur_user_info objectForKey:@"name"];
    
    
    
    self.player1_label.text = cur_user_name;
    self.player2_label.text = last_player_name;
    
    self.player1_point_label.text = [NSString stringWithFormat: @"%@", cur_user_points];
    self.player2_point_label.text = [NSString stringWithFormat: @"%@", last_player_points];

    
    [self.main_science setAlpha:0.4f];
    [self.main_elective setAlpha:0.4f];
    [self.main_english setAlpha:0.4f];
    [self.main_history setAlpha:0.4f];
    [self.main_math setAlpha:0.4f];
    [self.main_sports setAlpha:0.4f];
    [self.main_art setAlpha:0.4f];

    for (NSDictionary *dic in cur_user_crowns) {
        NSString *category_name = [dic objectForKey:@"name"];
        if ([category_name isEqualToString:@"Science"]) {
            [self.main_science setAlpha:1.0f];
        }
        if ([category_name isEqualToString:@"Elective"]) {
            [self.main_elective setAlpha:1.0f];
        }
        if ([category_name isEqualToString:@"English"]) {
            [self.main_english setAlpha:1.0f];
        }
        if ([category_name isEqualToString:@"History"]) {
            [self.main_history setAlpha:1.0f];
        }
        if ([category_name isEqualToString:@"Math"]) {
            [self.main_math setAlpha:1.0f];
        }
        if ([category_name isEqualToString:@"Sports"]) {
            [self.main_sports setAlpha:1.0f];
        }
        if ([category_name isEqualToString:@"Art"]) {
            [self.main_art setAlpha:1.0f];
        }
    }
    
    [self.invite_science setAlpha:0.4f];
    [self.invite_elective setAlpha:0.4f];
    [self.invite_english setAlpha:0.4f];
    [self.invite_history setAlpha:0.4f];
    [self.invite_math setAlpha:0.4f];
    [self.invite_sports setAlpha:0.4f];
    [self.invite_art setAlpha:0.4f];
    
    if ([last_player_name isEqualToString:@""]) {
        
    }else{
        
        for (NSDictionary *dic in last_player_crowns) {
            NSString *category_name = [dic objectForKey:@"name"];
            if ([category_name isEqualToString:@"Science"]) {
                [self.invite_science setAlpha:1.0f];
            }
            if ([category_name isEqualToString:@"Elective"]) {
                [self.invite_elective setAlpha:1.0f];
            }
            if ([category_name isEqualToString:@"English"]) {
                [self.invite_english setAlpha:1.0f];
            }
            if ([category_name isEqualToString:@"History"]) {
                [self.invite_history setAlpha:1.0f];
            }
            if ([category_name isEqualToString:@"Math"]) {
                [self.invite_math setAlpha:1.0f];
            }
            if ([category_name isEqualToString:@"Sports"]) {
                [self.invite_sports setAlpha:1.0f];
            }
            if ([category_name isEqualToString:@"Art"]) {
                [self.invite_art setAlpha:1.0f];
            }
        }

    }

    
}


@end
