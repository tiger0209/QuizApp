//
//  StealCrownViewController.m
//  Quizacation
//
//  Created by Maksym on 2/16/15.
//  Copyright © 2015 Maksym. All rights reserved.
//

#import "StealCrownViewController.h"
#import "GameSet.h"
#import "StealCrownRespViewController.h"
#import "JSON.h"


@interface StealCrownViewController ()
{
    NSMutableData      *receivedHomeViewData;
    
    int m_cur_categoryId;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *q_small_charac_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *q_small_charac_height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *q_small_charac_width;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *title_label_leading;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *title_label_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *title_label_height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *title_label_width;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *comment_label_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *comment_label_height;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *crown_icon_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *crown_icon_height;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *comment2_label_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *comment2_label_height;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *category_scrollview_height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *category_scrollview_top;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *left_arrow_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *left_arrow_height;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *right_arrow_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *right_arrow_height;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *stealBtn_height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *stealBtn_bottom;

@property (weak, nonatomic) IBOutlet UILabel *title_label;
@property (weak, nonatomic) IBOutlet UILabel *comment_label;
@property (weak, nonatomic) IBOutlet UILabel *comment2_label;
@property (weak, nonatomic) IBOutlet UIButton *stealBtn;
@property (weak, nonatomic) IBOutlet UIScrollView *category_scrollview;
@property (weak, nonatomic) IBOutlet UIButton *leftArrowBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightArrowBtn;



@end

@implementation StealCrownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    m_cur_categoryId = 0;
    
    [self adjust_constraints];
    [self make_categoryScrollView];
    
    self.leftArrowBtn.enabled = NO;
    self.rightArrowBtn.enabled = YES;
    
    [self.category_scrollview setScrollEnabled:NO];
    
    [self.view bringSubviewToFront:self.leftArrowBtn];
    [self.view bringSubviewToFront:self.rightArrowBtn];
    
    g_GameSet.g_cur_viewcontroller = self;

}

