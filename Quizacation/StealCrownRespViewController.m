//
//  StealCrownRespViewController.m
//  Quizacation
//
//  Created by Maksym on 1/29/15.
//  Copyright © 2015 Maksym. All rights reserved.
//

#import "StealCrownRespViewController.h"
#import "SpinViewController.h"
#import "GameSet.h"
//#import "SpecialResultOverViewController.h"


@interface StealCrownRespViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *q_small_charac_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *q_small_charac_height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *q_small_charac_width;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *title_label_leading;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *title_label_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *title_label_height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *title_label_width;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *quiestion_label_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *response1_btn_bottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *response2_btn_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *response3_btn_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *response4_btn_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *submit_btn_top;

@property (weak, nonatomic) IBOutlet UILabel *title_label;
@property (weak, nonatomic) IBOutlet UILabel *question_label;
@property (weak, nonatomic) IBOutlet UIButton *response1_btn;
@property (weak, nonatomic) IBOutlet UIButton *response2_btn;
@property (weak, nonatomic) IBOutlet UIButton *response3_btn;
@property (weak, nonatomic) IBOutlet UIButton *response4_btn;
@property (weak, nonatomic) IBOutlet UIButton *submit_btn;


@property (weak, nonatomic) IBOutlet UILabel *time_label;


@property (assign, nonatomic) BOOL mb_toggleIsOn_1;
@property (assign, nonatomic) BOOL mb_toggleIsOn_2;
@property (assign, nonatomic) BOOL mb_toggleIsOn_3;
@property (assign, nonatomic) BOOL mb_toggleIsOn_4;

@property (assign, nonatomic) int  m_correct_index;
@property (assign, nonatomic) BOOL mb_answer_correct;

@property (assign, nonatomic) int  m_incorrect_index;

@property (strong, nonatomic) NSTimer *m_timer;
@property (strong, nonatomic) NSTimer *m_delay_timer;
@property (assign, nonatomic) double  m_curTime;

@property (assign, nonatomic) long long  m_curTime_ms;

@property (assign, nonatomic) BOOL      is_send_selectInfo;

@property (assign, nonatomic) NSString *m_cur_category;

@property (assign, nonatomic) float m_passedTime;


@end

@implementation StealCrownRespViewController

@synthesize q_small_charac_width, q_small_charac_height, q_small_charac_top, question_label, quiestion_label_top, title_label, title_label_height, title_label_top, title_label_leading, title_label_width, response1_btn, response1_btn_bottom, response2_btn, response2_btn_top, response3_btn, response3_btn_top, response4_btn, response4_btn_top;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self adjust_constraints];
    
    NSArray *v_quiz_array;
    
    question_label.text = g_GameSet.g_h2h_stealQuiz.title;
    v_quiz_array = g_GameSet.g_h2h_stealQuiz.answers_arr;
    self.m_cur_category = g_GameSet.g_h2h_stealQuiz.category;
    
    self.m_correct_index = [self getIndexOfCorrectAnswer:g_GameSet.g_h2h_stealQuiz.solution];
    
    [response1_btn setTitle:[v_quiz_array objectAtIndex:0] forState:UIControlStateNormal];
    [response2_btn setTitle:[v_quiz_array objectAtIndex:1] forState:UIControlStateNormal];
    [response3_btn setTitle:[v_quiz_array objectAtIndex:2] forState:UIControlStateNormal];
    [response4_btn setTitle:[v_quiz_array objectAtIndex:3] forState:UIControlStateNormal];
    
    response1_btn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    response1_btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    response1_btn.titleLabel.preferredMaxLayoutWidth = response1_btn.frame.size.width;
    response1_btn.titleLabel.numberOfLines = 0;
    
    response2_btn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    response2_btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    response2_btn.titleLabel.preferredMaxLayoutWidth = response2_btn.frame.size.width;
    response2_btn.titleLabel.numberOfLines = 0;
    
    response3_btn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    response3_btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    response3_btn.titleLabel.preferredMaxLayoutWidth = response3_btn.frame.size.width;
    response3_btn.titleLabel.numberOfLines = 0;
    
    response4_btn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    response4_btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    response4_btn.titleLabel.preferredMaxLayoutWidth = response4_btn.frame.size.width;
    response4_btn.titleLabel.numberOfLines = 0;
    

    self.m_incorrect_index = 0;
    self.m_passedTime = 0.0;

    
    self.is_send_selectInfo = NO;
    
    ///////Timer
    if (!self.m_timer) {
        self.m_timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTimer:) userInfo:nil repeats:YES];
        self.m_curTime = 30000;

        self.m_curTime_ms = (long long)([[NSDate date] timeIntervalSince1970] * 1000.0);
    }
    
    g_GameSet.g_cur_viewcontroller = self;

}

