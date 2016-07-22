//
//  PlaymodeSelViewController..m
//  Quizacation
//
//  Created by Maksym on 12/30/15.
//  Copyright © 2015 Maksym. All rights reserved.
//

#import "PlaymodeSelViewController.h"
#import "GameSet.h"

#import "RandomRespViewController.h"
#import "PlayerSelViewController.h"

#import "JSON.h"



@interface PlaymodeSelViewController ()
{
    NSMutableData      *receivedHomeViewData;
}


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *title_label_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *large_q_charac_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *large_q_charac_height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *question_label_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *random_btn_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *h2h_btn_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *special_quiz_btn_top;



@property (weak, nonatomic) IBOutlet UILabel *title_label;
@property (weak, nonatomic) IBOutlet UILabel *question_label;
@property (weak, nonatomic) IBOutlet UIButton *random_btn;
@property (weak, nonatomic) IBOutlet UIButton *h2h_btn;
@property (weak, nonatomic) IBOutlet UIButton *special_quiz_btn;


@property (assign, nonatomic) BOOL     is_random_click;
@property (assign, nonatomic) BOOL     is_h2h_click;


@end

@implementation PlaymodeSelViewController

@synthesize title_label, title_label_top, large_q_charac_height, large_q_charac_top, question_label, question_label_top, random_btn, random_btn_top, h2h_btn_top, h2h_btn, special_quiz_btn, special_quiz_btn_top;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.is_random_click = false;
    self.is_h2h_click = false;
    
    // Do any additional setup after loading the view, typically from a nib.
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
        self.question_label_top.constant *= 1.2f;
        self.random_btn_top.constant *= 1.1f;
        self.h2h_btn_top.constant *= 1.1f;
        self.special_quiz_btn_top.constant *= 1.1f;
        
        [self.title_label setFont:[UIFont systemFontOfSize:50]];
        [self.question_label setFont:[UIFont systemFontOfSize:25]];
        
        [self.random_btn.titleLabel setFont:[UIFont systemFontOfSize:30]];
        [self.h2h_btn.titleLabel setFont:[UIFont systemFontOfSize:30]];
        [self.special_quiz_btn.titleLabel setFont:[UIFont systemFontOfSize:30]];
    }
    else if (g_GameSet.g_curDeviceModel == IPHONE_6_PLUS) {
        self.title_label_top.constant *= 1.3f;
        self.large_q_charac_top.constant *= 1.3f;
        self.large_q_charac_height.constant *= 1.3f;
        self.question_label_top.constant *= 1.3f;
        self.random_btn_top.constant *= 1.1f;
        self.h2h_btn_top.constant *= 1.1f;
        self.special_quiz_btn_top.constant *= 1.1f;
        
        [self.title_label setFont:[UIFont systemFontOfSize:50]];
        [self.question_label setFont:[UIFont systemFontOfSize:25]];
        
        [self.random_btn.titleLabel setFont:[UIFont systemFontOfSize:30]];
        [self.h2h_btn.titleLabel setFont:[UIFont systemFontOfSize:30]];
        [self.special_quiz_btn.titleLabel setFont:[UIFont systemFontOfSize:30]];
    }
    else if (g_GameSet.g_curDeviceModel == IPHONE_4) {
        self.title_label_top.constant *= 0.8f;
        self.large_q_charac_top.constant *= 0.8f;
        self.large_q_charac_height.constant *= 0.95f;
        self.question_label_top.constant *= 0.8f;
        self.random_btn_top.constant *= 0.8f;
        self.h2h_btn_top.constant *= 0.8f;
        self.special_quiz_btn_top.constant *= 0.8f;
        
//        [self.title_label setFont:[UIFont systemFontOfSize:50]];
//        [self.question_label setFont:[UIFont systemFontOfSize:25]];
//        
//        [self.random_btn.titleLabel setFont:[UIFont systemFontOfSize:30]];
//        [self.h2h_btn.titleLabel setFont:[UIFont systemFontOfSize:30]];
//        [self.special_quiz_btn.titleLabel setFont:[UIFont systemFontOfSize:30]];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onRandomBtn:(id)sender {
    [self inform_randomRequest];
    self.is_random_click = true;
}
- (IBAction)onHead2Btn:(id)sender {
    [self inform_h2hRequest];
    self.is_h2h_click = true;
}


