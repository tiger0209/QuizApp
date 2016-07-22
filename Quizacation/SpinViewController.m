//
//  SpinViewController.m
//  Quizacation
//
//  Created by Maksym on 12/30/15.
//  Copyright © 2015 Maksym. All rights reserved.
//

#import "SpinViewController.h"
//#import "GameSet.h"

#import "SMWheelControl.h"
#import "JSON.h"
#import "ResponseViewController.h"

#import "StealCrownRespViewController.h"
#import "StealCrownViewController.h"


@interface SpinViewController ()
{
    NSMutableData      *receivedHomeViewData;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *q_small_charac_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *q_small_charac_height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *q_charac_small_width;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *title_label_leading;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *title_label_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *title_label_height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *title_label_width;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *comment_title_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *spin_frame_height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *spin_btn_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *spin_small_charac_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *spin_queen_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *spin_small_charac_width;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *spin_queen_width;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *spin_charac_width;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *progress_bar_height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *progress_bar_top;

@property (weak, nonatomic) IBOutlet UIImageView *progress_bar;

@property (weak, nonatomic) IBOutlet UILabel *title_label;
@property (weak, nonatomic) IBOutlet UILabel *comment_label;
@property (weak, nonatomic) IBOutlet UIButton *spin_btn;

@property (nonatomic, weak) SMWheelControl *wheel;

@property (nonatomic, assign) BOOL          mb_is_SpecialCategory;


@end

@implementation SpinViewController

@synthesize q_small_charac_height, q_small_charac_top, q_charac_small_width, title_label, title_label_height, title_label_top, title_label_leading, title_label_width, comment_label, comment_title_top, spin_btn, spin_btn_top, spin_frame_height, spin_queen_top, spin_queen_width, spin_small_charac_top, spin_small_charac_width, spin_charac_width;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self adjust_constraints];
    
    [self adjustCurSpinWheel];
    [self settingSpinWheel];

    if (g_GameSet.g_first_hit == false && g_GameSet.g_second_hit == false  && g_GameSet.g_third_hit == false) {
        self.progress_bar.hidden = true;
    }
    if (g_GameSet.g_first_hit == true && g_GameSet.g_second_hit == false  && g_GameSet.g_third_hit == false) {
        self.progress_bar.hidden = false;
        self.progress_bar.image = [UIImage imageNamed:@"progress_bar_1"];
    }
    if (g_GameSet.g_first_hit == true && g_GameSet.g_second_hit == true && g_GameSet.g_third_hit == false) {
        self.progress_bar.hidden = false;
        self.progress_bar.image = [UIImage imageNamed:@"progress_bar_2"];
    }
    if (g_GameSet.g_first_hit == true && g_GameSet.g_second_hit == true && g_GameSet.g_third_hit == true) {
        self.progress_bar.hidden = false;
        self.progress_bar.image = [UIImage imageNamed:@"progress_bar_3"];
    }
    
    g_GameSet.g_cur_viewcontroller = self;

}