- (void) adjust_constraints
{
    if (g_GameSet.g_curDeviceModel == IPHONE_5) {
        self.q_small_charac_top.constant *= 0.8f;
        self.q_small_charac_height.constant *= 0.8f;
        self.q_small_charac_width.constant *= 0.8f;
        self.title_label_leading.constant *= 0.8f;
        self.title_label_top.constant *= 0.8f;
        self.title_label_height.constant *= 0.8f;
        
        self.comment_label_top.constant *= 0.8f;
        self.comment_label_height.constant *= 0.8f;
        
        self.crown_icon_top.constant *= 0.8f;
        self.crown_icon_height.constant *= 0.8f;
        
        self.comment2_label_top.constant *= 0.8f;
        self.comment2_label_height.constant *= 0.8f;
        
        self.category_scrollview_height.constant *= 1.2f;
        self.category_scrollview_top.constant *= 0.8f;
        
        self.left_arrow_top.constant *= 1.0f;
        self.left_arrow_height.constant *= 1.0f;
        
        self.right_arrow_top.constant *= 1.0f;
        self.right_arrow_height.constant *= 1.0f;
        
        self.stealBtn_bottom.constant *= 1.0f;
        self.stealBtn_height.constant *= 1.0f;
        
        [self.title_label setFont:[UIFont systemFontOfSize:30]];
        [self.comment_label setFont:[UIFont systemFontOfSize:25]];
        [self.comment2_label setFont:[UIFont systemFontOfSize:25]];
        [self.stealBtn.titleLabel setFont:[UIFont systemFontOfSize:30]];

    }
    else if (g_GameSet.g_curDeviceModel == IPHONE_6) {
        
        self.q_small_charac_top.constant *= 1.0f;
        self.q_small_charac_height.constant *= 1.0f;
        self.q_small_charac_width.constant *= 1.0f;
        self.title_label_leading.constant *= 1.0f;
        self.title_label_top.constant *= 1.0f;
        self.title_label_height.constant *= 1.0f;
        
        self.comment_label_top.constant *= 1.0f;
        self.comment_label_height.constant *= 1.0f;

        self.crown_icon_top.constant *= 1.0f;
        self.crown_icon_height.constant *= 1.0f;

        self.comment2_label_top.constant *= 1.0f;
        self.comment2_label_height.constant *= 1.0f;

        self.category_scrollview_height.constant *= 1.2f;
        self.category_scrollview_top.constant *= 1.2f;
        
        self.left_arrow_top.constant *= 1.0f;
        self.left_arrow_height.constant *= 1.0f;
        
        self.right_arrow_top.constant *= 1.0f;
        self.right_arrow_height.constant *= 1.0f;

        self.stealBtn_bottom.constant *= 1.2f;
        self.stealBtn_height.constant *= 1.2f;
        
        [self.title_label setFont:[UIFont systemFontOfSize:30]];
        [self.comment_label setFont:[UIFont systemFontOfSize:25]];
        [self.comment2_label setFont:[UIFont systemFontOfSize:25]];
        [self.stealBtn.titleLabel setFont:[UIFont systemFontOfSize:30]];
    }
    else if (g_GameSet.g_curDeviceModel == IPHONE_6_PLUS) {
        self.q_small_charac_top.constant *= 1.2f;
        self.q_small_charac_height.constant *= 1.2f;
        self.q_small_charac_width.constant *= 1.2f;
        self.title_label_leading.constant *= 1.2f;
        self.title_label_top.constant *= 1.2f;
        self.title_label_height.constant *= 1.2f;
        
        self.comment_label_top.constant *= 1.2f;
        self.comment_label_height.constant *= 1.2f;
        
        self.crown_icon_top.constant *= 1.2f;
        self.crown_icon_height.constant *= 1.2f;
        
        self.comment2_label_top.constant *= 1.2f;
        self.comment2_label_height.constant *= 1.2f;
        
        self.category_scrollview_height.constant *= 1.2f;
        self.category_scrollview_top.constant *= 1.2f;
        
        self.left_arrow_top.constant *= 1.2f;
        self.left_arrow_height.constant *= 1.2f;
        
        self.right_arrow_top.constant *= 1.2f;
        self.right_arrow_height.constant *= 1.2f;
        
        self.stealBtn_bottom.constant *= 1.2f;
        self.stealBtn_height.constant *= 1.2f;
        
        [self.title_label setFont:[UIFont systemFontOfSize:30]];
        [self.comment_label setFont:[UIFont systemFontOfSize:25]];
        [self.comment2_label setFont:[UIFont systemFontOfSize:25]];
        [self.stealBtn.titleLabel setFont:[UIFont systemFontOfSize:30]];

    }
    else if (g_GameSet.g_curDeviceModel == IPHONE_4) {
        self.q_small_charac_top.constant *= 0.8f;
        self.q_small_charac_height.constant *= 0.8f;
        self.q_small_charac_width.constant *= 0.8f;
        self.title_label_leading.constant *= 0.8f;
        self.title_label_top.constant *= 0.8f;
        self.title_label_height.constant *= 0.8f;
        
        self.comment_label_top.constant *= 0.5f;
        self.comment_label_height.constant *= 0.5f;
        
        self.crown_icon_top.constant *= 0.8f;
        self.crown_icon_height.constant *= 0.8f;
        
        self.comment2_label_top.constant *= 0.5f;
        self.comment2_label_height.constant *= 0.5f;
        
        self.category_scrollview_height.constant *= 1.2f;
        self.category_scrollview_top.constant *= 0.8f;
        
        self.left_arrow_top.constant *= 1.0f;
        self.left_arrow_height.constant *= 0.8f;
        
        self.right_arrow_top.constant *= 1.0f;
        self.right_arrow_height.constant *= 0.8f;
        
        self.stealBtn_bottom.constant *= 0.8f;
        self.stealBtn_height.constant *= 0.8f;
        
        [self.title_label setFont:[UIFont systemFontOfSize:25]];
        [self.comment_label setFont:[UIFont systemFontOfSize:20]];
        [self.comment2_label setFont:[UIFont systemFontOfSize:20]];
        [self.stealBtn.titleLabel setFont:[UIFont systemFontOfSize:25]];

    }
    
}

