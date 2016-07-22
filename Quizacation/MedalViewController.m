//
//  MedalViewController.m
//  Quizacation
//
//  Created by Maksym on 12/30/15.
//  Copyright © 2015 Maksym. All rights reserved.
//

#import "MedalViewController.h"
#import "GameSet.h"
#import "MedalsTableCell.h"
#import "JSON.h"

@interface MedalViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    NSMutableData      *receivedHomeViewData;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *q_small_charac_leading;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *q_small_charac_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *q_small_charac_height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *q_small_charac_width;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *medals_label_leading;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *medals_label_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *medals_label_height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *medals_label_width;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *medal_table_frame_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *user_name_label_bottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *medal_table_frame_height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *table_subject_label_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *table_crown_label_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *medal_table_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *medal_table_height;


@property (weak, nonatomic) IBOutlet UILabel *medals_label;
@property (weak, nonatomic) IBOutlet UILabel *user_name_label;
@property (weak, nonatomic) IBOutlet UITableView *medals_table;
@property (weak, nonatomic) IBOutlet UILabel *table_subject_label;
@property (weak, nonatomic) IBOutlet UILabel *table_crowns_label;

@property (strong, nonatomic) NSMutableArray *m_dataArray;


@end

@implementation MedalViewController

@synthesize q_small_charac_height, q_small_charac_top, q_small_charac_width, q_small_charac_leading, medal_table_frame_height, medal_table_frame_top, medals_label, medals_label_height, medals_label_leading, medals_label_top, medals_label_width, user_name_label_bottom;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.m_dataArray = [[NSMutableArray alloc] init];
    
    self.user_name_label.text = g_GameSet.g_cur_username;

    // Register the table cell
    [self.medals_table registerNib:[UINib nibWithNibName:@"MedalsTableCell" bundle:nil] forCellReuseIdentifier:@"MedalsTableCell_identifier"];

    [self.medals_table setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.medals_table setScrollEnabled:NO];

    [self adjust_constraints];
    
    [self getData];

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
        self.medals_label_leading.constant *= 1.2f;
        self.medals_label_top.constant *= 1.2f;
        self.medals_label_height.constant *= 1.2f;
        self.medals_label_width.constant *= 1.2f;
        self.user_name_label_bottom.constant *= 1.2f;
        self.medal_table_frame_height.constant *= 1.2f;
        self.table_subject_label_top.constant *= 1.2f;
        self.table_crown_label_top.constant *= 1.2f;
        self.medal_table_top.constant *= 1.2f;
        self.medal_table_height.constant *= 1.2f;
        
        [self.medals_label setFont:[UIFont systemFontOfSize:30]];
        [self.user_name_label setFont:[UIFont systemFontOfSize:30]];
        [self.table_subject_label setFont:[UIFont systemFontOfSize:22]];
        [self.table_crowns_label setFont:[UIFont systemFontOfSize:22]];
        
        
    }
    else if (g_GameSet.g_curDeviceModel == IPHONE_6_PLUS) {
        self.q_small_charac_top.constant *= 1.3f;
        self.q_small_charac_height.constant *= 1.3f;
        self.q_small_charac_width.constant *= 1.3f;
        self.q_small_charac_leading.constant *= 1.3f;
        self.medals_label_leading.constant *= 1.3f;
        self.medals_label_top.constant *= 1.3f;
        self.medals_label_height.constant *= 1.3f;
        self.medals_label_width.constant *= 1.3f;
        self.user_name_label_bottom.constant *= 1.3f;
        self.medal_table_frame_height.constant *= 1.3f;
        self.table_subject_label_top.constant *= 1.3f;
        self.table_crown_label_top.constant *= 1.3f;
        self.medal_table_top.constant *= 1.3f;
        self.medal_table_height.constant *= 1.3f;
        
        
        [self.medals_label setFont:[UIFont systemFontOfSize:30]];
        [self.user_name_label setFont:[UIFont systemFontOfSize:30]];
        [self.table_subject_label setFont:[UIFont systemFontOfSize:22]];
        [self.table_crowns_label setFont:[UIFont systemFontOfSize:22]];
    }
    else if (g_GameSet.g_curDeviceModel == IPHONE_4) {
        self.q_small_charac_top.constant *= 0.8f;
        self.q_small_charac_height.constant *= 0.8f;
        self.q_small_charac_width.constant *= 0.8f;
        self.q_small_charac_leading.constant *= 0.8f;
        self.medals_label_leading.constant *= 0.8f;
        self.medals_label_top.constant *= 0.8f;
        self.medals_label_height.constant *= 0.8f;
        self.medals_label_width.constant *= 0.8f;
        self.user_name_label_bottom.constant *= 0.8f;
        self.medal_table_frame_height.constant *= 0.8f;
        self.table_subject_label_top.constant *= 0.8f;
        self.table_crown_label_top.constant *= 0.8f;
        self.medal_table_top.constant *= 0.8f;
        self.medal_table_height.constant *= 0.8f;
        
//        [self.medals_label setFont:[UIFont systemFontOfSize:30]];
//        [self.user_name_label setFont:[UIFont systemFontOfSize:25]];
//        [self.table_subject_label setFont:[UIFont systemFontOfSize:25]];
//        [self.table_crowns_label setFont:[UIFont systemFontOfSize:25]];
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
    MedalsTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MedalsTableCell_identifier"];
    
    NSString *icon_name, *category_name, *point_num, *categoryName;
    switch (indexPath.row + 1) {
        case CTGY_SCIENCE:
            icon_name = @"science";
            for (NSDictionary *dic in self.m_dataArray) {
                category_name = [dic valueForKey:@"name"];
                if ([category_name isEqualToString:@"Science"]) {
//                    int category_id = [[dic valueForKey:@"category_id"] intValue];
                    categoryName = category_name;
                    int medal_count = [[dic valueForKey:@"medal"] intValue];
                    point_num = [NSString stringWithFormat:@"*%d", medal_count];
                }
            }
            break;
        case CTGY_ELECTIVES:
            icon_name = @"electives";
            for (NSDictionary *dic in self.m_dataArray) {
                category_name = [dic valueForKey:@"name"];
                if ([category_name isEqualToString:@"Elective"]) {
//                    int category_id = [[dic valueForKey:@"category_id"] intValue];
                    categoryName = category_name;
                   int medal_count = [[dic valueForKey:@"medal"] intValue];
                    point_num = [NSString stringWithFormat:@"*%d", medal_count];
                }
            }
            break;
        case CTGY_ENGLISH:
            icon_name = @"english";
            for (NSDictionary *dic in self.m_dataArray) {
                category_name = [dic valueForKey:@"name"];
                if ([category_name isEqualToString:@"English"]) {
//                    int category_id = [[dic valueForKey:@"category_id"] intValue];
                    categoryName = category_name;
                    int medal_count = [[dic valueForKey:@"medal"] intValue];
                    point_num = [NSString stringWithFormat:@"*%d", medal_count];
                }
            }
            break;
        case CTGY_HISTORY:
            icon_name = @"history";
            for (NSDictionary *dic in self.m_dataArray) {
                category_name = [dic valueForKey:@"name"];
                if ([category_name isEqualToString:@"History"]) {
//                    int category_id = [[dic valueForKey:@"category_id"] intValue];
                    categoryName = category_name;
                    int medal_count = [[dic valueForKey:@"medal"] intValue];
                    point_num = [NSString stringWithFormat:@"*%d", medal_count];
                }
            }
            break;
        case CTGY_MATH:
            icon_name = @"math";
            for (NSDictionary *dic in self.m_dataArray) {
                category_name = [dic valueForKey:@"name"];
                if ([category_name isEqualToString:@"Math"]) {
//                    int category_id = [[dic valueForKey:@"category_id"] intValue];
                    categoryName = category_name;
                    int medal_count = [[dic valueForKey:@"medal"] intValue];
                    point_num = [NSString stringWithFormat:@"*%d", medal_count];
                }
            }
            break;
        case CTGY_SPORTS:
            icon_name = @"sports";
            for (NSDictionary *dic in self.m_dataArray) {
                category_name = [dic valueForKey:@"name"];
                if ([category_name isEqualToString:@"Sports"]) {
//                    int category_id = [[dic valueForKey:@"category_id"] intValue];
                    categoryName = category_name;
                    int medal_count = [[dic valueForKey:@"medal"] intValue];
                    point_num = [NSString stringWithFormat:@"*%d", medal_count];
                }
            }
            break;
        case CTGY_ART:
            icon_name = @"art";
            for (NSDictionary *dic in self.m_dataArray) {
                category_name = [dic valueForKey:@"name"];
                if ([category_name isEqualToString:@"Art"]) {
//                    int category_id = [[dic valueForKey:@"category_id"] intValue];
                    categoryName = category_name;
                    int medal_count = [[dic valueForKey:@"medal"] intValue];
                    point_num = [NSString stringWithFormat:@"*%d", medal_count];
                }
            }
            break;
            
        default:
            break;
    }
    
    [cell.category_img_view setImage:[UIImage imageNamed:[NSString stringWithFormat:@"stat_%@_table_icon.png", icon_name]]];
    cell.category_name_label.text = categoryName;
    cell.points_label.text = point_num;
    [cell.crown_img_view setImage:[UIImage imageNamed:@"medals_crown_icon.png"]];
    
    if (g_GameSet.g_curDeviceModel == IPHONE_5) {
        [cell.category_name_label setFont:[UIFont systemFontOfSize:18]];
        [cell.points_label setFont:[UIFont systemFontOfSize:18]];
    }
    else if (g_GameSet.g_curDeviceModel == IPHONE_6) {
        [cell.category_name_label setFont:[UIFont systemFontOfSize:18]];
        [cell.points_label setFont:[UIFont systemFontOfSize:18]];
    }
    else if (g_GameSet.g_curDeviceModel == IPHONE_6_PLUS) {
        [cell.category_name_label setFont:[UIFont systemFontOfSize:18]];
        [cell.points_label setFont:[UIFont systemFontOfSize:18]];
    }
    else if (g_GameSet.g_curDeviceModel == IPAD) {
        [cell.category_name_label setFont:[UIFont systemFontOfSize:36]];
        [cell.points_label setFont:[UIFont systemFontOfSize:36]];
        cell.point_label_width.constant *= 2.0f;
    }
    else if (g_GameSet.g_curDeviceModel == IPHONE_4) {
        [cell.category_name_label setFont:[UIFont systemFontOfSize:18]];
        [cell.points_label setFont:[UIFont systemFontOfSize:18]];
    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float height = 40.0f;
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
        height *= 1.75f;
    }
    else if (g_GameSet.g_curDeviceModel == IPHONE_4) {
        height *= 0.8f;
    }
    return height;
}


- (void)getData
{
    NSString *strReqeust = [NSString stringWithFormat:@"user_id=%@&blog_id=%@&request_type=4",g_GameSet.g_user_id, g_GameSet.g_blog_id];
    
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
    
    int v_status = [[dic objectForKey:@"status"] intValue];
    NSString *v_message = [dic objectForKey:@"message"];

    if (v_status == 1) {
        NSArray *v_array = [dic objectForKey:@"data"];
        self.m_dataArray = v_array;
        
        [self.medals_table reloadData];
        
    }else{
        if ([UIAlertController class])
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:v_message preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                 {
                                     [alertController dismissViewControllerAnimated:YES completion:nil];
                                     
                                 }];
            [alertController addAction:ok];
            
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
        else
        {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"" message:v_message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [alert show];
        }
    }

    
    
}


@end