//- (void) viewWillAppear:(BOOL)animated
//{
//    [self adjustCurSpinWheel];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) adjust_constraints
{
    float ratio = 1.0f;
    
    if (g_GameSet.g_curDeviceModel == IPHONE_5) {
        
        self.title_label_top.constant *= 1.0f;
        self.title_label_leading.constant *= 1.0f;
        self.title_label_height.constant *= 1.0f;
        //        self.title_label_width.constant *= 1.2f;
        self.q_charac_small_width.constant *= 1.0f;
        self.q_small_charac_height.constant *= 1.0f;
        self.q_small_charac_top.constant *= 1.0f;
        self.spin_frame_height.constant *= 1.0f;
        self.spin_btn_top.constant *= 1.0f;
        self.spin_small_charac_top.constant *= 1.0f;
        self.spin_queen_top.constant *= 1.0f;
        self.spin_small_charac_width.constant *= 1.0f;
        self.spin_queen_width.constant *= 1.0f;
        self.spin_charac_width.constant *= 1.0f;
        self.comment_title_top.constant *= 0.4f;
        
        self.progress_bar_height.constant *= 1.0f;
        self.progress_bar_top.constant *= 1.0f;
        
//        [self.title_label setFont:[UIFont systemFontOfSize:30]];
//        [self.comment_label setFont:[UIFont systemFontOfSize:25]];
//        
//        [self.spin_btn.titleLabel setFont:[UIFont systemFontOfSize:30]];
        
        ratio = 1.18f;
    }
    else if (g_GameSet.g_curDeviceModel == IPHONE_6) {
        self.title_label_top.constant *= 1.2f;
        self.title_label_leading.constant *= 1.2f;
        self.title_label_height.constant *= 1.2f;
//        self.title_label_width.constant *= 1.2f;
        self.q_charac_small_width.constant *= 1.2f;
        self.q_small_charac_height.constant *= 1.2f;
        self.q_small_charac_top.constant *= 1.2f;
        self.spin_frame_height.constant *= 1.2f;
        self.spin_btn_top.constant *= 2.0f;
        self.spin_small_charac_top.constant *= 1.0f;
        self.spin_queen_top.constant *= 1.0f;
        self.spin_small_charac_width.constant *= 1.2f;
        self.spin_queen_width.constant *= 1.2f;
        self.spin_charac_width.constant *= 1.2f;
        self.comment_title_top.constant *= 0.6f;
        
        self.progress_bar_height.constant *= 1.2f;
        self.progress_bar_top.constant *= 1.2f;

        
        [self.title_label setFont:[UIFont systemFontOfSize:30]];
        [self.comment_label setFont:[UIFont systemFontOfSize:25]];
        
        [self.spin_btn.titleLabel setFont:[UIFont systemFontOfSize:30]];
        
        ratio = 1.4f;
    }
    else if (g_GameSet.g_curDeviceModel == IPHONE_6_PLUS) {
        self.title_label_top.constant *= 1.3f;
        self.title_label_leading.constant *= 1.3f;
        self.title_label_height.constant *= 1.3f;
//        self.title_label_width.constant *= 1.3f;
        self.q_charac_small_width.constant *= 1.3f;
        self.q_small_charac_height.constant *= 1.3f;
        self.q_small_charac_top.constant *= 1.3f;
        self.spin_frame_height.constant *= 1.2f;
        self.spin_btn_top.constant *= 2.2f;
        self.spin_small_charac_top.constant *= 1.0f;
        self.spin_queen_top.constant *= 1.0f;
        self.spin_small_charac_width.constant *= 1.3f;
        self.spin_queen_width.constant *= 1.3f;
        self.spin_charac_width.constant *= 1.2f;
        self.comment_title_top.constant *= 0.6f;
        
        self.progress_bar_height.constant *= 1.2f;
        self.progress_bar_top.constant *= 1.2f;

        
        [self.title_label setFont:[UIFont systemFontOfSize:30]];
        [self.comment_label setFont:[UIFont systemFontOfSize:25]];
        
        [self.spin_btn.titleLabel setFont:[UIFont systemFontOfSize:30]];
        
        ratio = 1.4f;
    }
    else if (g_GameSet.g_curDeviceModel == IPHONE_4) {
        self.title_label_top.constant *= 0.8f;
        self.title_label_leading.constant *= 0.8f;
        self.title_label_height.constant *= 0.8f;
//        self.title_label_width.constant *= 0.8f;
        self.q_charac_small_width.constant *= 0.8f;
        self.q_small_charac_height.constant *= 0.8f;
        self.q_small_charac_top.constant *= 0.8f;
        self.spin_frame_height.constant *= 0.8f;
        self.spin_btn_top.constant *= 0.3f;
        self.spin_small_charac_top.constant *= 0.8f;
        self.spin_queen_top.constant *= 0.8f;
        self.spin_small_charac_width.constant *= 0.8f;
        self.spin_queen_width.constant *= 0.8f;
        self.spin_charac_width.constant *= 0.8f;
        self.comment_title_top.constant *= 0.3f;
        
        self.progress_bar_height.constant *= 1.2f;
        self.progress_bar_top.constant *= 1.2f;

        
//        [self.title_label setFont:[UIFont systemFontOfSize:50]];
//        [self.comment_label setFont:[UIFont systemFontOfSize:25]];
//        
//        [self.spin_btn.titleLabel setFont:[UIFont systemFontOfSize:30]];
        
        ratio = 1.0f;
    }
    else if (g_GameSet.g_curDeviceModel == IPAD) {
        
        ratio = 1.3f;
    }

    

}

