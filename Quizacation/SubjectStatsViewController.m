//
//  SubjectStatsViewController.m
//  Quizacation
//
//  Created by Maksym on 12/30/15.
//  Copyright © 2015 Maksym. All rights reserved.
//

#import "SubjectStatsViewController.h"
#import "GameSet.h"
#import "SubStatTableCell.h"
#import "JSON.h"


@interface SubjectStatsViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableData      *receivedHomeViewData;
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *q_small_charac_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *q_small_charac_height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *q_small_charac_width;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *q_small_charac_leading;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sub_stat_leading;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sub_stat_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *user_name_label_bottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sub_stat_table_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sub_stat_table_height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sub_stat_height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sub_stat_width;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableview_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableview_height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *table_title_label_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *table_label_height;


@property (weak, nonatomic) IBOutlet UILabel *sub_stat_label;
@property (weak, nonatomic) IBOutlet UILabel *user_name_label;
@property (weak, nonatomic) IBOutlet UILabel *table_title_label;
@property (weak, nonatomic) IBOutlet UITableView *subject_stat_tableView;

@property (strong, nonatomic) NSMutableArray *m_pro_arr;
@property (strong, nonatomic) NSMutableArray *m_point_arr;



@end

@implementation SubjectStatsViewController

@synthesize q_small_charac_height, q_small_charac_top, q_small_charac_width, q_small_charac_leading, sub_stat_label, sub_stat_leading, sub_stat_table_top, sub_stat_top, user_name_label, user_name_label_bottom, sub_stat_table_height, sub_stat_height, sub_stat_width, tableview_height, tableview_top, table_title_label_top, table_label_height, table_title_label;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.user_name_label.text = g_GameSet.g_cur_username;

    /////
    self.m_pro_arr = [[NSMutableArray alloc] initWithObjects:@"", @"", @"", @"", @"", @"", @"", @"", nil];
    self.m_point_arr = [[NSMutableArray alloc] initWithObjects:@"", @"", @"", @"", @"", @"", @"", @"", nil];
    
    [self getSubjectStatData];
    
    // Register the table cell
    [self.subject_stat_tableView registerNib:[UINib nibWithNibName:@"SubStatTableCell" bundle:nil] forCellReuseIdentifier:@"SubStatTableCell_identifier"];

    [self.subject_stat_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.subject_stat_tableView setScrollEnabled:NO];
    
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
        self.sub_stat_leading.constant *= 1.2f;
        self.sub_stat_top.constant *= 1.2f;
        self.user_name_label_bottom.constant *= 1.2f;
        self.sub_stat_table_top.constant *= 1.2f;
        self.sub_stat_table_height.constant *= 1.2f;
        self.sub_stat_width.constant *= 1.2f;
        self.sub_stat_height.constant *= 1.2f;
        self.tableview_top.constant *= 1.2f;
        self.tableview_height.constant *= 1.2f;
        self.table_title_label_top.constant *= 1.2f;
        self.table_label_height.constant *= 1.2f;
        
        
        [self.sub_stat_label setFont:[UIFont systemFontOfSize:30]];
        [self.user_name_label setFont:[UIFont systemFontOfSize:30]];
        [self.table_title_label setFont:[UIFont systemFontOfSize:25]];
        
    }
    else if (g_GameSet.g_curDeviceModel == IPHONE_6_PLUS) {
        self.q_small_charac_top.constant *= 1.3f;
        self.q_small_charac_height.constant *= 1.3f;
        self.q_small_charac_width.constant *= 1.3f;
        self.q_small_charac_leading.constant *= 1.3f;
        self.sub_stat_leading.constant *= 1.3f;
        self.sub_stat_top.constant *= 1.3f;
        self.user_name_label_bottom.constant *= 1.3f;
        self.sub_stat_table_top.constant *= 1.3f;
        self.sub_stat_table_height.constant *= 1.3f;
        self.sub_stat_width.constant *= 1.3f;
        self.sub_stat_height.constant *= 1.3f;
        self.tableview_top.constant *= 1.3f;
        self.tableview_height.constant *= 1.3f;
        self.table_title_label_top.constant *= 1.3f;
        self.table_label_height.constant *= 1.3f;
        
        [self.sub_stat_label setFont:[UIFont systemFontOfSize:30]];
        [self.user_name_label setFont:[UIFont systemFontOfSize:30]];
        [self.table_title_label setFont:[UIFont systemFontOfSize:25]];
    }
    else if (g_GameSet.g_curDeviceModel == IPHONE_4) {
        self.q_small_charac_top.constant *= 0.8f;
        self.q_small_charac_height.constant *= 0.8f;
        self.q_small_charac_width.constant *= 0.8f;
        self.q_small_charac_leading.constant *= 0.8f;
        self.sub_stat_leading.constant *= 0.8f;
        self.sub_stat_top.constant *= 0.8f;
        self.user_name_label_bottom.constant *= 0.8f;
        self.sub_stat_table_top.constant *= 0.8f;
        self.sub_stat_table_height.constant *= 0.8f;
        self.sub_stat_width.constant *= 1.0f;
        self.sub_stat_height.constant *= 0.8f;
        self.tableview_top.constant *= 0.8f;
        self.tableview_height.constant *= 0.8f;
        self.table_title_label_top.constant *= 0.8f;
        self.table_label_height.constant *= 0.8f;
        
//        [self.sub_stat_label setFont:[UIFont systemFontOfSize:50]];
//        [self.user_name_label setFont:[UIFont systemFontOfSize:25]];
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
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SubStatTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SubStatTableCell_identifier"];
    
    NSString *icon_name, *category_name, *pro_num, *point_num;
    switch (indexPath.row + 1) {
        case CTGY_SCIENCE:
            icon_name = @"science";
            category_name = @"SCIENCE";
            break;
        case CTGY_ELECTIVES:
            icon_name = @"electives";
            category_name = @"ELECTIVES";
            break;
        case CTGY_ENGLISH:
            icon_name = @"english";
            category_name = @"ENGLISH";
            break;
        case CTGY_HISTORY:
            icon_name = @"history";
            category_name = @"HISTORY";
            break;
        case CTGY_MATH:
            icon_name = @"math";
            category_name = @"MATH";
            break;
        case CTGY_SPORTS:
            icon_name = @"sports";
            category_name = @"SPORTS";
            break;
        case CTGY_ART:
            icon_name = @"art";
            category_name = @"ART";
            break;            
        default:
            break;
    }
    
    pro_num = [self.m_pro_arr objectAtIndex:indexPath.row];
    point_num = [self.m_point_arr objectAtIndex:indexPath.row];

    
    [cell.category_img_view setImage:[UIImage imageNamed:[NSString stringWithFormat:@"stat_%@_table_icon.png", icon_name]]];
    cell.category_name_label.text = category_name;
    cell.points_label.text = point_num;
    cell.pro_label.text = [NSString stringWithFormat:@"%@%%", pro_num];
    
    if (g_GameSet.g_curDeviceModel == IPHONE_5) {
        [cell.category_name_label setFont:[UIFont systemFontOfSize:18]];
        [cell.points_label setFont:[UIFont systemFontOfSize:18]];
        [cell.pro_label setFont:[UIFont systemFontOfSize:18]];
    }
    else if (g_GameSet.g_curDeviceModel == IPHONE_6) {
        [cell.category_name_label setFont:[UIFont systemFontOfSize:18]];
        [cell.points_label setFont:[UIFont systemFontOfSize:18]];
        [cell.pro_label setFont:[UIFont systemFontOfSize:18]];
    }
    else if (g_GameSet.g_curDeviceModel == IPHONE_6_PLUS) {
        [cell.category_name_label setFont:[UIFont systemFontOfSize:18]];
        [cell.points_label setFont:[UIFont systemFontOfSize:18]];
        [cell.pro_label setFont:[UIFont systemFontOfSize:18]];
    }
    else if (g_GameSet.g_curDeviceModel == IPAD) {
        [cell.category_name_label setFont:[UIFont systemFontOfSize:36]];
        [cell.points_label setFont:[UIFont systemFontOfSize:36]];
        [cell.pro_label setFont:[UIFont systemFontOfSize:36]];
        cell.pro_label_width.constant *= 1.5f;
        cell.point_label_width.constant *= 2.0f;
    }
    else if (g_GameSet.g_curDeviceModel == IPHONE_4) {
        [cell.category_name_label setFont:[UIFont systemFontOfSize:18]];
        [cell.points_label setFont:[UIFont systemFontOfSize:18]];
        [cell.pro_label setFont:[UIFont systemFontOfSize:18]];
    }

    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float height = 36.0f;
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


- (void)getSubjectStatData
{
    NSString *strReqeust = [NSString stringWithFormat:@"user_id=%@&blog_id=%@&request_type=2",g_GameSet.g_user_id, g_GameSet.g_blog_id];

    
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
    
//    int v_status = [dic objectForKey:@"status"];
    NSArray *v_data_arr = [dic objectForKey:@"data"];
//    NSString *v_message = [dic objectForKey:@"message"];
    
    int v_index = 0;
    for (NSDictionary* dic in v_data_arr) {
//        NSString *v_cat_name = [dic objectForKey:@"name"];
        NSArray *v_profile = [dic objectForKey:@"profile"];
        
        [self.m_pro_arr replaceObjectAtIndex:v_index withObject:[v_profile objectAtIndex:0]];
        [self.m_point_arr replaceObjectAtIndex:v_index withObject:[v_profile objectAtIndex:1]];
        v_index++;
    }
    
    [self.subject_stat_tableView reloadData];
    
}


@end