-(void) make_categoryScrollView
{
    CGRect pageFrame;
    UIView *v_pageImageFrame;
    UIImageView *v_pageImageView;
    UIImage *v_category_Image;
    NSString *v_category_imageName;

    UILabel *v_category_nameLevel;
    
    float v_screen_width = self.view.bounds.size.width;
    float v_screen_height = self.category_scrollview.frame.size.height;
    
    [self.category_scrollview setBackgroundColor:[UIColor clearColor]];
    [self.category_scrollview setPagingEnabled: YES] ;
    [self.category_scrollview setContentSize: CGSizeMake(v_screen_width * 7, v_screen_height)] ;

    NSInteger count = [g_GameSet.g_h2h_steal_Category_Arr count];
    
    for (int i = 0 ; i < count ; i++)
    {
        // determine the frame of the current page
        pageFrame = CGRectMake(i * v_screen_width, 0.0f, v_screen_width, v_screen_height) ;
        
        NSDictionary *v_dic = [g_GameSet.g_h2h_steal_Category_Arr objectAtIndex:i];
        NSString     *v_category_name = [v_dic objectForKey:@"name"];
        
        if ([v_category_name isEqualToString:@"Science"]) {
            v_category_imageName = @"stat_science_table_icon.png";
        }
        if ([v_category_name isEqualToString:@"Elective"]) {
            v_category_imageName = @"stat_electives_table_icon.png";
        }
        if ([v_category_name isEqualToString:@"English"]) {
            v_category_imageName = @"stat_english_table_icon.png";
        }
        if ([v_category_name isEqualToString:@"History"]) {
            v_category_imageName = @"stat_history_table_icon.png";
        }
        if ([v_category_name isEqualToString:@"Math"]) {
            v_category_imageName = @"stat_math_table_icon.png";
        }
        if ([v_category_name isEqualToString:@"Sports"]) {
            v_category_imageName = @"stat_sports_table_icon.png";
        }
        if ([v_category_name isEqualToString:@"Art"]) {
            v_category_imageName = @"stat_art_table_icon.png";
        }

        v_category_Image = [UIImage imageNamed:v_category_imageName];
        
        float v_ratio, v_width, v_height;
        
        float v_label_height = 0;
        float v_label_height_1 = 0;
        float v_label_fontsize;
        if (g_GameSet.g_curDeviceModel == IPHONE_5) {
            v_label_height = 30;
            v_label_fontsize = 18;
        }
        else if (g_GameSet.g_curDeviceModel == IPHONE_6) {
            v_label_height = 30;
            v_label_fontsize = 22;
        }
        else if (g_GameSet.g_curDeviceModel == IPHONE_6_PLUS) {
            v_label_height = 30;
            v_label_fontsize = 25;
        }
        else if (g_GameSet.g_curDeviceModel == IPHONE_4) {
            v_label_height = 20;
            v_label_fontsize = 15;
        }
        else if (g_GameSet.g_curDeviceModel == IPAD) {
            v_label_height = 30;
            v_label_fontsize = 25;
            v_label_height_1 = 30;
        }

        if (v_category_Image.size.height >= pageFrame.size.height - v_label_height) {
            v_ratio = v_category_Image.size.height / (pageFrame.size.height - v_label_height);
            v_height = pageFrame.size.height - v_label_height;
            v_width = v_category_Image.size.width  / v_ratio;
            if (v_width >= v_height) {
                v_width = v_height;
            }
            
        }else{
            v_ratio = (pageFrame.size.height - v_label_height) / v_category_Image.size.height;
            v_height = pageFrame.size.height - v_label_height;
            v_width = v_category_Image.size.width * v_ratio;
            if (v_width >= v_height) {
                v_width = v_height;
            }
        }
        
        v_pageImageView = [[UIImageView alloc] initWithImage:v_category_Image];
        v_pageImageView.frame = CGRectMake(0,
                                           0,
                                           v_width,
                                           v_height - v_label_height_1);
        
        v_category_nameLevel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, v_width, v_label_height)];
        
        v_category_nameLevel.text = v_category_name;
        v_category_nameLevel.textColor = [UIColor whiteColor];
        v_category_nameLevel.font = [UIFont systemFontOfSize:v_label_fontsize];
        v_category_nameLevel.textAlignment = NSTextAlignmentCenter;
        
        [v_category_nameLevel setFrame:CGRectMake(0,
                                            v_height - v_label_height_1,
                                            v_width,
                                            v_label_height + v_label_height_1)];
        
        v_pageImageFrame = [[UIView alloc] initWithFrame:CGRectMake(pageFrame.origin.x + pageFrame.size.width/2  - v_width/2,
                                                                    pageFrame.origin.y + pageFrame.size.height/2 - v_height/2,
                                                                    v_width,
                                                                    v_height + v_label_height)];
        
        [v_pageImageFrame setBackgroundColor:[UIColor clearColor]];
        [v_pageImageFrame addSubview:v_pageImageView];
        [v_pageImageFrame addSubview:v_category_nameLevel];

        [self.category_scrollview addSubview: v_pageImageFrame];
    }
}