- (void) settingSpinWheel
{

    float ratio = 1.0f;
    
    if (g_GameSet.g_curDeviceModel == IPHONE_5) {
        ratio = 1.18f;
    }
    else if (g_GameSet.g_curDeviceModel == IPHONE_6) {
        ratio = 1.4f;
    }
    else if (g_GameSet.g_curDeviceModel == IPHONE_6_PLUS) {
        ratio = 1.5f;
    }
    else if (g_GameSet.g_curDeviceModel == IPHONE_4) {
        ratio = 1.0f;
    }
    else if (g_GameSet.g_curDeviceModel == IPAD) {
        
        ratio = 1.3f;
    }

    
    ///////Spin Wheel
    
    SMWheelControl *wheel = [[SMWheelControl alloc] initWithFrame:self.wheelContainer.bounds];
    [wheel addTarget:self action:@selector(wheelDidChangeValue:) forControlEvents:UIControlEventValueChanged];
    
    float x = self.wheelContainer.bounds.origin.x;
    float y = self.wheelContainer.bounds.origin.y;
    float w = self.wheelContainer.bounds.size.width;
    float h = self.wheelContainer.bounds.size.height;
    
    
    CGRect rect = CGRectMake(x - w*(ratio - 1.0f)/2, y - h*(ratio - 1.0f)/2, w*ratio, h*ratio);
    
    UIImageView *board = [[UIImageView alloc] initWithFrame:rect];
    [board setImage:[UIImage imageNamed:@"spin_board.png"]];
    [wheel insertSubview:board atIndex:0];
    
    wheel.delegate = self;
    wheel.dataSource = self;
    [wheel reloadData];
    
    
    [self.wheelContainer addSubview:wheel];
    
    self.wheel = wheel;

}


