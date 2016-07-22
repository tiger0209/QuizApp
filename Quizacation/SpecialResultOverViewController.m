//
//  SpecialResultOverViewController.m
//  Quizacation
//
//  Created by Maksym on 1/25/16.
//  Copyright © 2016 Maksym. All rights reserved.
//

#import "SpecialResultOverViewController.h"
#import "GameSet.h"
#import "ResultTableCell.h"
#import "LogInSuccessViewController.h"


@interface SpecialResultOverViewController ()<UITableViewDelegate, UITableViewDataSource>
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



@end

@implementation SpecialResultOverViewController

@synthesize q_small_charac_height, q_small_charac_top, q_small_charac_width, q_small_charac_leading, quiz_title_leading, quiz_title_width, quiz_title_top, quiz_title_height,
    result_table_frame_top, result_table_frame_height, tableview_top, tableview_height,
    table_title_label_top, table_label_height, submit_btn_top,
    quiz_title_label, table_title_label, resultTableView, submit_btn;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    ////
    self.m_quiz_result_arr = g_GameSet.g_special_quiz_result_Arr;

    
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
    
    [g_GameSet.g_special_quiz_result_Arr removeAllObjects];
    
    /////////
    
    LogInSuccessViewController *resultView =
    (LogInSuccessViewController *)
    [storyboard instantiateViewControllerWithIdentifier:@"LogInSuccessViewController"];
    [self showViewController:resultView sender:nil];

}

@end
