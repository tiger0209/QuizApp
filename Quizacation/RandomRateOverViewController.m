//
//  RandomRateOverViewController.m
//  Quizacation
//
//  Created by Maksym on 2/9/16.
//  Copyright © 2016 Maksym. All rights reserved.
//

#import "RandomRateOverViewController.h"
#import "GameSet.h"
#import "RandomResultTableCell.h"
#import "LogInSuccessViewController.h"


@interface RandomRateOverViewController ()<UITableViewDelegate, UITableViewDataSource>

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


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *table_pos_label_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *table_pos_label_leading;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *table_name_label_leading;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *table_name_label_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *table_pts_label_leading;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *table_pts_label_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *table_time_label_leading;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *table_time_label_top;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *table_pos_label_height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *table_name_label_height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *table_pts_label_height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *table_time_label_height;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *table_pos_label_width;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *table_name_label_width;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *table_pts_label_width;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *table_time_label_width;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *submit_btn_top;

@property (weak, nonatomic) IBOutlet UILabel *quiz_title_label;
@property (weak, nonatomic) IBOutlet UILabel *table_pos_label;
@property (weak, nonatomic) IBOutlet UILabel *table_name_label;
@property (weak, nonatomic) IBOutlet UILabel *table_pts_label;
@property (weak, nonatomic) IBOutlet UILabel *table_time_label;



@property (weak, nonatomic) IBOutlet UITableView *resultTableView;
@property (weak, nonatomic) IBOutlet UIButton *submit_btn;


@property (strong, nonatomic) NSArray *m_quiz_result_arr;



@end

@implementation RandomRateOverViewController

@synthesize q_small_charac_height, q_small_charac_top, q_small_charac_width, q_small_charac_leading, quiz_title_leading, quiz_title_width, quiz_title_top, quiz_title_height,
    result_table_frame_top, result_table_frame_height, tableview_top, tableview_height,
     submit_btn_top,
    quiz_title_label, resultTableView, submit_btn, table_name_label, table_name_label_leading, table_name_label_top, table_pos_label, table_pos_label_leading, table_pos_label_top, table_pts_label, table_pts_label_leading, table_pts_label_top, table_time_label, table_time_label_leading, table_time_label_top;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    ////
    self.m_quiz_result_arr = [self adjustArray : g_GameSet.g_randomQuiz_rate_Arr];
//    ///first
//    RandomQuizRateClass *first = [self.m_quiz_result_arr objectAtIndex:0];
//    first.m_place = 1;
//
//    if ([self.m_quiz_result_arr count] > 1) {
//        ///second
//        RandomQuizRateClass *second = [self.m_quiz_result_arr objectAtIndex:1];
//        second.m_place = 2;
//    }
//    if ([self.m_quiz_result_arr count] > 2) {
//        ///third
//        RandomQuizRateClass *third = [self.m_quiz_result_arr objectAtIndex:2];
//        third.m_place = 3;
//    }
   
    
    // Register the table cell
    [self.resultTableView registerNib:[UINib nibWithNibName:@"RandomResultTableCell" bundle:nil] forCellReuseIdentifier:@"RandomResultTableCell_identifier"];

    [self.resultTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.resultTableView setScrollEnabled:YES];
    
    [self adjust_constraints];
    
    g_GameSet.g_cur_viewcontroller = self;

    
}

- (NSArray *) adjustArray : (NSArray*) v_array
{
//    NSSortDescriptor *sortDescriptor;
//    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"m_point"
//                                                 ascending:NO];
//    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
//    NSArray *sortedArray = [v_array sortedArrayUsingDescriptors:sortDescriptors];
//    
//    return sortedArray;
    
    NSSortDescriptor *firstDescriptor = [[NSSortDescriptor alloc] initWithKey:@"m_point" ascending:NO];
    NSSortDescriptor *secondDescriptor = [[NSSortDescriptor alloc] initWithKey:@"m_time" ascending:YES];
    
    NSArray *sortDescriptors = [NSArray arrayWithObjects:firstDescriptor, secondDescriptor, nil];
    
    NSArray *sortedArray = [v_array sortedArrayUsingDescriptors:sortDescriptors];
    
    int index = 1;
    for (RandomQuizRateClass *v_item in sortedArray) {
        v_item.m_place = index;
        index++;
    }
    
    return sortedArray;
}

