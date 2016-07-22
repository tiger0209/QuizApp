//
//  RandomResultOverViewController.m
//  Quizacation
//
//  Created by Maksym on 2/9/16.
//  Copyright © 2016 Maksym. All rights reserved.
//

#import "RandomResultOverViewController.h"
#import "GameSet.h"
#import "ResultTableCell.h"
#import "RandomRateOverViewController.h"
#import "JSON.h"


@interface RandomResultOverViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableData      *receivedHomeViewData;

}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *q_small_charac_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *q_small_charac_height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *q_small_charac_width;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *q_small_charac_leading;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *quiz_title_leading;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *quiz_title_width;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *quiz_title_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *quiz_title_height;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *result_table_frame_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *result_table_frame_height;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableview_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableview_height;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *table_title_label_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *table_label_height;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *submit_btn_top;

@property (weak, nonatomic) IBOutlet UILabel *quiz_title_label;
@property (weak, nonatomic) IBOutlet UILabel *table_title_label;
@property (weak, nonatomic) IBOutlet UITableView *resultTableView;
@property (weak, nonatomic) IBOutlet UIButton *submit_btn;


@property (strong, nonatomic) NSArray *m_quiz_result_arr;

@property (assign, nonatomic) int m_total_point;
@property (assign, nonatomic) int m_total_time;




@end

@implementation RandomResultOverViewController

@synthesize q_small_charac_height, q_small_charac_top, q_small_charac_width, q_small_charac_leading, quiz_title_leading, quiz_title_width, quiz_title_top, quiz_title_height,
    result_table_frame_top, result_table_frame_height, tableview_top, tableview_height,
    table_title_label_top, table_label_height, submit_btn_top,
    quiz_title_label, table_title_label, resultTableView, submit_btn, m_total_point, m_total_time;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    ////
    self.m_quiz_result_arr = g_GameSet.g_random_quiz_result_Arr;
    for (RandomQuizResultClass *quiz in self.m_quiz_result_arr) {
        self.m_total_point += quiz.total_point;
        self.m_total_time += quiz.total_time;
    }

    /////
    
    // Register the table cell
    [self.resultTableView registerNib:[UINib nibWithNibName:@"ResultTableCell" bundle:nil] forCellReuseIdentifier:@"ResultTableCell_identifier"];

    [self.resultTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.resultTableView setScrollEnabled:YES];
    
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
        self.q_small_charac_leading.constant *= 1.2f;

        self.quiz_title_leading.constant *= 1.2f;
        self.quiz_title_top.constant *= 1.2f;
        self.quiz_title_width.constant *= 1.2f;
        self.quiz_title_height.constant *= 1.2f;
        
        self.result_table_frame_top.constant *= 1.2f;
        self.result_table_frame_height.constant *= 1.2f;

        self.tableview_top.constant *= 1.2f;
        self.tableview_height.constant *= 1.2f;
        
        self.table_title_label_top.constant *= 1.2f;
        self.table_label_height.constant *= 1.2f;
        
        
        [self.quiz_title_label setFont:[UIFont systemFontOfSize:30]];
        [self.table_title_label setFont:[UIFont systemFontOfSize:25]];
        
    }
    else if (g_GameSet.g_curDeviceModel == IPHONE_6_PLUS) {
        self.q_small_charac_top.constant *= 1.3f;
        self.q_small_charac_height.constant *= 1.3f;
        self.q_small_charac_width.constant *= 1.3f;
        self.q_small_charac_leading.constant *= 1.3f;
        
        self.quiz_title_leading.constant *= 1.3f;
        self.quiz_title_top.constant *= 1.3f;
        self.quiz_title_width.constant *= 1.3f;
        self.quiz_title_height.constant *= 1.3f;
        
        self.result_table_frame_top.constant *= 1.3f;
        self.result_table_frame_height.constant *= 1.3f;
        
        self.tableview_top.constant *= 1.3f;
        self.tableview_height.constant *= 1.3f;
        
        self.table_title_label_top.constant *= 1.3f;
        self.table_label_height.constant *= 1.3f;
        
        
        [self.quiz_title_label setFont:[UIFont systemFontOfSize:30]];
        [self.table_title_label setFont:[UIFont systemFontOfSize:25]];
    }
    else if (g_GameSet.g_curDeviceModel == IPHONE_4) {
        self.q_small_charac_top.constant *= 0.8f;
        self.q_small_charac_height.constant *= 0.8f;
        self.q_small_charac_width.constant *= 0.8f;
        self.q_small_charac_leading.constant *= 0.8f;
        
        self.quiz_title_leading.constant *= 0.8f;
        self.quiz_title_top.constant *= 0.8f;
        self.quiz_title_width.constant *= 0.8f;
        self.quiz_title_height.constant *= 0.8f;
        
        self.result_table_frame_top.constant *= 0.8f;
        self.result_table_frame_height.constant *= 0.8f;
        
        self.tableview_top.constant *= 0.8f;
        self.tableview_height.constant *= 0.8f;
        
        self.table_title_label_top.constant *= 0.8f;
        self.table_label_height.constant *= 0.8f;
        
        
//        [self.quiz_title_label setFont:[UIFont systemFontOfSize:30]];
//        [self.table_title_label setFont:[UIFont systemFontOfSize:25]];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDataSource & UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.m_quiz_result_arr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ResultTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ResultTableCell_identifier"];
    
    NSString *quiz_problem, *result_status;
    
    QuizResultClass *result = [self.m_quiz_result_arr objectAtIndex:indexPath.row];
    
    quiz_problem = [NSString stringWithFormat:@"%ld. %@",  indexPath.row + 1, result.quiz_title ];
    result_status = result.quiz_result_status;
    
    cell.quizProblem_label.text = quiz_problem;
    cell.resultStatus_label.text = result_status;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float height = 60.0f;
    if (g_GameSet.g_curDeviceModel == IPHONE_5) {
        height *= 1.0f;
    }
    else if (g_GameSet.g_curDeviceModel == IPHONE_6) {
        height *= 1.2f;
    }
    else if (g_GameSet.g_curDeviceModel == IPHONE_6_PLUS) {
        height *= 1.3f;
    }
    else if (g_GameSet.g_curDeviceModel == IPAD) {
        height *= 1.92f;
    }
    else if (g_GameSet.g_curDeviceModel == IPHONE_4) {
        height *= 0.8f;
    }
    return height;
}
- (IBAction)onSubmitBtn:(id)sender {
    [g_GameSet.g_random_quiz_result_Arr removeAllObjects];
    
    [self inform_randomRequest];
//    [self sendArray];
}

