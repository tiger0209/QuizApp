//
//  PlayerAcceptViewController.m
//  Quizacation
//
//  Created by Maksym on 12/30/15.
//  Copyright © 2015 Maksym. All rights reserved.
//

#import "PlayerAcceptViewController.h"
#import "GameSet.h"

#import "JSON.h"


@interface PlayerAcceptViewController ()
{
    NSMutableData      *receivedHomeViewData;
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *q_small_charac_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *q_small_charac_height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *q_small_charac_width;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *title_label_leading;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *title_label_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *title_label_height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *title_label_width;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *comment_label_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *h2h_charac_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *accept_btn_top;

@property (weak, nonatomic) IBOutlet UILabel *title_label;
@property (weak, nonatomic) IBOutlet UILabel *comment_label;
@property (weak, nonatomic) IBOutlet UIButton *accept_btn;

@end

@implementation PlayerAcceptViewController

@synthesize q_small_charac_top, q_small_charac_height, q_small_charac_width, title_label_width, title_label_leading, title_label_top, title_label_height, title_label, comment_label, comment_label_top, h2h_charac_top, accept_btn, accept_btn_top;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.comment_label.text = [NSString stringWithFormat:@"%@ invited you to a head to head match!", g_GameSet.g_h2h_invite_user_name ];
    
    [self adjust_constraints];
    
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
        self.title_label_leading.constant *= 1.2f;
        self.title_label_top.constant *= 1.2f;
        self.title_label_height.constant *= 1.2f;
        //        self.title_label_width.constant *= 1.2f;
        //        self.comment_label_top.constant *= 1.2f;
        //        self.grade_label_top.constant *= 1.2f;
        //        self.h2h_charac_top.constant *= 1.2f;
        //        self.accept_btn_top.constant *= 1.2f;
        
        [self.title_label setFont:[UIFont systemFontOfSize:30]];
        [self.comment_label setFont:[UIFont systemFontOfSize:28]];
        [self.accept_btn.titleLabel setFont:[UIFont systemFontOfSize:30]];
        
    }
    else if (g_GameSet.g_curDeviceModel == IPHONE_6_PLUS) {
        self.q_small_charac_top.constant *= 1.3f;
        self.q_small_charac_height.constant *= 1.3f;
        self.q_small_charac_width.constant *= 1.3f;
        self.title_label_leading.constant *= 1.3f;
        self.title_label_top.constant *= 1.3f;
        self.title_label_height.constant *= 1.3f;
        //        self.title_label_width.constant *= 1.3f;
        //        self.comment_label_top.constant *= 1.3f;
        //        self.grade_label_top.constant *= 1.3f;
        //        self.h2h_charac_top.constant *= 1.3f;
        //        self.accept_btn_top.constant *= 1.3f;
        
        [self.title_label setFont:[UIFont systemFontOfSize:30]];
        [self.comment_label setFont:[UIFont systemFontOfSize:30]];
        [self.accept_btn.titleLabel setFont:[UIFont systemFontOfSize:30]];
    }
    else if (g_GameSet.g_curDeviceModel == IPHONE_4) {
        self.q_small_charac_top.constant *= 0.8f;
        self.q_small_charac_height.constant *= 0.8f;
        self.q_small_charac_width.constant *= 0.8f;
        self.title_label_leading.constant *= 0.8f;
        self.title_label_top.constant *= 0.8f;
        self.title_label_height.constant *= 0.8f;
        //        self.title_label_width.constant *= 0.8f;
        self.comment_label_top.constant *= 0.8f;
        self.h2h_charac_top.constant *= 0.8f;
        self.accept_btn_top.constant *= 0.8f;
        
        //        [self.title_label setFont:[UIFont systemFontOfSize:30]];
        //        [self.comment_label setFont:[UIFont systemFontOfSize:28]];
        //        [self.grade_label setFont:[UIFont systemFontOfSize:20]];
        //        [self.accept_btn.titleLabel setFont:[UIFont systemFontOfSize:30]];
    }
}

- (IBAction)onAcceptBtn:(id)sender {
    [self post_accept_request];
}

////////
- (void)post_accept_request
{
    NSString *v_invite_user_id = g_GameSet.g_h2h_invite_user_id;
    NSString *v_invite_user_name = g_GameSet.g_h2h_invite_user_name;
    NSString *v_user_id = g_GameSet.g_user_id;
    
    NSString *strReqeust = [NSString stringWithFormat:@"user_id=%@&invite_user_id=%@&request_type=3",v_user_id, v_invite_user_id];
    NSData *requestData = [strReqeust dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d", [requestData length]];
    
    NSMutableURLRequest* theRequest = [NSMutableURLRequest requestWithURL:H2H_MODE_URL];
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
    
    NSNumber *status_num =  [dic objectForKey:@"status"];
    NSArray  *data =        [dic objectForKey:@"data"];
    NSString *message =     [dic objectForKey:@"message"];
    
    int status = [status_num intValue];
    
    if (status == 1) {
        
        UIStoryboard *storyboard;
        if (g_GameSet.g_curDeviceModel == IPAD)
        {
            storyboard = [UIStoryboard storyboardWithName:@"Main_iPad"
                                                   bundle:nil];
            
        }else{
            storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone"
                                                   bundle:nil];
        }
        
        ////////Waiting OK from invited user
        
        ////////////////////////////////////
        
    }else{
        if ([UIAlertController class])
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                 {
                                     [alertController dismissViewControllerAnimated:YES completion:nil];
                                     
                                 }];
            [alertController addAction:ok];
            
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
        else
        {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [alert show];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
