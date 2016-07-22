//
//  RandomViewController.m
//  Quizacation
//
//  Created by Maksym on 12/30/15.
//  Copyright © 2015 Maksym. All rights reserved.
//

#import "RandomViewController.h"
#import "GameSet.h"

@interface RandomViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *q_small_charac_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *q_small_charac_height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *q_small_charac_width;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *title_label_leading;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *title_label_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *title_label_height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *title_label_width;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *comment_label_height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *h2h_charac_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *h2h_charac_height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *h2h_charac_bottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *submit_btn_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *title_label_bottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *q_small_charac_bottom;


@property (weak, nonatomic) IBOutlet UILabel *title_label;
@property (weak, nonatomic) IBOutlet UILabel *comment_label;
@property (weak, nonatomic) IBOutlet UITextField *student_id_field;
@property (weak, nonatomic) IBOutlet UIButton *submit_btn;

@property (assign, nonatomic) UITextField * currentTextField;
@property (strong, nonatomic) NSString *m_string_student_id;
@property (assign, nonatomic) CGFloat originalCenterY;


@end

@implementation RandomViewController

@synthesize q_small_charac_width, q_small_charac_top, q_small_charac_height, title_label_width, title_label_leading, title_label,title_label_top, title_label_height, comment_label, comment_label_height, h2h_charac_bottom, h2h_charac_height, h2h_charac_top, submit_btn, student_id_field, submit_btn_top;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self adjust_constraints];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    g_GameSet.g_cur_viewcontroller = self;


}

- (void) adjust_constraints
{
    if (g_GameSet.g_curDeviceModel == IPHONE_5) {
        
        
    }
    else if (g_GameSet.g_curDeviceModel == IPHONE_6) {
        self.title_label_top.constant *= 1.2f;
        self.q_small_charac_top.constant *= 1.2f;
        self.q_small_charac_height.constant *= 1.2f;
        self.q_small_charac_width.constant *= 1.2f;
        self.title_label_leading.constant *= 1.2f;
//        self.title_label_width.constant *= 1.2f;
        self.title_label_height.constant *= 1.2f;
//        self.comment_label_height.constant *= 1.2f;
//        self.h2h_charac_top.constant *= 1.2f;
//        self.h2h_charac_bottom.constant *= 1.2f;
//        self.h2h_charac_height.constant *= 1.2f;
        self.submit_btn_top.constant *= 1.2f;
        self.title_label_bottom.constant *= 1.2f;
        self.q_small_charac_bottom.constant *= 1.2f;
        
        [self.title_label setFont:[UIFont systemFontOfSize:30]];
        [self.comment_label setFont:[UIFont systemFontOfSize:27]];
        
        [self.student_id_field setFont:[UIFont systemFontOfSize:35]];
        [self.submit_btn.titleLabel setFont:[UIFont systemFontOfSize:35]];
        
    }
    else if (g_GameSet.g_curDeviceModel == IPHONE_6_PLUS) {
        self.title_label_top.constant *= 1.3f;
        self.q_small_charac_top.constant *= 1.3f;
        self.q_small_charac_height.constant *= 1.3f;
        self.q_small_charac_width.constant *= 1.3f;
        self.title_label_leading.constant *= 1.3f;
//        self.title_label_width.constant *= 1.3f;
        self.title_label_height.constant *= 1.3f;
//        self.comment_label_height.constant *= 1.3f;
//        self.h2h_charac_top.constant *= 1.3f;
//        self.h2h_charac_bottom.constant *= 1.3f;
//        self.h2h_charac_height.constant *= 1.3f;
        self.submit_btn_top.constant *= 1.3f;
        self.title_label_bottom.constant *= 1.3f;
        self.q_small_charac_bottom.constant *= 1.3f;
        
        [self.title_label setFont:[UIFont systemFontOfSize:30]];
        [self.comment_label setFont:[UIFont systemFontOfSize:27]];
        
        [self.student_id_field setFont:[UIFont systemFontOfSize:35]];
        [self.submit_btn.titleLabel setFont:[UIFont systemFontOfSize:35]];
        
    }
    else if (g_GameSet.g_curDeviceModel == IPHONE_4) {
        self.title_label_top.constant *= 0.8f;
        self.q_small_charac_top.constant *= 0.8f;
        self.q_small_charac_height.constant *= 0.8f;
        self.q_small_charac_width.constant *= 0.8f;
        self.title_label_leading.constant *= 0.8f;
//        self.title_label_width.constant *= 0.8f;
        self.title_label_height.constant *= 0.8f;
//        self.comment_label_height.constant *= 0.8f;
        self.h2h_charac_top.constant *= 0.8f;
        self.h2h_charac_bottom.constant *= 0.8f;
        self.h2h_charac_height.constant *= 0.8f;
        self.submit_btn_top.constant *= 0.7f;
        self.title_label_bottom.constant *= 0.7f;
        self.q_small_charac_bottom.constant *= 0.7f;

        
//        [self.title_label setFont:[UIFont systemFontOfSize:35]];
//        [self.comment_label setFont:[UIFont systemFontOfSize:27]];
//        
//        [self.student_id_field setFont:[UIFont systemFontOfSize:35]];
//        [self.submit_btn.titleLabel setFont:[UIFont systemFontOfSize:35]];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if( self.student_id_field == textField )
    {
        [self.student_id_field resignFirstResponder];
    }
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    self.currentTextField = textField;
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if( self.student_id_field == textField )
    {
        self.m_string_student_id = textField.text;
    }
    
    self.currentTextField = textField;
    return YES;
}

#define OFFSET   0
#pragma mark - Keyboard
- (void)keyboardWillShow:(NSNotification *)notification
{
    CGFloat keyboardHeight;
    CGFloat windowHeight;
    
    UIWindow * window = self.currentTextField.window;
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if( orientation == UIDeviceOrientationPortrait ||  orientation == UIDeviceOrientationPortraitUpsideDown)
    {
        keyboardHeight = [[notification.userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size.height;
        windowHeight = window.frame.size.height;
    }
    
    CGRect textFieldRect = self.currentTextField.frame;
    
    
    CGFloat offset1 = textFieldRect.origin.y+textFieldRect.size.height;
    CGFloat offset2 = windowHeight - keyboardHeight;
    if( offset1+OFFSET > offset2 )
    {
        CGFloat offset = offset1+OFFSET-offset2;
        self.originalCenterY = self.view.frame.origin.y;
        
        [UIView animateWithDuration:0.4 animations:^{
            CGRect frame = self.view.frame;
            frame.origin.y -= offset;
            self.view.frame = frame;
        }];
    }
    else
    {
        self.currentTextField = nil;
        self.originalCenterY = 0;
    }
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    if( self.currentTextField != nil )
    {
        [UIView animateWithDuration:0.4 animations:^{
            CGRect frame = self.view.frame;
            frame.origin.y = 0;//self.originalCenterY;
            self.view.frame = frame;
        }];
    }
}


@end
