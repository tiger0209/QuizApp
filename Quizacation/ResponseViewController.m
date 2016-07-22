//
//  ResponseViewController.m
//  Quizacation
//
//  Created by Maksym on 12/30/15.
//  Copyright © 2015 Maksym. All rights reserved.
//

#import "ResponseViewController.h"
#import "SpinViewController.h"
#import "GameSet.h"
#import "ResultOverViewController.h"
#import "StealViewController.h"

#import "JSON.h"

#import "WaitingViewController.h"


@interface ResponseViewController ()
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

@property (assign, nonatomic) BOOL mb_first_hit;
@property (assign, nonatomic) BOOL mb_second_hit;
@property (assign, nonatomic) BOOL mb_third_hit;

@end

@implementation ResponseViewController

@synthesize q_small_charac_width, q_small_charac_height, q_small_charac_top, question_label, quiestion_label_top, title_label, title_label_height, title_label_top, title_label_leading, title_label_width, response1_btn, response1_btn_bottom, response2_btn, response2_btn_top, response3_btn, response3_btn_top, response4_btn, response4_btn_top;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self adjust_constraints];
    
    
    
    NSArray *v_quiz_array;

    question_label.text = g_GameSet.g_randomQuiz.title;
    v_quiz_array = g_GameSet.g_randomQuiz.answers_arr;
    self.m_correct_index = [self getIndexOfCorrectAnswer:g_GameSet.g_randomQuiz.solution];

    
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
    
    ///////Timer
    if (!self.m_timer) {
        self.m_timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTimer:) userInfo:nil repeats:YES];
        self.m_curTime = 30000;

    }
    
    g_GameSet.g_cur_viewcontroller = self;

    
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
    
    if(self.m_delay_timer && [self.m_delay_timer isValid]) {
        [self.m_delay_timer invalidate];
        self.m_delay_timer = nil;
    }
    
    if(self.m_timer && [self.m_timer isValid]) {
        [self.m_timer invalidate];
        self.m_timer = nil;
    }

    NSMutableArray *cat_arr = g_GameSet.g_remainCategory;
    /////////Adding Quiz Result
    QuizResultClass *quiz_result = [[QuizResultClass alloc] init];
    quiz_result.quiz_title = g_GameSet.g_randomQuiz.title;
    
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
    
    [g_GameSet.g_quiz_result_Arr addObject:quiz_result];
    
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

    if (g_GameSet.g_first_hit == true && g_GameSet.g_second_hit == true && g_GameSet.g_third_hit == true) {
        
        ///////
        StealViewController *spinView =
        (StealViewController *)
        [storyboard instantiateViewControllerWithIdentifier:@"StealViewController"];
        [self showViewController:spinView sender:nil];
        
        g_GameSet.g_first_hit = false;
        g_GameSet.g_second_hit = false;
        g_GameSet.g_third_hit = false;
        
    }else{
        
        //////test test test
        int cur_category = g_GameSet.g_curCategory;
        int cur_spinSelCategory = g_GameSet.g_curSpinSelCategory;
        
        if ([cat_arr count] == 1) {
            //mmm mmm mmm
            //////Is Correct the answer?
            if (self.mb_answer_correct) {
                
                //////sending category : mark
                [self inform_mark_in_category:cur_category mark:1];
                
                SpinViewController *resultView =
                (SpinViewController *)
                [storyboard instantiateViewControllerWithIdentifier:@"SpinViewController"];
                [self showViewController:resultView sender:nil];
                
            }else{
                
                //////sending category : mark
                [self inform_mark_in_category:cur_category mark:0];
                
                
                //                SpinViewController *spinView =
                //                (SpinViewController *)
                //                [storyboard instantiateViewControllerWithIdentifier:@"SpinViewController"];
                //                [self showViewController:spinView sender:nil];
            }
            
        }else{
            SpinViewController *spinView =
            (SpinViewController *)
            [storyboard instantiateViewControllerWithIdentifier:@"SpinViewController"];
            
            //mmm mmm mmm
            //////Is Correct the answer?
            if (self.mb_answer_correct) {
                ///////////////////
                //////sending category : mark
                [self inform_mark_in_category:cur_category mark:1];
                
                
                for (int i = 0; i < [cat_arr count]; i++) {
                    int v_num  = [[cat_arr objectAtIndex:i] intValue];
                    if (v_num == cur_spinSelCategory) {
                        [cat_arr removeObjectAtIndex:i];
                    }
                }
                g_GameSet.g_remainCategory = cat_arr;
                g_GameSet.g_elimate_category_type = cur_spinSelCategory;
                /////////////////
                
                //////////////
                [self showViewController:spinView sender:nil];
                
                
            }else{
                
                //////sending category : mark
                [self inform_mark_in_category:cur_category mark:0];
                
                //                [self showViewController:spinView sender:nil];
            }
        }
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
    solution_str = g_GameSet.g_randomQuiz.solution;

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
        int tag = v_btn.tag - 1000;
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
        int tag = v_btn.tag - 1000;
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
        int tag = v_btn.tag - 1000;
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
        int tag = v_btn.tag - 1000;
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
        
        if (g_GameSet.g_first_hit == false  && g_GameSet.g_second_hit == false && g_GameSet.g_third_hit == false) {
            self.mb_first_hit = true;
        }
        else if (g_GameSet.g_first_hit == true && g_GameSet.g_second_hit == false  && g_GameSet.g_third_hit == false) {
            self.mb_second_hit = true;
        }
        else if (g_GameSet.g_first_hit == true && g_GameSet.g_second_hit == true && g_GameSet.g_third_hit == false) {
            self.mb_third_hit = true;
        }
        
        if (self.mb_first_hit) {
            g_GameSet.g_first_hit = true;
        }
        if (self.mb_second_hit) {
            g_GameSet.g_second_hit = true;
        }
        if (self.mb_third_hit) {
            g_GameSet.g_third_hit = true;
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
        
//        if (g_GameSet.g_first_hit == true && g_GameSet.g_second_hit == false && g_GameSet.g_third_hit == false) {
//            self.mb_first_hit = false;
//        }
//        if (g_GameSet.g_first_hit == true && g_GameSet.g_second_hit == true  && g_GameSet.g_third_hit == false) {
//            self.mb_first_hit = false;
//            self.mb_second_hit = false;
//        }
        g_GameSet.g_first_hit = false;
        g_GameSet.g_second_hit = false;
        g_GameSet.g_third_hit = false;
        
    }
}

