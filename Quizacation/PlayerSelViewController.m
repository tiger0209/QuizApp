//
//  PlaySelViewController.m
//  Quizacation
//
//  Created by Maksym on 12/30/15.
//  Copyright © 2015 Maksym. All rights reserved.
//

#import "PlayerSelViewController.h"
#import "GameSet.h"
#import "PlayersTableCell.h"
#import "JSON.h"
#import "PlayerInviteViewController.h"


@interface PlayerSelViewController ()<UITableViewDelegate, UITableViewDataSource>
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
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *table_frame_height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *submit_btn_top;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *table_title_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *table_label_height;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *players_table_height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *players_table_top;

@property (weak, nonatomic) IBOutlet UILabel *title_label;
@property (weak, nonatomic) IBOutlet UIImageView *table_frame;
@property (weak, nonatomic) IBOutlet UIButton *submit_btn;
@property (weak, nonatomic) IBOutlet UITableView *playersTableView;
@property (weak, nonatomic) IBOutlet UILabel *player_table_title_label;

@property (strong, nonatomic) NSMutableArray                *m_user_arr;
@property (strong, nonatomic) NSString                      *m_sel_userid;
@property (strong, nonatomic) NSString                      *m_sel_userName;
//@property (strong, nonatomic) NSString                      *m_sel_blogid;


@end

@implementation PlayerSelViewController

@synthesize q_small_charac_width, q_small_charac_height, title_label, title_label_height, title_label_top, title_label_leading, title_label_width, table_frame, table_frame_height, submit_btn, submit_btn_top;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.m_user_arr = g_GameSet.g_h2h_user_Arr;
    
    [self.playersTableView registerNib:[UINib nibWithNibName:@"PlayersTableCell" bundle:nil] forCellReuseIdentifier:@"PlayersTableCell_identifier"];
    [self.playersTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.playersTableView setScrollEnabled:YES];

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
//        self.table_frame_height.constant *= 1.2f;
        self.submit_btn_top.constant *= 1.2f;

//        self.table_title_top.constant *= 1.2f;
//        self.table_label_height.constant *= 1.2f;
//        self.players_table_top.constant *= 1.2f;
//        self.players_table_height.constant *= 1.2f;

        [self.title_label setFont:[UIFont systemFontOfSize:30]];
        [self.submit_btn.titleLabel setFont:[UIFont systemFontOfSize:30]];
        [self.player_table_title_label setFont:[UIFont systemFontOfSize:25]];
        
    }
    else if (g_GameSet.g_curDeviceModel == IPHONE_6_PLUS) {
        self.q_small_charac_top.constant *= 1.3f;
        self.q_small_charac_height.constant *= 1.3f;
        self.q_small_charac_width.constant *= 1.3f;
        self.title_label_leading.constant *= 1.3f;
        self.title_label_top.constant *= 1.3f;
        self.title_label_height.constant *= 1.3f;
//        self.title_label_width.constant *= 1.3f;
//        self.table_frame_height.constant *= 1.3f;
        self.submit_btn_top.constant *= 1.3f;

//        self.table_title_top.constant *= 1.3f;
//        self.table_label_height.constant *= 1.3f;
//        self.players_table_top.constant *= 1.3f;
//        self.players_table_height.constant *= 1.3f;

        [self.title_label setFont:[UIFont systemFontOfSize:30]];
        [self.submit_btn.titleLabel setFont:[UIFont systemFontOfSize:30]];
        [self.player_table_title_label setFont:[UIFont systemFontOfSize:25]];
    }
    else if (g_GameSet.g_curDeviceModel == IPHONE_4) {
        self.q_small_charac_top.constant *= 0.8f;
        self.q_small_charac_height.constant *= 0.8f;
        self.q_small_charac_width.constant *= 0.8f;
        self.title_label_leading.constant *= 0.8f;
        self.title_label_top.constant *= 0.8f;
        self.title_label_height.constant *= 0.8f;
//        self.title_label_width.constant *= 0.8f;
//        self.table_frame_height.constant *= 1.0f;
        self.submit_btn_top.constant *= 0.8f;

//        self.table_title_top.constant *= 0.8f;
//        self.table_label_height.constant *= 0.8f;
//        self.players_table_top.constant *= 0.8f;
//        self.players_table_height.constant *= 0.8f;

//        [self.title_label setFont:[UIFont systemFontOfSize:30]];
//        [self.submit_btn.titleLabel setFont:[UIFont systemFontOfSize:30]];
//        [self.player_table_title_label setFont:[UIFont systemFontOfSize:25]];
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
    return [self.m_user_arr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PlayersTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlayersTableCell_identifier"];
    
    NSArray *v_arr = [self.m_user_arr objectAtIndex:indexPath.row];
    NSString *player_name = [v_arr objectAtIndex:0];
//    NSString *user_id = [v_arr objectAtIndex:1];

    cell.player_name_label.text = player_name;
    
    if (g_GameSet.g_curDeviceModel == IPHONE_5) {
        [cell.player_name_label setFont:[UIFont systemFontOfSize:18]];
    }
    else if (g_GameSet.g_curDeviceModel == IPHONE_6) {
        [cell.player_name_label setFont:[UIFont systemFontOfSize:18]];
    }
    else if (g_GameSet.g_curDeviceModel == IPHONE_6_PLUS) {
        [cell.player_name_label setFont:[UIFont systemFontOfSize:18]];
    }
    else if (g_GameSet.g_curDeviceModel == IPAD) {
        [cell.player_name_label setFont:[UIFont systemFontOfSize:36]];
    }
    else if (g_GameSet.g_curDeviceModel == IPHONE_4) {
        [cell.player_name_label setFont:[UIFont systemFontOfSize:18]];
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    PlayersTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlayersTableCell_identifier"];
    NSArray *v_arr = [self.m_user_arr objectAtIndex:indexPath.row];
    NSString *user_name = [v_arr objectAtIndex:0];
    NSString *user_id = [v_arr objectAtIndex:1];
    self.m_sel_userid = user_id;
    self.m_sel_userName = user_name;
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

- (IBAction)onSubmitBtn:(id)sender {
    
    g_GameSet.g_h2h_invite_user_id = self.m_sel_userid;
    g_GameSet.g_h2h_invite_user_name = self.m_sel_userName;

    if (self.m_sel_userName == nil) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"Please select a player" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                             {
                                 [alertController dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        [alertController addAction:ok];
        
        [self presentViewController:alertController animated:YES completion:nil];

    }else{
        UIStoryboard *storyboard;
        if (g_GameSet.g_curDeviceModel == IPAD)
        {
            storyboard = [UIStoryboard storyboardWithName:@"Main_iPad"
                                                   bundle:nil];
            
        }else{
            storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone"
                                                   bundle:nil];
        }
        
        PlayerInviteViewController *response_view =
        (PlayerInviteViewController *)
        [storyboard instantiateViewControllerWithIdentifier:@"PlayerInviteViewController"];
        [self showViewController:response_view sender:nil];

    }
}



@end