- (void) adjustCurSpinWheel
{
    NSMutableArray *cat_arr = g_GameSet.g_curSpinCategory_Arr;
    
    switch (g_GameSet.g_elimate_category_type)
    {
        case CTGY_NONE:
        {
            g_GameSet.g_curSpinCategory_Arr = cat_arr;
        }
            break;
        case CTGY_SCIENCE:
        {
            for (int i = 0; i < [cat_arr count]; i++) {
                NSNumber *num  = [cat_arr objectAtIndex:i];
                if ([num intValue] == CTGY_SCIENCE) {
                    NSInteger count = [g_GameSet.g_remainCategory count];
                    int ran_num = arc4random() % count;
                    int v_num = [[g_GameSet.g_remainCategory objectAtIndex:ran_num] intValue];
                    [cat_arr replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:v_num]];
                }
            }
        }
            break;
        case CTGY_ELECTIVES:
        {
            for (int i = 0; i < [cat_arr count]; i++) {
                NSNumber *num  = [cat_arr objectAtIndex:i];
                if ([num intValue] == CTGY_ELECTIVES) {
                    NSInteger count = [g_GameSet.g_remainCategory count];
                    int ran_num = arc4random() % count;
                    int v_num = [[g_GameSet.g_remainCategory objectAtIndex:ran_num] intValue];
                    [cat_arr replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:v_num]];
                }
            }
        }
            break;
        case CTGY_ENGLISH:
        {
            for (int i = 0; i < [cat_arr count]; i++) {
                NSNumber *num  = [cat_arr objectAtIndex:i];
                if ([num intValue] == CTGY_ENGLISH) {
                    NSInteger count = [g_GameSet.g_remainCategory count];
                    int ran_num = arc4random() % count;
                    int v_num = [[g_GameSet.g_remainCategory objectAtIndex:ran_num] intValue];
                    [cat_arr replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:v_num]];
                }
            }
        }
            break;
        case CTGY_HISTORY:
        {
            for (int i = 0; i < [cat_arr count]; i++) {
                NSNumber *num  = [cat_arr objectAtIndex:i];
                if ([num intValue] == CTGY_HISTORY) {
                    NSInteger count = [g_GameSet.g_remainCategory count];
                    int ran_num = arc4random() % count;
                    int v_num = [[g_GameSet.g_remainCategory objectAtIndex:ran_num] intValue];
                    [cat_arr replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:v_num]];
                }
            }
        }
            break;
        case CTGY_MATH:
        {
            for (int i = 0; i < [cat_arr count]; i++) {
                NSNumber *num  = [cat_arr objectAtIndex:i];
                if ([num intValue] == CTGY_MATH) {
                    NSInteger count = [g_GameSet.g_remainCategory count];
                    int ran_num = arc4random() % count;
                    int v_num = [[g_GameSet.g_remainCategory objectAtIndex:ran_num] intValue];
                    [cat_arr replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:v_num]];
                }
            }
        }
            break;
        case CTGY_SPORTS:
        {
            for (int i = 0; i < [cat_arr count]; i++) {
                NSNumber *num  = [cat_arr objectAtIndex:i];
                if ([num intValue] == CTGY_SPORTS) {
                    NSInteger count = [g_GameSet.g_remainCategory count];
                    int ran_num = arc4random() % count;
                    int v_num = [[g_GameSet.g_remainCategory objectAtIndex:ran_num] intValue];
                    [cat_arr replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:v_num]];
                }
            }
        }
            break;
        case CTGY_ART:
        {
            for (int i = 0; i < [cat_arr count]; i++) {
                NSNumber *num  = [cat_arr objectAtIndex:i];
                if ([num intValue] == CTGY_ART) {
                    NSInteger count = [g_GameSet.g_remainCategory count];
                    int ran_num = arc4random() % count;
                    int v_num = [[g_GameSet.g_remainCategory objectAtIndex:ran_num] intValue];
                    [cat_arr replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:v_num]];
                }
            }
        }
            break;
        case CTGY_SPECIAL:
        {
            for (int i = 0; i < [cat_arr count]; i++) {
                NSNumber *num  = [cat_arr objectAtIndex:i];
                if ([num intValue] == CTGY_SPECIAL) {
                    NSInteger count = [g_GameSet.g_remainCategory count];
                    int ran_num = arc4random() % count;
                    int v_num = [[g_GameSet.g_remainCategory objectAtIndex:ran_num] intValue];
                    [cat_arr replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:v_num]];
                }
            }
         }
            break;
        default:
            break;
    }
    
    int v_num;
    int v_prev_num;
    int v_next_num;

    
    for (int i = 0; i < [cat_arr count]; i++)
    {
        v_num = [[cat_arr objectAtIndex:i] intValue];
        if (i == 0)
            v_prev_num = [[cat_arr objectAtIndex:[cat_arr count]-1] intValue];
        else
            v_prev_num = [[cat_arr objectAtIndex:i-1] intValue];
        
        if (i == [cat_arr count] - 1)
            v_next_num = [[cat_arr objectAtIndex:0] intValue];
        else
            v_next_num = [[cat_arr objectAtIndex:i+1] intValue];
        
        /////test test
        if (v_prev_num == v_num && v_num == v_next_num) {
//            NSInteger count = [g_GameSet.g_remainCategory count];
            for (NSNumber* num in g_GameSet.g_remainCategory) {
                int vv_num = [num intValue];
                if (vv_num != v_num) {
                    [cat_arr replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:vv_num]];
                }
            }
        }
    }

    for (int i = 0; i < [cat_arr count]; i++)
    {
        v_num = [[cat_arr objectAtIndex:i] intValue];
        if (i == 0)
            v_prev_num = [[cat_arr objectAtIndex:[cat_arr count]-1] intValue];
        else
            v_prev_num = [[cat_arr objectAtIndex:i-1] intValue];
        
        if (i == [cat_arr count] - 1)
            v_next_num = [[cat_arr objectAtIndex:0] intValue];
        else
            v_next_num = [[cat_arr objectAtIndex:i+1] intValue];
        
        
        if (v_prev_num == v_num)
        {
            [cat_arr replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:v_next_num]];
            int next = i+1;
            if (next > [cat_arr count] - 1)
                next = 0;
            [cat_arr replaceObjectAtIndex:next withObject:[NSNumber numberWithInt:v_num]];
        }