-(void) onDelaySubmit
{
    if(self.m_delay_timer && [self.m_delay_timer isValid]) {
        [self.m_delay_timer invalidate];
        self.m_delay_timer = nil;
    }

    if(self.m_timer && [self.m_timer isValid]) {
        [self.m_timer invalidate];
        self.m_timer = nil;
    }
    
    NSMutableArray *cat_arr = g_GameSet.g_remainCategory;
    
    /////////Adding Quiz Result
    QuizResultClass *quiz_result = [[QuizResultClass alloc] init];
    quiz_result.quiz_title = g_GameSet.g_randomQuiz.title;
    
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
    
    [g_GameSet.g_quiz_result_Arr addObject:quiz_result];
    
    
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
    
    if (g_GameSet.g_first_hit == true && g_GameSet.g_second_hit == true && g_GameSet.g_third_hit == true) {
        
        ///////
        StealViewController *spinView =
        (StealViewController *)
        [storyboard instantiateViewControllerWithIdentifier:@"StealViewController"];
        [self showViewController:spinView sender:nil];
        
        g_GameSet.g_first_hit = false;
        g_GameSet.g_second_hit = false;
        g_GameSet.g_third_hit = false;
        
    }else{
        
        //////test test test
        int cur_category = g_GameSet.g_curCategory;
        int cur_spinSelCategory = g_GameSet.g_curSpinSelCategory;
        
        if ([cat_arr count] == 1) {
            //mmm mmm mmm
            //////Is Correct the answer?
            if (self.mb_answer_correct) {
                
                //////sending category : mark
                [self inform_mark_in_category:cur_category mark:1];
                
                SpinViewController *resultView =
                (SpinViewController *)
                [storyboard instantiateViewControllerWithIdentifier:@"SpinViewController"];
                [self showViewController:resultView sender:nil];
                
            }else{
                
                //////sending category : mark
                [self inform_mark_in_category:cur_category mark:0];
                
                
//                SpinViewController *spinView =
//                (SpinViewController *)
//                [storyboard instantiateViewControllerWithIdentifier:@"SpinViewController"];
//                [self showViewController:spinView sender:nil];
            }
            
        }else{
            SpinViewController *spinView =
            (SpinViewController *)
            [storyboard instantiateViewControllerWithIdentifier:@"SpinViewController"];
            
            //mmm mmm mmm
            //////Is Correct the answer?
            if (self.mb_answer_correct) {
                ///////////////////
                //////sending category : mark
                [self inform_mark_in_category:cur_category mark:1];
                
                
                for (int i = 0; i < [cat_arr count]; i++) {
                    int v_num  = [[cat_arr objectAtIndex:i] intValue];
                    if (v_num == cur_spinSelCategory) {
                        [cat_arr removeObjectAtIndex:i];
                    }
                }
                g_GameSet.g_remainCategory = cat_arr;
                g_GameSet.g_elimate_category_type = cur_spinSelCategory;
                /////////////////
                
                //////////////
                [self showViewController:spinView sender:nil];
                
                
            }else{
                
                //////sending category : mark
                [self inform_mark_in_category:cur_category mark:0];
                
//                [self showViewController:spinView sender:nil];
            }
        }
    }
}