- (IBAction)onLeftArrow:(id)sender {
    
    m_cur_categoryId--;
    if (m_cur_categoryId <= 0) {
        m_cur_categoryId = 0;
        self.leftArrowBtn.enabled = NO;
        self.rightArrowBtn.enabled = YES;

    }else{
        self.leftArrowBtn.enabled = YES;
        self.rightArrowBtn.enabled = YES;

    }
    [self.category_scrollview setContentOffset: CGPointMake(self.view.bounds.size.width * m_cur_categoryId, self.category_scrollview.contentOffset.y) animated: YES] ;

}

- (IBAction)onRightArrow:(id)sender {
    m_cur_categoryId++;
    
    int count = [g_GameSet.g_h2h_steal_Category_Arr count];
    
    if (m_cur_categoryId >= count - 1) {
        m_cur_categoryId = count - 1;
        self.rightArrowBtn.enabled = NO;
        self.leftArrowBtn.enabled = YES;

    }else{
        self.rightArrowBtn.enabled = YES;
        self.leftArrowBtn.enabled = YES;

    }
    
    [self.category_scrollview setContentOffset: CGPointMake(self.view.bounds.size.width * m_cur_categoryId, self.category_scrollview.contentOffset.y) animated: YES] ;
    
}

- (IBAction)onStealBtn:(id)sender {
    
    [self inform_categoryId:m_cur_categoryId];

}

- (void)inform_categoryId:(int)category_id
{
    
    //////mmm mmm mmm
    NSDictionary *v_dic = [g_GameSet.g_h2h_steal_Category_Arr objectAtIndex:category_id];
//    NSString *v_category_name = [v_dic objectForKey:@"name"];
    NSString *v_category = [v_dic objectForKey:@"category_id"];
    category_id = [v_category intValue];
    
    NSString *strReqeust = [NSString stringWithFormat:@"user_id=%@&blog_id=%@&request_type=7&category_id=%d&challenge_id=%@",g_GameSet.g_user_id, g_GameSet.g_blog_id, category_id, g_GameSet.g_h2h_invite_user_id];
    
    NSData *requestData = [strReqeust dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[requestData length]];
    
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
    
    NSNumber *status_num = [dic objectForKey:@"status"];
    NSMutableArray *d = [NSMutableArray arrayWithArray: [dic objectForKey:@"data"]];
    NSString *message = [dic objectForKey:@"message"];
    
    int status = [status_num intValue];
    
    if (status == 1) {
        
        g_GameSet.g_h2h_stealQuiz_Arr = [d mutableCopy];//[NSMutableArray arrayWithArray: d];
        g_GameSet.g_h2h_steal_current_ques_index = 0;
        NSDictionary *firstQuiz = [g_GameSet.g_h2h_stealQuiz_Arr objectAtIndex:g_GameSet.g_h2h_steal_current_ques_index];
        
        NSString *problem_title = [firstQuiz objectForKey:@"title"];
        NSMutableArray  *answers_arr = [firstQuiz objectForKey:@"answers"];
        NSString *solution = [firstQuiz objectForKey:@"solutions"];
        NSString *category = [firstQuiz objectForKey:@"category"];
        
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
        ///////
        
        g_GameSet.g_h2h_stealQuiz.title = problem_title;
        g_GameSet.g_h2h_stealQuiz.category = category;
        
        //            g_GameSet.g_game_mode = SPECIAL_MODE;
        
        UIStoryboard *storyboard;
        if (g_GameSet.g_curDeviceModel == IPAD)
        {
            storyboard = [UIStoryboard storyboardWithName:@"Main_iPad"
                                                   bundle:nil];
            
        }else{
            storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone"
                                                   bundle:nil];
        }
        
        StealCrownRespViewController *response_view =
        (StealCrownRespViewController *)
        [storyboard instantiateViewControllerWithIdentifier:@"StealCrownRespViewController"];
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
