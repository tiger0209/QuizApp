//
//  SpecialQuizViewController.m
//  Quizacation
//
//  Created by Maksym on 12/30/15.
//  Copyright © 2015 Maksym. All rights reserved.
//

#import "SpecialQuizViewController.h"
#import "GameSet.h"
#import "JSON.h"
#import "SpecialRespViewController.h"
#import "SpecialQuizTableCell.h"


@interface SpecialQuizViewController ()
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

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableView_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableView_height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *submit_btn_top;


@property (weak, nonatomic) IBOutlet UILabel *title_label;
@property (weak, nonatomic) IBOutlet UILabel *comment_label;
@property (weak, nonatomic) IBOutlet UIButton *submit_btn;

@property (weak, nonatomic) IBOutlet UITableView *specialQuiz_tableView;


@property (strong, nonatomic) NSMutableArray *m_specialQuiz_Arr;

@property (assign, nonatomic) BOOL is_get_specialArr;
@property (assign, nonatomic) BOOL is_send_selectInfo;


@end

@implementation SpecialQuizViewController

@synthesize q_small_charac_top, q_small_charac_height, q_small_charac_width, title_label_width, title_label_leading, title_label_top, title_label_height, title_label, comment_label, comment_label_top, submit_btn;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.m_specialQuiz_Arr = [[NSMutableArray alloc] init];
    self.is_get_specialArr = NO;
    self.is_send_selectInfo = NO;
    
    // Register the table cell
    [self.specialQuiz_tableView registerNib:[UINib nibWithNibName:@"SpecialQuizTableCell" bundle:nil] forCellReuseIdentifier:@"SpecialQuizTableCell_identifier"];
    
    [self.specialQuiz_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.specialQuiz_tableView.backgroundColor = [UIColor clearColor];
    [self.specialQuiz_tableView setScrollEnabled:YES];

    [self adjust_constraints];
    
    //////
    [self getSpecialQuizData];
    
    //[self.specialQuiz_tableView reloadData];
    
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
        self.comment_label_top.constant *= 1.2f;
        
        self.tableView_top.constant *= 1.2f;
        self.tableView_height.constant *= 1.2f;
        self.submit_btn_top.constant *= 1.2f;
        
        
        [self.title_label setFont:[UIFont systemFontOfSize:30]];
        [self.comment_label setFont:[UIFont systemFontOfSize:30]];
        [self.submit_btn.titleLabel setFont:[UIFont systemFontOfSize:30]];
        
    }
    else if (g_GameSet.g_curDeviceModel == IPHONE_6_PLUS) {
        self.q_small_charac_top.constant *= 1.3f;
        self.q_small_charac_height.constant *= 1.3f;
        self.q_small_charac_width.constant *= 1.3f;
        self.title_label_leading.constant *= 1.3f;
        self.title_label_top.constant *= 1.3f;
        self.title_label_height.constant *= 1.3f;
//        self.title_label_width.constant *= 1.3f;
        self.comment_label_top.constant *= 1.3f;

        self.tableView_top.constant *= 1.3f;
        self.tableView_height.constant *= 1.3f;
        self.submit_btn_top.constant *= 1.3f;

        [self.title_label setFont:[UIFont systemFontOfSize:30]];
        [self.comment_label setFont:[UIFont systemFontOfSize:30]];
        [self.submit_btn.titleLabel setFont:[UIFont systemFontOfSize:30]];
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

        self.tableView_top.constant *= 0.8f;
        self.tableView_height.constant *= 0.8f;
        self.submit_btn_top.constant *= 0.8f;

//        [self.title_label setFont:[UIFont systemFontOfSize:30]];
//        [self.comment_label setFont:[UIFont systemFontOfSize:30]];
//        [self.eoc_prep_btn.titleLabel setFont:[UIFont systemFontOfSize:30]];
//        [self.practice_quiz_btn.titleLabel setFont:[UIFont systemFontOfSize:30]];
//        [self.other_btn.titleLabel setFont:[UIFont systemFontOfSize:30]];
//        [self.submit_btn.titleLabel setFont:[UIFont systemFontOfSize:30]];
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
    return [self.m_specialQuiz_Arr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SpecialQuizTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SpecialQuizTableCell_identifier"];
    
    SpecialQuizInfo *result = [self.m_specialQuiz_Arr objectAtIndex:indexPath.row];
    
    cell.backgroundColor = [UIColor clearColor];
    [cell.quiz_btn setTitle:result.special_quiz_title forState:UIControlStateNormal];
    [cell.quiz_btn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [cell.quiz_btn setTag:1000+indexPath.row];
    
    [cell.quiz_btn addTarget:self action:@selector(onQuizBtn_inCell:) forControlEvents:UIControlEventTouchUpInside];
    
    
    cell.teacher_name.text = result.special_teacher_name;
    
    NSString *image_name;
    switch (indexPath.row%4) {
        case 0:
            image_name = @"totalPoint_btn";
            break;
        case 1:
            image_name = @"subjectStats_btn";
            break;
        case 2:
            image_name = @"medals_btn";
            break;
        case 3:
            image_name = @"signup_btn";
            break;
        default:
            break;
    }
    
    [cell.quiz_btn setBackgroundImage:[UIImage imageNamed:image_name] forState:UIControlStateNormal];

    if (result.isSelected) {
        [cell.quiz_btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        cell.teacher_name.textColor = [UIColor redColor];
        
    }else{
        [cell.quiz_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        cell.teacher_name.textColor = [UIColor whiteColor];
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float height = 80.0f;
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
        height *= 1.6f;
    }
    else if (g_GameSet.g_curDeviceModel == IPHONE_4) {
        height *= 1.0f;
    }
    return height;
}

- (void)onQuizBtn_inCell:(id)sender {
    UIButton *btn = (UIButton*)sender;
    NSInteger index = btn.tag - 1000;
    
    int i = 0;
    for(SpecialQuizInfo *info in self.m_specialQuiz_Arr){
        if (i == index) {
            info.isSelected = YES;
        }else{
            info.isSelected = NO;
        }
        i++;
    }
    [self.specialQuiz_tableView reloadData];
}


- (IBAction)onSubmit:(id)sender {
    SpecialQuizInfo *get_info = nil;
    for(SpecialQuizInfo *info in self.m_specialQuiz_Arr){
        if (info.isSelected) {
            get_info = info;
        }else{
            
        }
    }
    
    if (get_info != nil) {
        g_GameSet.g_special_quiz_info = get_info;
        [self sendSelectedInfo:get_info];
    }else{
        if ([UIAlertController class])
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"Please select" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                 {
                                     [alertController dismissViewControllerAnimated:YES completion:nil];
                                     
                                 }];
            [alertController addAction:ok];
            
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
        else
        {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Please select" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [alert show];
        }

    }
}

- (void)getSpecialQuizData
{
    NSString *strReqeust = [NSString stringWithFormat:@"user_id=%@&blog_id=%@&request_type=1",g_GameSet.g_user_id, g_GameSet.g_blog_id];

    NSData *requestData = [strReqeust dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%ld", (unsigned long)[requestData length]];
    
    NSMutableURLRequest* theRequest = [NSMutableURLRequest requestWithURL:SPECIAL_MODE_URL];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [theRequest setHTTPBody:requestData];
    [NSURLConnection connectionWithRequest:theRequest delegate:self];
    
    self.is_get_specialArr = YES;
    
}

- (void)sendSelectedInfo : (SpecialQuizInfo*) info
{
//    NSString *siteid = info.site_id;
    NSString *quiz_name = info.special_quiz_title;
    
//    NSString *strReqeust = [NSString stringWithFormat:@"user_id=%@&blog_id=%@&request_type=2&quiz=%@&site_id=%@",g_GameSet.g_user_id, g_GameSet.g_blog_id, quiz_name, siteid];
    NSString *strReqeust = [NSString stringWithFormat:@"user_id=%@&blog_id=%@&request_type=2&quiz=%@",g_GameSet.g_user_id, g_GameSet.g_blog_id, quiz_name];
    
    
    NSData *requestData = [strReqeust dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%ld", (unsigned long)[requestData length]];
    
    NSMutableURLRequest* theRequest = [NSMutableURLRequest requestWithURL:SPECIAL_MODE_URL];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [theRequest setHTTPBody:requestData];
    [NSURLConnection connectionWithRequest:theRequest delegate:self];
    
    self.is_send_selectInfo = YES;
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
    
    if (self.is_get_specialArr) {
        
        NSNumber *status_num = [dic objectForKey:@"status"];
        NSArray *data = [dic objectForKey:@"data"];
        NSString *message = [dic objectForKey:@"message"];

        int status = [status_num intValue];

        if (status == 1) {
            
            for( NSArray * d in data )
            {
                
                NSString *quiz_title = [d objectAtIndex:0];
                NSString *teacher_name = [d objectAtIndex:1];
//                NSString *site_id = [d objectAtIndex:2];
                
                SpecialQuizInfo *info = [[SpecialQuizInfo alloc] init];
                info.special_quiz_title = quiz_title;
                info.special_teacher_name = teacher_name;
//                info.site_id = site_id;
                
                [self.m_specialQuiz_Arr addObject:info];
            }
            
            [self.specialQuiz_tableView reloadData];
            
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
        self.is_get_specialArr = NO;
    }
    
    if (self.is_send_selectInfo) {
        
        NSNumber *status_num = [dic objectForKey:@"status"];
        NSMutableArray *d = [dic objectForKey:@"data"];
        NSString *message = [dic objectForKey:@"message"];
        
        int status = [status_num intValue];

        if (status == 1) {
            
            g_GameSet.g_specialQuiz_Arr = d;
            g_GameSet.g_current_ques_index = 0;
            NSDictionary *firstQuiz = [g_GameSet.g_specialQuiz_Arr objectAtIndex:g_GameSet.g_current_ques_index];
            
            NSString *problem_title = [firstQuiz objectForKey:@"title"];
            NSMutableArray  *answers_arr = [firstQuiz objectForKey:@"answers"];
            NSString *solution = [firstQuiz objectForKey:@"solutions"];
            NSString *category = [firstQuiz objectForKey:@"category"];
            
            //////////random arrange correct answer
            int ran_idx = arc4random() % 4;
            
            ////test test test
            NSLog(@"########### ran_idx = %d ###########", ran_idx);
            
            if (ran_idx == 0) {
                g_GameSet.g_specialQuiz.answers_arr = answers_arr;
                g_GameSet.g_specialQuiz.solution = solution;
                
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
                
                g_GameSet.g_specialQuiz.answers_arr = answers_arr;
                g_GameSet.g_specialQuiz.solution = solution;
                
            }
            ///////
            
            g_GameSet.g_specialQuiz.title = problem_title;
            g_GameSet.g_specialQuiz.category = category;
            
            g_GameSet.g_game_mode = SPECIAL_MODE;
            
            UIStoryboard *storyboard;
            if (g_GameSet.g_curDeviceModel == IPAD)
            {
                storyboard = [UIStoryboard storyboardWithName:@"Main_iPad"
                                                       bundle:nil];
                
            }else{
                storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone"
                                                       bundle:nil];
            }
            
            SpecialRespViewController *response_view =
            (SpecialRespViewController *)
            [storyboard instantiateViewControllerWithIdentifier:@"SpecialRespViewController"];
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
        self.is_send_selectInfo = NO;
    }
}


@end