-(void) loadNewQuizScreen
{
    NSArray *v_quiz_array;
    
    question_label.text = g_GameSet.g_h2h_stealQuiz.title;
    v_quiz_array = g_GameSet.g_h2h_stealQuiz.answers_arr;
    self.m_cur_category = g_GameSet.g_h2h_stealQuiz.category;
    
    self.m_correct_index = [self getIndexOfCorrectAnswer:g_GameSet.g_h2h_stealQuiz.solution];
    
    [response1_btn setTitle:[v_quiz_array objectAtIndex:0] forState:UIControlStateNormal];
    [response2_btn setTitle:[v_quiz_array objectAtIndex:1] forState:UIControlStateNormal];
    [response3_btn setTitle:[v_quiz_array objectAtIndex:2] forState:UIControlStateNormal];
    [response4_btn setTitle:[v_quiz_array objectAtIndex:3] forState:UIControlStateNormal];
    
    [self.response1_btn setBackgroundImage:[UIImage imageNamed:@"response_btn.png"] forState:UIControlStateNormal];
    [self.response2_btn setBackgroundImage:[UIImage imageNamed:@"response_btn.png"] forState:UIControlStateNormal];
    [self.response3_btn setBackgroundImage:[UIImage imageNamed:@"response_btn.png"] forState:UIControlStateNormal];
    [self.response4_btn setBackgroundImage:[UIImage imageNamed:@"response_btn.png"] forState:UIControlStateNormal];

    self.m_incorrect_index = 0;
    self.m_passedTime = 0.0;
    
    
    self.is_send_selectInfo = NO;
    
    ///////Timer
    if (!self.m_timer) {
        self.m_timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTimer:) userInfo:nil repeats:YES];
        self.m_curTime = 30000;
        
        self.m_curTime_ms = (long long)([[NSDate date] timeIntervalSince1970] * 1000.0);
    }
}

- (void)updateTimer:(NSTimer *)timer {
    self.m_curTime -= 1000 ;
    [self populateLabelwithTime:self.m_curTime];
}

- (void)populateLabelwithTime:(int)milliseconds {
    int seconds = milliseconds/1000;
    NSString * result = [NSString stringWithFormat:@"%02ds",seconds];
    self.time_label.text = result;
    
    if (seconds == 0) {
        if(self.m_timer && [self.m_timer isValid]) {
            [self.m_timer invalidate];
            self.m_timer = nil;
        }
        [self processTimeEnd];
    }
}