//        if (v_next_num == v_num)
//        {
//            [cat_arr replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:v_prev_num]];
//            int prev = i-1;
//            if (prev < 0)
//                prev = [cat_arr count] - 1;
//            [cat_arr replaceObjectAtIndex:prev withObject:[NSNumber numberWithInt:v_num]];
//        }
    }
    for (int i = 0; i < [cat_arr count]; i++)
    {
        v_num = [[cat_arr objectAtIndex:i] intValue];
        if (i == 0)
            v_prev_num = [[cat_arr objectAtIndex:[cat_arr count]-1] intValue];
        else
            v_prev_num = [[cat_arr objectAtIndex:i-1] intValue];
        
        if (i == [cat_arr count] - 1)
            v_next_num = [[cat_arr objectAtIndex:0] intValue];
        else
            v_next_num = [[cat_arr objectAtIndex:i+1] intValue];
        
        
//        if (v_prev_num == v_num)
//        {
//            [cat_arr replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:v_next_num]];
//            int next = i+1;
//            if (next > [cat_arr count] - 1)
//                next = 0;
//            [cat_arr replaceObjectAtIndex:next withObject:[NSNumber numberWithInt:v_num]];
//        }
        if (v_next_num == v_num)
        {
            [cat_arr replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:v_prev_num]];
            NSInteger prev = i-1;
            if (prev < 0)
                prev = [cat_arr count] - 1;
            [cat_arr replaceObjectAtIndex:prev withObject:[NSNumber numberWithInt:v_num]];
        }
    }
    
    g_GameSet.g_curSpinCategory_Arr = cat_arr;
    

}

#pragma mark - Wheel delegate

- (void)wheelDidEndDecelerating:(SMWheelControl *)wheel
{
    
}

- (void)wheel:(SMWheelControl *)wheel didRotateByAngle:(CGFloat)angle
{
    
}

#pragma mark - Wheel dataSource

- (NSUInteger)numberOfSlicesInWheel:(SMWheelControl *)wheel
{
    return 8;
}