- (void)inform_mark_in_category:(int)category_id mark:(int) mark
{
    
    //////mmm mmm mmm
    int categoryId = category_id;
    NSString *user_id, *invite_id;
    
//    if (g_GameSet.g_is_master) {
//        user_id = g_GameSet.g_user_id;
//        invite_id = g_GameSet.g_h2h_invite_user_id;
//    }else{
//        invite_id = g_GameSet.g_user_id;
//        user_id = g_GameSet.g_h2h_invite_user_id;
//    }
    
    NSString *strReqeust = [NSString stringWithFormat:@"user_id=%@&blog_id=%@&category_id=%d&answer_mark=%d&answer_type=0&invite_user_id=%@&request_type=6",g_GameSet.g_user_id, g_GameSet.g_blog_id, categoryId, mark, g_GameSet.g_h2h_invite_user_id];
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
    
//    NSNumber *status_num = [dic objectForKey:@"status"];
    NSDictionary *d = [dic objectForKey:@"data"];
    
    NSNumber *status_num = [d objectForKey:@"status"];

//    NSString *message = [dic objectForKey:@"message"];
    
    int status = [status_num intValue];
    
    if (status == 1) {
        ///Swap inform
        UIStoryboard *storyboard;
//        UIViewController *v_viewController;
        if (g_GameSet.g_curDeviceModel == IPAD)
        {
            storyboard = [UIStoryboard storyboardWithName:@"Main_iPad"
                                                   bundle:nil];
            
        }else{
            storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone"
                                                   bundle:nil];
        }

        /////test test test 20160223
        WaitingViewController *response_view =
        (WaitingViewController *)
        [storyboard instantiateViewControllerWithIdentifier:@"WaitingViewController"];
        
        [g_GameSet.g_cur_viewcontroller showViewController:response_view sender:nil];
        
        
//        ////////test test test 0220
//        g_GameSet.g_is_master = !g_GameSet.g_is_master;

    }else{
        /////normal state
    }
}

@end