- (void) processTimeEnd
{
    self.m_passedTime = 30.0;

    /////////Adding Quiz Result
    QuizResultClass *quiz_result = [[QuizResultClass alloc] init];
    
    quiz_result.quiz_title = g_GameSet.g_h2h_stealQuiz.title;
    
    if (self.mb_answer_correct) {
        quiz_result.quiz_result_status = @"CORRECT";
    }else{
        switch (self.m_incorrect_index) {
            case 0:
                quiz_result.quiz_result_status = @"TIME OUT";
                break;
            case 1:
                quiz_result.quiz_result_status = @"A";
                break;
            case 2:
                quiz_result.quiz_result_status = @"B";
                break;
            case 3:
                quiz_result.quiz_result_status = @"C";
                break;
            case 4:
                quiz_result.quiz_result_status = @"D";
                break;
                
            default:
                break;
        }
    }
    
    [g_GameSet.g_h2h_stealQuiz_result_Arr addObject:quiz_result];
    
    
    /////////////////
    UIStoryboard *storyboard;
    if (g_GameSet.g_curDeviceModel == IPAD)
    {
        storyboard = [UIStoryboard storyboardWithName:@"Main_iPad"
                                               bundle:nil];
        
    }else{
        storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone"
                                               bundle:nil];
    }
    
    if (self.mb_answer_correct) {
        //////sending category : mark
        [self inform_mark_in_category:self.m_cur_category mark:1];
    }else{
        [self inform_mark_in_category:self.m_cur_category mark:0];
    }
    
    //////test test test
    //////Is Correct the answer?
    if (g_GameSet.g_h2h_steal_current_ques_index == [g_GameSet.g_h2h_stealQuiz_Arr count] - 1) {
        
        g_GameSet.g_h2h_steal_current_ques_index = 0;
        
        /////test test test 0225
        [g_GameSet.g_h2h_stealQuiz_Arr removeAllObjects];
        
        ////test test test
        [self inform_ending_result];
        
    }else{
        
        g_GameSet.g_h2h_steal_current_ques_index++;
        //////sending category : mark
        
        NSDictionary *v_quiz = [g_GameSet.g_h2h_stealQuiz_Arr objectAtIndex:g_GameSet.g_h2h_steal_current_ques_index];
        
        NSString *problem_title = [v_quiz objectForKey:@"title"];
        NSMutableArray  *answers_arr = [NSMutableArray arrayWithArray:[v_quiz objectForKey:@"answers"]];
        NSString *solution = [v_quiz objectForKey:@"solutions"];
        NSString *category = [v_quiz objectForKey:@"category"];
        
        //////////random arrange correct answer
        int ran_idx = arc4random() % 4;
        
        ////test test test
        NSLog(@"########### ran_idx = %d ###########", ran_idx);
        
        if (ran_idx == 0) {
            g_GameSet.g_h2h_stealQuiz.answers_arr = answers_arr;
            g_GameSet.g_h2h_stealQuiz.solution = solution;
            
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
            
            g_GameSet.g_h2h_stealQuiz.answers_arr = answers_arr;
            g_GameSet.g_h2h_stealQuiz.solution = solution;
            
        }
        g_GameSet.g_h2h_stealQuiz.title = problem_title;
        g_GameSet.g_h2h_stealQuiz.category = category;

        
//        StealCrownRespViewController *resultView =
//        (StealCrownRespViewController *)
//        [storyboard instantiateViewControllerWithIdentifier:@"StealCrownRespViewController"];
//        [self showViewController:resultView sender:nil];
        [self loadNewQuizScreen];
    }

}