- (UIView *)wheel:(SMWheelControl *)wheel viewForSliceAtIndex:(NSUInteger)index
{
    NSString *str;
    

    NSMutableArray *cat_arr1 = g_GameSet.g_curSpinCategory_Arr;
    
    CATEGORY v_index = [[cat_arr1 objectAtIndex:index] intValue];
    switch (v_index) {
        case CTGY_SCIENCE:
            str = @"science_1.png";
            break;
        case CTGY_ELECTIVES:
            str = @"elective_1.png";
            break;
        case CTGY_ENGLISH:
            str = @"english_1.png";
            break;
        case CTGY_HISTORY:
            str = @"history_1.png";
            break;
        case CTGY_MATH:
            str = @"math_1.png";
            break;
        case CTGY_SPORTS:
            str = @"sports_1.png";
            break;
        case CTGY_ART:
            str = @"art_1.png";
            break;
        case CTGY_SPECIAL:
            str = @"crown_1.png";
            break;
            
        default:
            break;
    }
    
    CGRect v_rect;
    if (g_GameSet.g_curDeviceModel == IPHONE_5) {
        v_rect = CGRectMake(0, 0, 140, 110);
    }
    else if (g_GameSet.g_curDeviceModel == IPHONE_6) {
        v_rect = CGRectMake(0, 0, 168, 132);
        
    }
    else if (g_GameSet.g_curDeviceModel == IPHONE_6_PLUS) {
        v_rect = CGRectMake(0, 0, 182, 143);
        
    }
    else if (g_GameSet.g_curDeviceModel == IPHONE_4) {
        v_rect = CGRectMake(0, 0, 120, 94);
        
    }
    else if (g_GameSet.g_curDeviceModel == IPAD) {
        v_rect = CGRectMake(0, 0, 220, 172);
        
    }

    UIImageView *image_view = [[UIImageView alloc] initWithFrame:v_rect];
    image_view.image = [UIImage imageNamed:str];
    return image_view;
    
}

#pragma mark - Wheel Control

- (void)wheelDidChangeValue:(id)sender
{
//    self.valueLabel.text = [NSString stringWithFormat:@"Selected index: %d", self.wheel.selectedIndex];
    
    //////
    NSInteger spin_index = self.wheel.selectedIndex;
    int category_id = [[g_GameSet.g_curSpinCategory_Arr objectAtIndex:spin_index-1] intValue];
    
    /////0219
//    g_GameSet.g_curCategory = category_id;
    g_GameSet.g_curSpinSelCategory = category_id;
    
    [self inform_categoryId:category_id];

    //////Disable Spin Button test test test
    //[self.spin_btn setEnabled:NO];
}

- (CGFloat)snappingAngleForWheel:(id)sender
{
    return M_PI / 2;
}
- (IBAction)clickedBtn:(id)sender {
    [self.wheel spinRotatingStart];
}