- (void) adjust_constraints
{
    if (g_GameSet.g_curDeviceModel == IPHONE_5) {
        
        [self.quiz_title_label setFont:[UIFont systemFontOfSize:30]];
        [self.table_pos_label setFont:[UIFont systemFontOfSize:15]];
        [self.table_name_label setFont:[UIFont systemFontOfSize:15]];
        [self.table_pts_label setFont:[UIFont systemFontOfSize:15]];
        [self.table_time_label setFont:[UIFont systemFontOfSize:15]];

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
        
        self.table_pos_label_top.constant *= 1.2f;
        self.table_pos_label_leading.constant *= 1.2f;
        self.table_pos_label_height.constant *= 1.2f;

        self.table_name_label_top.constant *= 1.2f;
        self.table_name_label_leading.constant *= 1.2f;
        self.table_name_label_height.constant *= 1.2f;

        self.table_pts_label_top.constant *= 1.2f;
        self.table_pts_label_leading.constant *= 1.2f;
        self.table_pts_label_height.constant *= 1.2f;

        self.table_time_label_top.constant *= 1.2f;
        self.table_time_label_leading.constant *= 1.2f;
        self.table_time_label_height.constant *= 1.2f;

        self.table_pos_label_width.constant *= 1.2f;
        self.table_name_label_width.constant *= 1.2f;
        self.table_pts_label_width.constant *= 1.2f;
        self.table_time_label_width.constant *= 1.2f;
        
        
        [self.quiz_title_label setFont:[UIFont systemFontOfSize:30]];
        [self.table_pos_label setFont:[UIFont systemFontOfSize:18]];
        [self.table_name_label setFont:[UIFont systemFontOfSize:18]];
        [self.table_pts_label setFont:[UIFont systemFontOfSize:18]];
        [self.table_time_label setFont:[UIFont systemFontOfSize:18]];
        
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
        
        self.table_pos_label_top.constant *= 1.3f;
        self.table_pos_label_leading.constant *= 1.3f;
        self.table_pos_label_height.constant *= 1.3f;
        
        self.table_name_label_top.constant *= 1.3f;
        self.table_name_label_leading.constant *= 1.3f;
        self.table_name_label_height.constant *= 1.3f;
        
        self.table_pts_label_top.constant *= 1.3f;
        self.table_pts_label_leading.constant *= 1.3f;
        self.table_pts_label_height.constant *= 1.3f;
        
        self.table_time_label_top.constant *= 1.3f;
        self.table_time_label_leading.constant *= 1.3f;
        self.table_time_label_height.constant *= 1.3f;
 
        self.table_pos_label_width.constant *= 1.3f;
        self.table_name_label_width.constant *= 1.3f;
        self.table_pts_label_width.constant *= 1.3f;
        self.table_time_label_width.constant *= 1.3f;

        
        [self.quiz_title_label setFont:[UIFont systemFontOfSize:30]];
        [self.table_pos_label setFont:[UIFont systemFontOfSize:20]];
        [self.table_name_label setFont:[UIFont systemFontOfSize:20]];
        [self.table_pts_label setFont:[UIFont systemFontOfSize:20]];
        [self.table_time_label setFont:[UIFont systemFontOfSize:20]];

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
        
        self.table_pos_label_top.constant *= 0.8f;
        self.table_pos_label_leading.constant *= 0.8f;
        self.table_pos_label_height.constant *= 0.8f;
        
        self.table_name_label_top.constant *= 0.8f;
        self.table_name_label_leading.constant *= 0.8f;
        self.table_name_label_height.constant *= 0.8f;
        
        self.table_pts_label_top.constant *= 0.8f;
        self.table_pts_label_leading.constant *= 0.8f;
        self.table_pts_label_height.constant *= 0.8f;
        
        self.table_time_label_top.constant *= 0.8f;
        self.table_time_label_leading.constant *= 0.8f;
        self.table_time_label_height.constant *= 0.8f;
        
        self.table_pos_label_width.constant *= 0.8f;
        self.table_name_label_width.constant *= 0.8f;
        self.table_pts_label_width.constant *= 0.8f;
        self.table_time_label_width.constant *= 0.8f;

//        [self.quiz_title_label setFont:[UIFont systemFontOfSize:30]];
//        [self.table_pos_label setFont:[UIFont systemFontOfSize:25]];
//        [self.table_name_label setFont:[UIFont systemFontOfSize:25]];
//        [self.table_pts_label setFont:[UIFont systemFontOfSize:25]];
//        [self.table_time_label setFont:[UIFont systemFontOfSize:25]];
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
    static NSString *CellIdentifier = @"RandomResultTableCell_identifier";
    
    RandomResultTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
//    if (cell) {
//        cell = nil;
//    }
//    
    if (cell == nil) {
        cell = [[RandomResultTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSString *v_pos_str, *v_user_name, *v_point_str, *v_time_str;
    
    RandomQuizRateClass *result = [self.m_quiz_result_arr objectAtIndex:indexPath.row];

//    if (result.m_place == 1) {
//        [cell.m_pos_img setImage:[UIImage imageNamed:@"first_place_icon"]];
//        [cell.m_pos_label setHidden:YES];
//    }
//    else if (result.m_place == 2) {
//        [cell.m_pos_img setImage:[UIImage imageNamed:@"second_place_icon"]];
//        [cell.m_pos_label setHidden:YES];
//    }
//    else if (result.m_place == 3) {
//        [cell.m_pos_img setImage:[UIImage imageNamed:@"third_place_icon"]];
//        [cell.m_pos_label setHidden:YES];
//    }else{
//        [cell.m_pos_img setHidden:YES];
//        [cell.m_pos_label setHidden:NO];
//    }
    
    if (indexPath.row == 0) {
        [cell.m_pos_img setImage:[UIImage imageNamed:@"first_place_icon"]];
        [cell.m_pos_label setHidden:YES];
    }
    else if (indexPath.row == 1) {
        [cell.m_pos_img setImage:[UIImage imageNamed:@"second_place_icon"]];
        [cell.m_pos_label setHidden:YES];
    }
    else if (indexPath.row == 2) {
        [cell.m_pos_img setImage:[UIImage imageNamed:@"third_place_icon"]];
        [cell.m_pos_label setHidden:YES];
    }else{
        [cell.m_pos_img setHidden:YES];
        [cell.m_pos_label setHidden:NO];
    }
    
    v_pos_str = [NSString stringWithFormat:@"%d", result.m_place];
    v_user_name = result.m_userName;
    v_point_str = [NSString stringWithFormat:@"%d", result.m_point];
    v_time_str = [NSString stringWithFormat:@"%.01f", result.m_time/1000.0];
    
    cell.m_pos_label.text = v_pos_str;
    cell.m_userName.text = v_user_name;
    cell.m_point.text = v_point_str;
    cell.m_time.text = v_time_str;
    
    if (g_GameSet.g_curDeviceModel == IPHONE_5) {
        [cell.m_pos_label setFont:[UIFont systemFontOfSize:16]];
        [cell.m_userName setFont:[UIFont systemFontOfSize:16]];
        [cell.m_point setFont:[UIFont systemFontOfSize:16]];
        [cell.m_time setFont:[UIFont systemFontOfSize:16]];
        
        cell.m_pos_label_width.constant = 35;
        cell.m_image_width.constant = 35;
        cell.m_name_width.constant  = 100;
        cell.m_pts_width.constant   = 45;
        cell.m_time_width.constant  = 55;
        
    }
    else if (g_GameSet.g_curDeviceModel == IPHONE_6) {
        [cell.m_pos_label setFont:[UIFont systemFontOfSize:18]];
        [cell.m_userName setFont:[UIFont systemFontOfSize:18]];
        [cell.m_point setFont:[UIFont systemFontOfSize:18]];
        [cell.m_time setFont:[UIFont systemFontOfSize:18]];
        
        cell.m_pos_label_width.constant = 45;
        cell.m_image_width.constant = 45;
        cell.m_name_width.constant  = 120;
        cell.m_pts_width.constant   = 55;
        cell.m_time_width.constant  = 65;
    }
    else if (g_GameSet.g_curDeviceModel == IPHONE_6_PLUS) {
        [cell.m_pos_label setFont:[UIFont systemFontOfSize:18]];
        [cell.m_userName setFont:[UIFont systemFontOfSize:18]];
        [cell.m_point setFont:[UIFont systemFontOfSize:18]];
        [cell.m_time setFont:[UIFont systemFontOfSize:18]];
        
        cell.m_pos_label_width.constant = 50;
        cell.m_image_width.constant = 50;
        cell.m_name_width.constant  = 130;
        cell.m_pts_width.constant   = 60;
        cell.m_time_width.constant  = 80;
        
    }
    else if (g_GameSet.g_curDeviceModel == IPHONE_4) {
        [cell.m_pos_label setFont:[UIFont systemFontOfSize:18]];
        [cell.m_userName setFont:[UIFont systemFontOfSize:16]];
        [cell.m_point setFont:[UIFont systemFontOfSize:16]];
        [cell.m_time setFont:[UIFont systemFontOfSize:16]];
        
        cell.m_pos_label_width.constant = 35;
        cell.m_image_width.constant = 35;
        cell.m_name_width.constant  = 100;
        cell.m_pts_width.constant   = 45;
        cell.m_time_width.constant  = 55;
        
    }
    else if (g_GameSet.g_curDeviceModel == IPAD) {
        [cell.m_userName setFont:[UIFont systemFontOfSize:36]];
        [cell.m_point setFont:[UIFont systemFontOfSize:36]];
        [cell.m_time setFont:[UIFont systemFontOfSize:36]];
        
        cell.m_pos_label_width.constant = 100;
        cell.m_image_width.constant = 100;
        cell.m_name_width.constant  = 270;
        cell.m_pts_width.constant   = 120;
        cell.m_time_width.constant  = 120;
        
    }

    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float height = 45.0f;
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
    
    [g_GameSet.g_randomQuiz_rate_Arr removeAllObjects];
    
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
