//
//  LogInViewController.m
//  Quizacation
//
//  Created by Maksym on 12/30/15.
//  Copyright © 2015 Maksym. All rights reserved.
//

#import "TotalPointViewController.h"
#import "GameSet.h"
#import "JSON.h"


@interface TotalPointViewController ()
{
    NSMutableData      *receivedHomeViewData;
}


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *q_small_charac_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *q_small_charac_height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *q_small_charac_width;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *title_label_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *title_label_leading;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *title_label_width;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *total_point_label_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *total_point_label_bottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *point_num_label_top;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rank_label_bottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rank_label_height;

@property (weak, nonatomic) IBOutlet UILabel *title_label;
@property (weak, nonatomic) IBOutlet UILabel *user_name_label;
@property (weak, nonatomic) IBOutlet UILabel *total_point_label;
@property (weak, nonatomic) IBOutlet UILabel *point_num_label;
@property (weak, nonatomic) IBOutlet UILabel *rank_label;


@end

@implementation TotalPointViewController

@synthesize q_small_charac_width, q_small_charac_top, q_small_charac_height, title_label_top, title_label, title_label_leading, title_label_width, total_point_label, total_point_label_bottom, total_point_label_top, point_num_label, point_num_label_top, user_name_label;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.user_name_label.text = g_GameSet.g_cur_username;

    [self adjust_constraints];
    
    [self getTotalPoint];
    
    g_GameSet.g_cur_viewcontroller = self;

}


- (void) adjust_constraints
{
    if (g_GameSet.g_curDeviceModel == IPHONE_5) {
        
        
    }
    else if (g_GameSet.g_curDeviceModel == IPHONE_6) {
        self.title_label_top.constant *= 1.2f;
        self.q_small_charac_top.constant *= 1.2f;
        self.q_small_charac_height.constant *= 1.2f;
        self.q_small_charac_width.constant *= 1.2f;
        self.title_label_top.constant *= 1.2f;
        self.title_label_leading.constant *= 1.2f;
        self.title_label_width.constant *= 1.2f;
        self.total_point_label_top.constant *= 1.2f;
        self.total_point_label_bottom.constant *= 1.2f;
        self.point_num_label_top.constant *= 1.2f;
        
        [self.title_label setFont:[UIFont systemFontOfSize:35]];
        [self.user_name_label setFont:[UIFont systemFontOfSize:30]];
        
        [self.total_point_label setFont:[UIFont systemFontOfSize:35]];
        [self.point_num_label setFont:[UIFont systemFontOfSize:95]];
        
        [self.rank_label setFont:[UIFont systemFontOfSize:25]];
        self.rank_label_bottom.constant *= 1.2f;
        self.rank_label_height.constant *= 1.2f;
    }
    else if (g_GameSet.g_curDeviceModel == IPHONE_6_PLUS) {
        self.title_label_top.constant *= 1.3f;
        self.q_small_charac_top.constant *= 1.3f;
        self.q_small_charac_height.constant *= 1.3f;
        self.q_small_charac_width.constant *= 1.3f;
        self.title_label_top.constant *= 1.3f;
        self.title_label_leading.constant *= 1.3f;
        self.title_label_width.constant *= 1.3f;
        self.total_point_label_top.constant *= 1.3f;
        self.total_point_label_bottom.constant *= 1.3f;
        self.point_num_label_top.constant *= 1.3f;
        
        [self.title_label setFont:[UIFont systemFontOfSize:35]];
        [self.user_name_label setFont:[UIFont systemFontOfSize:30]];
        
        [self.total_point_label setFont:[UIFont systemFontOfSize:35]];
        [self.point_num_label setFont:[UIFont systemFontOfSize:95]];
        
        [self.rank_label setFont:[UIFont systemFontOfSize:25]];
        self.rank_label_bottom.constant *= 1.3f;
        self.rank_label_height.constant *= 1.3f;

        
    }
    else if (g_GameSet.g_curDeviceModel == IPHONE_4) {
        self.title_label_top.constant *= 0.8f;
        self.q_small_charac_top.constant *= 0.8f;
        self.q_small_charac_height.constant *= 0.8f;
        self.q_small_charac_width.constant *= 0.8f;
        self.title_label_top.constant *= 0.8f;
        self.title_label_leading.constant *= 0.8f;
        self.title_label_width.constant *= 1.0f;
        self.total_point_label_top.constant *= 0.8f;
        self.total_point_label_bottom.constant *= 0.8f;
        self.point_num_label_top.constant *= 0.8f;
        
        [self.rank_label setFont:[UIFont systemFontOfSize:15]];
        self.rank_label_bottom.constant *= 0.8f;
        self.rank_label_height.constant *= 0.8f;

//        [self.title_label setFont:[UIFont systemFontOfSize:50]];
//        [self.user_name_label setFont:[UIFont systemFontOfSize:30]];
//        
//        [self.total_point_label setFont:[UIFont systemFontOfSize:25]];
//        [self.point_num_label setFont:[UIFont systemFontOfSize:25]];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)getTotalPoint
{
    NSString *strReqeust = [NSString stringWithFormat:@"user_id=%@&blog_id=%@&request_type=1",g_GameSet.g_user_id, g_GameSet.g_blog_id];
    
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
    
    int v_status = [dic objectForKey:@"status"];
    NSDictionary *v_total_num_dic = [dic objectForKey:@"data"];
    NSString *v_message = [dic objectForKey:@"message"];
    NSString *v_total_num = [v_total_num_dic objectForKey:@"total_points"];
    NSString *v_rank = [v_total_num_dic objectForKey:@"rank"];
    
    
    self.point_num_label.text = v_total_num;
    self.rank_label.text = [NSString stringWithFormat:@"Ranking : %@", v_rank ];
}


@end