- (void)inform_categoryId:(int)category_id
{
    //////mmm mmm mmm
    CATEGORY categoryId = category_id;
    NSString *c_name;
    NSString *strReqeust;
    
    ////test test test 0219
    if (categoryId == CTGY_SPECIAL) {
        c_name = @"Crown";
        strReqeust = [NSString stringWithFormat:@"user_id=%@&blog_id=%@&request_type=5&category_name=%@&waiter_id=%@",g_GameSet.g_user_id, g_GameSet.g_blog_id, c_name, g_GameSet.g_h2h_invite_user_id];
        self.mb_is_SpecialCategory = true;
    }else{
        switch (categoryId) {
            case CTGY_SCIENCE:
                c_name = @"Science";
                break;
            case CTGY_ELECTIVES:
                c_name = @"Elective";
                break;
            case CTGY_ENGLISH:
                c_name = @"English";
                break;
            case CTGY_HISTORY:
                c_name = @"History";
                break;
            case CTGY_MATH:
                c_name = @"Math";
                break;
            case CTGY_SPORTS:
                c_name = @"Sports";
                break;
            case CTGY_ART:
                c_name = @"Art";
                break;
            default:
                break;
        }
    
        strReqeust = [NSString stringWithFormat:@"user_id=%@&blog_id=%@&request_type=5&category_name=%@&waiter_id=%@",g_GameSet.g_user_id, g_GameSet.g_blog_id, c_name, g_GameSet.g_h2h_invite_user_id];
        self.mb_is_SpecialCategory = false;
    }

    NSData *requestData = [strReqeust dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%ld", (unsigned long)[requestData length]];
    
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
    
    ////Special
    if (self.mb_is_SpecialCategory) {
        
        NSNumber *status_num = [dic objectForKey:@"status"];
        NSMutableArray *d = [dic objectForKey:@"data"];
        NSString *message = [dic objectForKey:@"message"];
        
        int status = [status_num intValue];

        if (status == 1) {            
            g_GameSet.g_h2h_steal_Category_Arr = d;            
            
            UIStoryboard *storyboard;
            if (g_GameSet.g_curDeviceModel == IPAD)
            {
                storyboard = [UIStoryboard storyboardWithName:@"Main_iPad"
                                                       bundle:nil];
                
            }else{
                storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone"
                                                       bundle:nil];
            }
            
            if (g_GameSet.g_stealCrown_tryCount == 0) {
                ////////////
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[NSString stringWithFormat:@"steal count remain %d times", g_GameSet.g_stealCrown_tryCount ] preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                     {
                                         [alertController dismissViewControllerAnimated:YES completion:nil];
                                     }];
                [alertController addAction:ok];
                
                [self presentViewController:alertController animated:YES completion:nil];

            }else{
                //////test test test 0325
                g_GameSet.g_stealCrown_tryCount--;
                
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[NSString stringWithFormat:@"steal count remain %d times", g_GameSet.g_stealCrown_tryCount ] preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                     {
                                         [alertController dismissViewControllerAnimated:YES completion:nil];
                                         
                                         StealCrownViewController *response_view =
                                         (StealCrownViewController *)
                                         [storyboard instantiateViewControllerWithIdentifier:@"StealCrownViewController"];
                                         //            [self presentViewController:response_view animated:YES completion:nil];
                                         [self showViewController:response_view sender:nil];
                                         
                                         
                                     }];
                [alertController addAction:ok];
                
                [self presentViewController:alertController animated:YES completion:nil];
	
            }
            
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
        self.mb_is_SpecialCategory = false;

    }else{
        
        NSNumber *status_num = [dic objectForKey:@"status"];
        NSDictionary *d = [dic objectForKey:@"data"];
        NSString *message = [dic objectForKey:@"message"];
        
        int status = [status_num intValue];
        
        if (status == 1) {
            
            //        for( NSDictionary * d in data )
            //        {
            NSString *problem_title = [d objectForKey:@"title"];
            NSMutableArray  *answers_arr = [d objectForKey:@"answers"];
            NSString *solution = [d objectForKey:@"solutions"];
            
            //////test test test 0219
            NSString *category_id = [d objectForKey:@"category"];
            g_GameSet.g_curCategory = [category_id intValue];
            
            
            //////////random arrange correct answer
            int ran_idx = arc4random() % 4;
            
            ////test test test
            NSLog(@"########### ran_idx = %d ###########", ran_idx);
            
            if (ran_idx == 0) {
                g_GameSet.g_randomQuiz.answers_arr = answers_arr;
                g_GameSet.g_randomQuiz.solution = solution;
                
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
                
                g_GameSet.g_randomQuiz.answers_arr = answers_arr;
                g_GameSet.g_randomQuiz.solution = solution;
                
            }
            ///////
            
            g_GameSet.g_randomQuiz.title = problem_title;
            
            g_GameSet.g_game_mode = RANDOM_MODE;
            
            UIStoryboard *storyboard;
            if (g_GameSet.g_curDeviceModel == IPAD)
            {
                storyboard = [UIStoryboard storyboardWithName:@"Main_iPad"
                                                       bundle:nil];
                
            }else{
                storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone"
                                                       bundle:nil];
            }
            
            ResponseViewController *response_view =
            (ResponseViewController *)
            [storyboard instantiateViewControllerWithIdentifier:@"ResponseViewController"];
//            [self presentViewController:response_view animated:YES completion:nil];
            [self showViewController:response_view sender:nil];

            
            //        }
            
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
}

@end