- (void) adjust_constraints
{
    if (g_GameSet.g_curDeviceModel == IPHONE_5) {
        
        self.q_small_charac_top.constant *= 1.0f;
        self.q_small_charac_height.constant *= 1.0f;
        self.q_small_charac_width.constant *= 1.0f;
        self.title_label_leading.constant *= 1.0f;
        self.title_label_top.constant *= 1.0f;
        self.title_label_height.constant *= 1.0f;
        //        self.title_label_width.constant *= 1.2f;
        self.quiestion_label_top.constant *= 1.0f;
        self.response1_btn_bottom.constant *= 1.0f;
        self.response2_btn_top.constant *= 1.0f;
        self.response3_btn_top.constant *= 1.0f;
        self.response4_btn_top.constant *= 1.0f;
        self.submit_btn_top.constant *= 1.0f;
        
        [self.title_label setFont:[UIFont systemFontOfSize:25]];
        [self.question_label setFont:[UIFont systemFontOfSize:15]];
        [self.response1_btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [self.response2_btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [self.response3_btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [self.response4_btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [self.submit_btn.titleLabel setFont:[UIFont systemFontOfSize:25]];

        
    }
    else if (g_GameSet.g_curDeviceModel == IPHONE_6) {
        self.q_small_charac_top.constant *= 1.2f;
        self.q_small_charac_height.constant *= 1.2f;
        self.q_small_charac_width.constant *= 1.2f;
        self.title_label_leading.constant *= 1.2f;
        self.title_label_top.constant *= 1.2f;
        self.title_label_height.constant *= 1.2f;
        //        self.title_label_width.constant *= 1.2f;
        self.quiestion_label_top.constant *= 0.9f;
        self.response1_btn_bottom.constant *= 1.1f;
        self.response2_btn_top.constant *= 1.1f;
        self.response3_btn_top.constant *= 1.1f;
        self.response4_btn_top.constant *= 1.1f;
        self.submit_btn_top.constant *= 1.1f;
        
        [self.title_label setFont:[UIFont systemFontOfSize:30]];
        [self.question_label setFont:[UIFont systemFontOfSize:20]];
        [self.response1_btn.titleLabel setFont:[UIFont systemFontOfSize:20]];
        [self.response2_btn.titleLabel setFont:[UIFont systemFontOfSize:20]];
        [self.response3_btn.titleLabel setFont:[UIFont systemFontOfSize:20]];
        [self.response4_btn.titleLabel setFont:[UIFont systemFontOfSize:20]];
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
        self.quiestion_label_top.constant *= 0.9f;
        self.response1_btn_bottom.constant *= 1.1f;
        self.response2_btn_top.constant *= 1.1f;
        self.response3_btn_top.constant *= 1.1f;
        self.response4_btn_top.constant *= 1.1f;
        self.submit_btn_top.constant *= 1.1f;
        
        [self.title_label setFont:[UIFont systemFontOfSize:30]];
        [self.question_label setFont:[UIFont systemFontOfSize:20]];
        [self.response1_btn.titleLabel setFont:[UIFont systemFontOfSize:20]];
        [self.response2_btn.titleLabel setFont:[UIFont systemFontOfSize:20]];
        [self.response3_btn.titleLabel setFont:[UIFont systemFontOfSize:20]];
        [self.response4_btn.titleLabel setFont:[UIFont systemFontOfSize:20]];
        [self.submit_btn.titleLabel setFont:[UIFont systemFontOfSize:20]];
    }
    else if (g_GameSet.g_curDeviceModel == IPHONE_4) {
        self.q_small_charac_top.constant *= 0.8f;
        self.q_small_charac_height.constant *= 0.8f;
        self.q_small_charac_width.constant *= 0.8f;
        self.title_label_leading.constant *= 0.8f;
        self.title_label_top.constant *= 0.8f;
        self.title_label_height.constant *= 0.8f;
        //        self.title_label_width.constant *= 0.8f;
        self.quiestion_label_top.constant *= 0.8f;
        self.response1_btn_bottom.constant *= 0.8f;
        self.response2_btn_top.constant *= 0.8f;
        self.response3_btn_top.constant *= 0.8f;
        self.response4_btn_top.constant *= 0.8f;
        self.submit_btn_top.constant *= 0.8f;
        
        [self.title_label setFont:[UIFont systemFontOfSize:25]];
        [self.question_label setFont:[UIFont systemFontOfSize:15]];
        [self.response1_btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [self.response2_btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [self.response3_btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [self.response4_btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [self.submit_btn.titleLabel setFont:[UIFont systemFontOfSize:25]];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(int) getIndexOfCorrectAnswer : (NSString*) answerStr
{
    int index;
    
    NSString *solution_str;
    
    solution_str = g_GameSet.g_h2h_stealQuiz.solution;

    int solution_num = [solution_str intValue];
    if (solution_num >= 1000) {
        index = 1;
    }else if (solution_num >= 100){
        index = 2;
    }else if (solution_num >= 100){
        index = 2;
    }else if (solution_num >= 10){
        index = 3;
    }else{
        index = 4;
    }
    
    return index;
}

- (IBAction)onAnswer_1:(id)sender {

    self.mb_toggleIsOn_1 = !self.mb_toggleIsOn_1;

    if(self.mb_toggleIsOn_1){
        //do anything else you want to do.
        UIButton *v_btn = (UIButton*)sender;
        NSInteger tag = v_btn.tag - 1000;
        if (self.m_correct_index == tag) {
            self.mb_answer_correct = YES;
        }else{
            self.mb_answer_correct = NO;
            self.m_incorrect_index = 1;
        }
        
        self.mb_toggleIsOn_2 = false;
        self.mb_toggleIsOn_3 = false;
        self.mb_toggleIsOn_4 = false;
    }
    else {
        //do anything you want to do.

    }
    
    [self.response1_btn setBackgroundImage:[UIImage imageNamed:self.mb_toggleIsOn_1 ? @"response_true_btn.png" :@"response_btn.png"] forState:UIControlStateNormal];
    /////
    [self.response2_btn setBackgroundImage:[UIImage imageNamed:@"response_btn.png"] forState:UIControlStateNormal];
    [self.response3_btn setBackgroundImage:[UIImage imageNamed:@"response_btn.png"] forState:UIControlStateNormal];
    [self.response4_btn setBackgroundImage:[UIImage imageNamed:@"response_btn.png"] forState:UIControlStateNormal];


}

- (IBAction)onAnswer_2:(id)sender {

    self.mb_toggleIsOn_2 = !self.mb_toggleIsOn_2;

    if(self.mb_toggleIsOn_2){
        //do anything else you want to do.
        UIButton *v_btn = (UIButton*)sender;
        NSInteger tag = v_btn.tag - 1000;
        if (self.m_correct_index == tag) {
            self.mb_answer_correct = YES;
            self.m_incorrect_index = 2;
        }else{
            self.mb_answer_correct = NO;
        }
        
        self.mb_toggleIsOn_1 = false;
        self.mb_toggleIsOn_3 = false;
        self.mb_toggleIsOn_4 = false;

    }
    else {
        //do anything you want to do.
        
    }
    [self.response2_btn setBackgroundImage:[UIImage imageNamed:self.mb_toggleIsOn_2 ? @"response_true_btn.png" :@"response_btn.png"] forState:UIControlStateNormal];
    /////
    [self.response1_btn setBackgroundImage:[UIImage imageNamed:@"response_btn.png"] forState:UIControlStateNormal];
    [self.response3_btn setBackgroundImage:[UIImage imageNamed:@"response_btn.png"] forState:UIControlStateNormal];
    [self.response4_btn setBackgroundImage:[UIImage imageNamed:@"response_btn.png"] forState:UIControlStateNormal];

}

- (IBAction)onAnswer_3:(id)sender {

    self.mb_toggleIsOn_3 = !self.mb_toggleIsOn_3;

    if(self.mb_toggleIsOn_3){
        //do anything else you want to do.
        UIButton *v_btn = (UIButton*)sender;
        NSInteger tag = v_btn.tag - 1000;
        if (self.m_correct_index == tag) {
            self.mb_answer_correct = YES;
        }else{
            self.mb_answer_correct = NO;
            self.m_incorrect_index = 3;
        }
        
        self.mb_toggleIsOn_1 = false;
        self.mb_toggleIsOn_2 = false;
        self.mb_toggleIsOn_4 = false;


    }
    else {
        //do anything you want to do.
        
    }
    [self.response3_btn setBackgroundImage:[UIImage imageNamed:self.mb_toggleIsOn_3 ? @"response_true_btn.png" :@"response_btn.png"] forState:UIControlStateNormal];
    /////
    [self.response1_btn setBackgroundImage:[UIImage imageNamed:@"response_btn.png"] forState:UIControlStateNormal];
    [self.response2_btn setBackgroundImage:[UIImage imageNamed:@"response_btn.png"] forState:UIControlStateNormal];
    [self.response4_btn setBackgroundImage:[UIImage imageNamed:@"response_btn.png"] forState:UIControlStateNormal];

}

- (IBAction)onAnswer_4:(id)sender {
    
    self.mb_toggleIsOn_4 = !self.mb_toggleIsOn_4;

    if(self.mb_toggleIsOn_4){
        //do anything else you want to do.
        UIButton *v_btn = (UIButton*)sender;
        NSInteger tag = v_btn.tag - 1000;
        if (self.m_correct_index == tag) {
            self.mb_answer_correct = YES;
        }else{
            self.mb_answer_correct = NO;
            self.m_incorrect_index = 4;
        }
        
        self.mb_toggleIsOn_1 = false;
        self.mb_toggleIsOn_2 = false;
        self.mb_toggleIsOn_3 = false;


    }
    else {
        //do anything you want to do.
        
    }
    [self.response4_btn setBackgroundImage:[UIImage imageNamed:self.mb_toggleIsOn_4 ? @"response_true_btn.png" :@"response_btn.png"] forState:UIControlStateNormal];
    /////
    [self.response1_btn setBackgroundImage:[UIImage imageNamed:@"response_btn.png"] forState:UIControlStateNormal];
    [self.response2_btn setBackgroundImage:[UIImage imageNamed:@"response_btn.png"] forState:UIControlStateNormal];
    [self.response3_btn setBackgroundImage:[UIImage imageNamed:@"response_btn.png"] forState:UIControlStateNormal];

}

- (IBAction)onSubmit:(id)sender {
    
    self.m_delay_timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(onDelaySubmit) userInfo:nil repeats:NO];
    if (self.mb_answer_correct) {
        switch (self.m_correct_index) {
            case 1:
                [self.response1_btn setBackgroundImage:[UIImage imageNamed:@"response_true_btn.png"] forState:UIControlStateNormal];
                break;
            case 2:
                [self.response2_btn setBackgroundImage:[UIImage imageNamed:@"response_true_btn.png"] forState:UIControlStateNormal];
                break;
            case 3:
                [self.response3_btn setBackgroundImage:[UIImage imageNamed:@"response_true_btn.png"] forState:UIControlStateNormal];
                break;
            case 4:
                [self.response4_btn setBackgroundImage:[UIImage imageNamed:@"response_true_btn.png"] forState:UIControlStateNormal];
                break;
            default:
                break;
        }
    }else{
        
        switch (self.m_correct_index) {
            case 1:
                [self.response1_btn setBackgroundImage:[UIImage imageNamed:@"response_true_btn.png"] forState:UIControlStateNormal];
                break;
            case 2:
                [self.response2_btn setBackgroundImage:[UIImage imageNamed:@"response_true_btn.png"] forState:UIControlStateNormal];
                break;
            case 3:
                [self.response3_btn setBackgroundImage:[UIImage imageNamed:@"response_true_btn.png"] forState:UIControlStateNormal];
                break;
            case 4:
                [self.response4_btn setBackgroundImage:[UIImage imageNamed:@"response_true_btn.png"] forState:UIControlStateNormal];
                break;
            default:
                break;
        }

        switch (self.m_incorrect_index) {
            case 1:
                [self.response1_btn setBackgroundImage:[UIImage imageNamed:@"response_false_btn.png"] forState:UIControlStateNormal];
                break;
            case 2:
                [self.response2_btn setBackgroundImage:[UIImage imageNamed:@"response_false_btn.png"] forState:UIControlStateNormal];
                break;
            case 3:
                [self.response3_btn setBackgroundImage:[UIImage imageNamed:@"response_false_btn.png"] forState:UIControlStateNormal];
                break;
            case 4:
                [self.response4_btn setBackgroundImage:[UIImage imageNamed:@"response_false_btn.png"] forState:UIControlStateNormal];
                break;
            default:
                break;
        }
    }
}

- (void) onDelaySubmit
{
    if(self.m_delay_timer && [self.m_delay_timer isValid]) {
        [self.m_delay_timer invalidate];
        self.m_delay_timer = nil;
    }

    
    if(self.m_timer && [self.m_timer isValid]) {
        [self.m_timer invalidate];
        self.m_timer = nil;
    }
    
    long long v_ms = (long long)([[NSDate date] timeIntervalSince1970] * 1000.0);
    self.m_passedTime = (v_ms - self.m_curTime_ms) / 1000;

    /////////Adding Quiz Result
    QuizResultClass *quiz_result = [[QuizResultClass alloc] init];
    quiz_result.quiz_title = g_GameSet.g_h2h_stealQuiz.title;
    
    
    if (self.mb_answer_correct) {
        quiz_result.quiz_result_status = @"CORRECT";
    }else{
        switch (self.m_incorrect_index) {
            case 0:
                quiz_result.quiz_result_status = @"GIVE UP";
                break;
            case 1:
                quiz_result.quiz_result_status = @"A";
                break;
            case 2:
                quiz_result.quiz_result_status = @"B";
                break;
            case 3:
                quiz_result.quiz_result_status = @"C";
                break;
            case 4:
                quiz_result.quiz_result_status = @"D";
                break;
                
            default:
                break;
        }
    }
    
    [g_GameSet.g_h2h_stealQuiz_result_Arr addObject:quiz_result];
    
    
    /////////////////
    UIStoryboard *storyboard;
    if (g_GameSet.g_curDeviceModel == IPAD)
    {
        storyboard = [UIStoryboard storyboardWithName:@"Main_iPad"
                                               bundle:nil];
        
    }else{
        storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone"
                                               bundle:nil];
    }
    
    if (self.mb_answer_correct) {
        //////sending category : mark
        [self inform_mark_in_category:self.m_cur_category mark:1];
    }else{
        [self inform_mark_in_category:self.m_cur_category mark:0];
    }
    
    //////test test test
    //////Is Correct the answer?
    if (g_GameSet.g_h2h_steal_current_ques_index == [g_GameSet.g_h2h_stealQuiz_Arr count] - 1) {
        
        g_GameSet.g_h2h_steal_current_ques_index = 0;
        
        ////test test test 0225
        [g_GameSet.g_h2h_stealQuiz_Arr removeAllObjects];
        
        ////test test test
        [self inform_ending_result];
        
    }else{
        
        g_GameSet.g_h2h_steal_current_ques_index++;
        //////sending category : mark
        
        NSDictionary *v_quiz = [g_GameSet.g_h2h_stealQuiz_Arr objectAtIndex:g_GameSet.g_h2h_steal_current_ques_index];
        
        NSString *problem_title = [v_quiz objectForKey:@"title"];
        NSMutableArray  *answers_arr = [NSMutableArray arrayWithArray:[v_quiz objectForKey:@"answers"]];
        NSString *solution = [v_quiz objectForKey:@"solutions"];
        NSString *category = [v_quiz objectForKey:@"category"];
        //////////random arrange correct answer
        int ran_idx = arc4random() % 4;
        
        ////test test test
        NSLog(@"########### ran_idx = %d ###########", ran_idx);
        
        if (ran_idx == 0) {
            g_GameSet.g_h2h_stealQuiz.answers_arr = answers_arr;
            g_GameSet.g_h2h_stealQuiz.solution = solution;
            
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
            
            g_GameSet.g_h2h_stealQuiz.answers_arr = answers_arr;
            g_GameSet.g_h2h_stealQuiz.solution = solution;
            
        }
        g_GameSet.g_h2h_stealQuiz.title = problem_title;
        g_GameSet.g_h2h_stealQuiz.category = category;
        
//        StealCrownRespViewController *resultView =
//        (StealCrownRespViewController *)
//        [storyboard instantiateViewControllerWithIdentifier:@"StealCrownRespViewController"];
//        [self showViewController:resultView sender:nil];

        [self loadNewQuizScreen];
    }

}

- (void)inform_mark_in_category:(NSString*)category_id mark:(int) mark
{
    //////mmm mmm mmm
    int status;
    if (g_GameSet.g_is_master) {
        status = 1;
    }else{
        status = 0;
    }
    NSString *strReqeust = [NSString stringWithFormat:@"user_id=%@&blog_id=%@&request_type=8&category=%@&answer_mark=%d&invite_user_id=%@&status=%d&test_time=%d",g_GameSet.g_user_id, g_GameSet.g_blog_id, category_id, mark, g_GameSet.g_h2h_invite_user_id, status, (int)(self.m_passedTime*1000)];

    NSData *requestData = [strReqeust dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[requestData length]];
    
    NSMutableURLRequest* theRequest = [NSMutableURLRequest requestWithURL:H2H_MODE_URL];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [theRequest setHTTPBody:requestData];
    [NSURLConnection connectionWithRequest:theRequest delegate:self];    
}


- (void)inform_ending_result
{
    //////mmm mmm mmm
    int status;
    if (g_GameSet.g_is_master) {
        status = 1;
    }else{
        status = 0;
    }
    NSString *strReqeust = [NSString stringWithFormat:@"request_type=9&user_id=%@&blog_id=%@&invite_user_id=%@&category_id=%@",g_GameSet.g_user_id, g_GameSet.g_blog_id, g_GameSet.g_h2h_invite_user_id, self.m_cur_category];
    
    NSData *requestData = [strReqeust dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[requestData length]];
    
    NSMutableURLRequest* theRequest = [NSMutableURLRequest requestWithURL:H2H_MODE_URL];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [theRequest setHTTPBody:requestData];
    [NSURLConnection connectionWithRequest:theRequest delegate:self];
}



@end