- (void)inform_randomRequest
{
    NSString *strReqeust = [NSString stringWithFormat:@"user_id=%@&blog_id=%@&request_type=1&category=1",g_GameSet.g_user_id, g_GameSet.g_blog_id];
    NSData *requestData = [strReqeust dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%ld", [requestData length]];
    
    NSMutableURLRequest* theRequest = [NSMutableURLRequest requestWithURL:RANDOM_MODE_URL];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [theRequest setHTTPBody:requestData];
    [NSURLConnection connectionWithRequest:theRequest delegate:self];
    
}

- (void)inform_h2hRequest
{
    NSString *strReqeust = [NSString stringWithFormat:@"user_id=%@&blog_id=%@&request_type=1",g_GameSet.g_user_id, g_GameSet.g_blog_id];
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
    
    /////Head To Head Mode
    if (self.is_h2h_click) {
        NSNumber *status_num =  [dic objectForKey:@"status"];
        NSArray  *data =        [dic objectForKey:@"data"];
        NSString *message =     [dic objectForKey:@"message"];
        
        int status = [status_num intValue];
        
        if (status == 1) {
            
            g_GameSet.g_h2h_user_Arr = [data mutableCopy];            
            g_GameSet.g_game_mode = HEAD_2_HEAD_MODE;

            UIStoryboard *storyboard;
            if (g_GameSet.g_curDeviceModel == IPAD)
            {
                storyboard = [UIStoryboard storyboardWithName:@"Main_iPad"
                                                       bundle:nil];
                
            }else{
                storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone"
                                                       bundle:nil];
            }
            
            PlayerSelViewController *response_view =
            (PlayerSelViewController *)
            [storyboard instantiateViewControllerWithIdentifier:@"PlayerSelViewController"];
//            [self presentViewController:response_view animated:YES completion:nil];
            [self showViewController:response_view sender:nil];
            
            
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
    
    //////Random Mode
    if (self.is_random_click) {
        NSNumber *status_num = [dic objectForKey:@"status"];
        NSDictionary *v_data = [dic objectForKey:@"data"];
        
        NSArray  *data = [v_data objectForKey:@"data"];
        NSInteger      insert_id = [[v_data objectForKey:@"insert_id"] integerValue];
        g_GameSet.g_insert_id = insert_id;
        
        NSString *message = [dic objectForKey:@"message"];
        
        int status = [status_num intValue];
        
        if (status == 1) {
            
            for( NSDictionary * d in data )
            {
                NSString *problem_title = [d objectForKey:@"title"];
                NSMutableArray  *answers_arr = [d objectForKey:@"answers"];
                NSString *solution = [d objectForKey:@"solutions"];
                NSString *category = [d objectForKey:@"category"];
                
                //////0208
                QuizClass *v_quiz = [[QuizClass alloc] init];
                
                //////////random arrange correct answer
                int ran_idx = arc4random() % 4;
                
                ////test test test
                NSLog(@"########### ran_idx = %d ###########", ran_idx);
                
                if (ran_idx == 0) {
                    v_quiz.answers_arr = answers_arr;
                    v_quiz.solution = solution;
                }else{
                    NSString *correct_one = [answers_arr objectAtIndex:0];
                    NSString *replace_one = [answers_arr objectAtIndex:ran_idx];
                    
                    [answers_arr replaceObjectAtIndex:ran_idx withObject:correct_one];
                    [answers_arr replaceObjectAtIndex:0 withObject:replace_one];
                    
                    switch (ran_idx) {
                        case 1:
                            solution = @"0100";
                            break;
                        case 2:
                            solution = @"0010";
                            break;
                        case 3:
                            solution = @"0001";
                            break;
                            
                        default:
                            break;
                    }
                    
                    v_quiz.answers_arr = answers_arr;
                    v_quiz.solution = solution;
                }
                ///////
                v_quiz.title = problem_title;
                v_quiz.category = category;
                
                g_GameSet.g_game_mode = RANDOM_MODE;
                [g_GameSet.g_randomQuiz_Arr addObject:v_quiz];
            }
            
            g_GameSet.g_randomQuiz = [g_GameSet.g_randomQuiz_Arr objectAtIndex:0];
            
            UIStoryboard *storyboard;
            if (g_GameSet.g_curDeviceModel == IPAD)
            {
                storyboard = [UIStoryboard storyboardWithName:@"Main_iPad"
                                                       bundle:nil];
                
            }else{
                storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone"
                                                       bundle:nil];
            }
            
            RandomRespViewController *response_view =
            (RandomRespViewController *)
            [storyboard instantiateViewControllerWithIdentifier:@"RandomRespViewController"];
//            [self presentViewController:response_view animated:YES completion:nil];
            [self showViewController:response_view sender:nil];
            
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
}


@end