- (void)inform_randomRequest
{
    int v_insert_id = g_GameSet.g_insert_id;
    NSString *strReqeust = [NSString stringWithFormat:@"user_id=%@&blog_id=%@&request_type=3&total_points=%d&play_time=%d&insert_id=%d",g_GameSet.g_user_id, g_GameSet.g_blog_id, self.m_total_point, self.m_total_time*1000, v_insert_id];
    NSData *requestData = [strReqeust dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu", [requestData length]];
    
    NSMutableURLRequest* theRequest = [NSMutableURLRequest requestWithURL:RANDOM_MODE_URL];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [theRequest setHTTPBody:requestData];
    [NSURLConnection connectionWithRequest:theRequest delegate:self];
    
}

//-(void)sendArray {
//    NSArray *array = self.m_quiz_result_arr;
//    NSData *post = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:nil];
//    NSString *postLength = [NSString stringWithFormat:@"%d", [post length]];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:RANDOM_MODE_URL];
//    [request setHTTPMethod:@"POST"];
//    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
//    [request setHTTPBody:post];
//    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
//    [request setTimeoutInterval:5];
//    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//    [NSURLConnection connectionWithRequest:request delegate:self];
//    
//    
//}

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
    
    NSNumber *status_num = [dic objectForKey:@"status"];
    NSArray *data = [dic objectForKey:@"data"];
    NSString *message = [dic objectForKey:@"message"];
    
    int status = [status_num intValue];
    
    if (status == 1) {
        
        for( NSDictionary * d in data )
        {
            NSString *v_username = [d objectForKey:@"name"];
            int   v_point = [[d objectForKey:@"total_points"] intValue];
            int v_time = [[d objectForKey:@"play_time"] intValue];
            
            //////0208
            RandomQuizRateClass *v_quiz = [[RandomQuizRateClass alloc] init];
            
            v_quiz.m_userName = v_username;
            v_quiz.m_point = v_point;
            v_quiz.m_time = v_time;
            
            g_GameSet.g_game_mode = RANDOM_MODE;
            [g_GameSet.g_randomQuiz_rate_Arr addObject:v_quiz];
            
        }
        
        UIStoryboard *storyboard;
        if (g_GameSet.g_curDeviceModel == IPAD)
        {
            storyboard = [UIStoryboard storyboardWithName:@"Main_iPad"
                                                   bundle:nil];
            
        }else{
            storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone"
                                                   bundle:nil];
        }
        
        RandomRateOverViewController *response_view =
        (RandomRateOverViewController *)
        [storyboard instantiateViewControllerWithIdentifier:@"RandomRateOverViewController"];
//        [self presentViewController:response_view animated:YES completion:nil];
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

@end
