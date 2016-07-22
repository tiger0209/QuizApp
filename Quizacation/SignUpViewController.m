//
//  LogInViewController.m
//  Quizacation
//
//  Created by Maksym on 12/30/15.
//  Copyright © 2015 Maksym. All rights reserved.
//

#import "SignUpViewController.h"
#import "GameSet.h"
#import "JSON.h"
#import "LogInViewController.h"
#import "RegUnsucViewController.h"


@interface SignUpViewController ()<UITextFieldDelegate>
{
       NSMutableData      *receivedHomeViewData;
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *title_label_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *large_q_charac_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *large_q_charac_height;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *student_name_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *set_pass_field_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *student_id_bottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *school_code_bottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *create_username_bottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *school_code_height;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *retype_pass_field_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *submit_btn_top;

@property (weak, nonatomic) IBOutlet UILabel *title_label;
@property (weak, nonatomic) IBOutlet UIImageView *q_charac_imageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *q_charac_bottom;

@property (weak, nonatomic) IBOutlet UITextField *school_code_field;
@property (weak, nonatomic) IBOutlet UITextField *student_id_field;
@property (weak, nonatomic) IBOutlet UITextField *student_name_field;
@property (weak, nonatomic) IBOutlet UITextField *set_pass_field;
@property (weak, nonatomic) IBOutlet UITextField *retype_pass_field;

@property (weak, nonatomic) IBOutlet UIButton *submit_btn;


@property (assign, nonatomic) UITextField * currentTextField;

@property (strong, nonatomic) NSString *m_string_schoolcode;
@property (strong, nonatomic) NSString *m_string_student_id;
@property (strong, nonatomic) NSString *m_string_student_name;
@property (strong, nonatomic) NSString *m_string_password;
@property (strong, nonatomic) NSString *m_string_retype_password;

@property (assign, nonatomic) CGFloat originalCenterY;

@end



@implementation SignUpViewController

@synthesize title_label, title_label_top, large_q_charac_height, large_q_charac_top, student_name_top,
            set_pass_field_top, student_id_bottom, school_code_bottom, create_username_bottom, retype_pass_field_top, retype_pass_field, submit_btn_top, submit_btn, q_charac_imageView, q_charac_bottom, school_code_field, student_id_field, student_name_field, set_pass_field, m_string_schoolcode;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self adjust_constraints];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

}


//- (void) viewWillLayoutSubviews
//{
//    if (g_GameSet.g_curDeviceModel == IPHONE_5) {
//        
//        
//    }
//    else if (g_GameSet.g_curDeviceModel == IPHONE_6) {
//        self.title_label_top.constant *= 1.2f;
//        self.large_q_charac_top.constant *= 1.2f;
//        self.large_q_charac_height.constant *= 1.2f;
//        self.student_id_field_top.constant *= 1.2f;
//        self.student_name_bottom.constant *= 1.2f;
//        self.set_pass_field_top.constant *= 1.2f;
//        self.retype_pass_field_top.constant *= 1.2f;
//        self.submit_btn_top.constant *= 1.2f;
//        
//        [self.title_label setFont:[UIFont systemFontOfSize:50]];
//        
//        [self.student_name_field setFont:[UIFont systemFontOfSize:30]];
//        [self.student_id_field setFont:[UIFont systemFontOfSize:30]];
//        [self.set_pass_field setFont:[UIFont systemFontOfSize:30]];
//        [self.retype_pass_field setFont:[UIFont systemFontOfSize:30]];
//
//        [self.submit_btn.titleLabel setFont:[UIFont systemFontOfSize:30]];
//    }
//    else if (g_GameSet.g_curDeviceModel == IPHONE_6_PLUS) {
//        self.title_label_top.constant *= 1.3f;
//        self.large_q_charac_top.constant *= 1.3f;
//        self.large_q_charac_height.constant *= 1.3f;
//        self.student_id_field_top.constant *= 1.5f;
//        self.student_name_bottom.constant *= 1.3f;
//        self.set_pass_field_top.constant *= 1.3f;
//        self.retype_pass_field_top.constant *= 1.3f;
//        self.submit_btn_top.constant *= 1.3f;
//        
//        [self.title_label setFont:[UIFont systemFontOfSize:50]];
//        
//        [self.student_name_field setFont:[UIFont systemFontOfSize:30]];
//        [self.student_id_field setFont:[UIFont systemFontOfSize:30]];
//        [self.set_pass_field setFont:[UIFont systemFontOfSize:30]];
//        [self.retype_pass_field setFont:[UIFont systemFontOfSize:30]];
//        
//        [self.submit_btn.titleLabel setFont:[UIFont systemFontOfSize:30]];
//        
//    }
//    else if (g_GameSet.g_curDeviceModel == IPHONE_4) {
//        self.title_label_top.constant *= 0.8f;
//        self.large_q_charac_top.constant *= 0.8f;
//        self.large_q_charac_height.constant *= 0.95f;
//        self.student_id_field_top.constant *= 0.8f;
//        self.student_name_bottom.constant *= 0.8f;
//        self.set_pass_field_top.constant *= 0.8f;
//        self.retype_pass_field_top.constant *= 0.8f;
//        self.submit_btn_top.constant *= 0.8f;
//        
//        //        [self.welcome_label setFont:[UIFont systemFontOfSize:25]];
//        //        [self.title_label setFont:[UIFont systemFontOfSize:50]];
//        //
//        //        [self.log_in_btn.titleLabel setFont:[UIFont systemFontOfSize:30]];
//        //        [self.sign_up_btn.titleLabel setFont:[UIFont systemFontOfSize:30]];
//    }
//    
//}

- (void) adjust_constraints
{
    if (g_GameSet.g_curDeviceModel == IPHONE_5) {
        
        
    }
    else if (g_GameSet.g_curDeviceModel == IPHONE_6) {
        self.title_label_top.constant *= 1.2f;
        self.large_q_charac_top.constant *= 1.2f;
        self.large_q_charac_height.constant *= 1.2f;
        
        self.student_name_top.constant *= 1.2f;
        self.set_pass_field_top.constant *= 1.2f;
        self.student_id_bottom.constant *= 1.2f;
        self.school_code_bottom.constant *= 1.2f;
        self.create_username_bottom.constant *= 1.2f;
        self.retype_pass_field_top.constant *= 1.2f;
        self.submit_btn_top.constant *= 1.2f;
        self.school_code_height.constant *=1.2f;
        
        self.q_charac_bottom.constant *= 1.2f;
        
        [self.title_label setFont:[UIFont systemFontOfSize:50]];
        
        [self.student_name_field setFont:[UIFont systemFontOfSize:30]];
        [self.student_id_field setFont:[UIFont systemFontOfSize:30]];
        [self.set_pass_field setFont:[UIFont systemFontOfSize:30]];
        [self.retype_pass_field setFont:[UIFont systemFontOfSize:30]];
        
        [self.submit_btn.titleLabel setFont:[UIFont systemFontOfSize:30]];
    }
    else if (g_GameSet.g_curDeviceModel == IPHONE_6_PLUS) {
        self.title_label_top.constant *= 1.3f;
        self.large_q_charac_top.constant *= 1.3f;
        self.large_q_charac_height.constant *= 1.3f;

        self.student_name_top.constant *= 1.3f;
        self.set_pass_field_top.constant *= 1.3f;
        self.student_id_bottom.constant *= 1.3f;
        self.school_code_bottom.constant *= 1.3f;
        self.create_username_bottom.constant *= 1.3f;
        self.retype_pass_field_top.constant *= 1.3f;
        self.submit_btn_top.constant *= 1.3f;
        self.school_code_height.constant *=1.3f;

        self.q_charac_bottom.constant *= 1.3f;
        
        [self.title_label setFont:[UIFont systemFontOfSize:50]];
        
        [self.student_name_field setFont:[UIFont systemFontOfSize:30]];
        [self.student_id_field setFont:[UIFont systemFontOfSize:30]];
        [self.set_pass_field setFont:[UIFont systemFontOfSize:30]];
        [self.retype_pass_field setFont:[UIFont systemFontOfSize:30]];
        
        [self.submit_btn.titleLabel setFont:[UIFont systemFontOfSize:30]];
        
    }
    else if (g_GameSet.g_curDeviceModel == IPHONE_4) {
        self.title_label_top.constant *= 0.8f;
        self.large_q_charac_top.constant *= 0.8f;
        self.large_q_charac_height.constant *= 0.95f;

        self.student_name_top.constant *= 0.8f;
        self.set_pass_field_top.constant *= 0.8f;
        self.student_id_bottom.constant *= 0.8f;
        self.school_code_bottom.constant *= 0.8f;
        self.create_username_bottom.constant *= 0.8f;
        self.retype_pass_field_top.constant *= 0.8f;
        self.submit_btn_top.constant *= 0.8f;
        self.school_code_height.constant *=0.8f;

        self.q_charac_bottom.constant *= 0.3f;
        
        //        [self.welcome_label setFont:[UIFont systemFontOfSize:25]];
        //        [self.title_label setFont:[UIFont systemFontOfSize:50]];
        //
        //        [self.log_in_btn.titleLabel setFont:[UIFont systemFontOfSize:30]];
        //        [self.sign_up_btn.titleLabel setFont:[UIFont systemFontOfSize:30]];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if( self.school_code_field == textField )
    {
        [self.school_code_field resignFirstResponder];
        //        [self.student_id_field becomeFirstResponder];
    }
    if( self.student_name_field == textField )
    {
        [self.student_name_field resignFirstResponder];
//        [self.student_id_field becomeFirstResponder];
    }
    else if( self.student_id_field == textField )
    {
        [self.student_id_field resignFirstResponder];
//        [self.set_pass_field becomeFirstResponder];
    }
    else if( self.set_pass_field == textField )
    {
        [self.set_pass_field resignFirstResponder];
//        [self.retype_pass_field becomeFirstResponder];
    }
    else if( self.retype_pass_field == textField )
    {
        [self.retype_pass_field resignFirstResponder];
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
    if( self.school_code_field == textField )
    {
        self.m_string_schoolcode = textField.text;
    }
    if( self.student_id_field == textField )
    {
        self.m_string_student_id = textField.text;
    }
    else if( self.student_name_field == textField )
    {
        self.m_string_student_name = textField.text;
    }
    else if( self.set_pass_field == textField )
    {
        self.m_string_password = textField.text;
    }
    else if( self.retype_pass_field == textField )
    {
        self.m_string_retype_password = textField.text;
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
- (IBAction)onSubmitBtn:(id)sender {
    if (self.m_string_schoolcode == nil ||
        self.m_string_student_id == nil ||
        self.m_string_password == nil ||
        self.m_string_student_name == nil ||
        self.m_string_retype_password == nil ) {
        
        if ([UIAlertController class])
        {
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"Please enter infomation." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:ok];
            
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
        else
        {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Please enter infomation." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [alert show];
            
        }
    }
    else if(![self.m_string_password isEqualToString:self.m_string_retype_password]) {
        
        if ([UIAlertController class])
        {
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"Please confirm password." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:ok];
            
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
        else
        {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Please confirm password." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [alert show];
            
        }
        
    }
    else
    {
        
        [self signupWithInfo:self.m_string_student_id schoolCode:self.m_string_schoolcode studentName:self.m_string_student_name Password:self.m_string_password];
        
    }

    
}

- (void)signupWithInfo:(NSString *)student_id schoolCode:(NSString*)schoolCode studentName:(NSString*) student_name Password:(NSString *)password
{
    NSString *token = g_GameSet.deviceToken;

    NSString *strReqeust = [NSString stringWithFormat:@"schoolcode=%@&studentid=%@&studentname=%@&password=%@&tokenid=%@",
                            schoolCode,
                            student_id,
                            student_name,
                            password,
                            token];
    
    NSLog(@"****signup = %@ ****", strReqeust);
    
    NSData *requestData = [strReqeust dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu", [requestData length]];
    
    NSMutableURLRequest* theRequest = [NSMutableURLRequest requestWithURL:SIGNUP_URL];
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
    
    NSString *status_num = [dic objectForKey:@"status"];
//    NSString *data = [dic objectForKey:@"data"];
    NSString *message = [dic objectForKey:@"message"];
    
    int status = [status_num intValue];
    
    if (status == 1) {
        if ([UIAlertController class])
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                 {
                                     [alertController dismissViewControllerAnimated:YES completion:nil];
                                     
                                     UIStoryboard *storyboard;
                                     if (g_GameSet.g_curDeviceModel == IPAD)
                                     {
                                         storyboard = [UIStoryboard storyboardWithName:@"Main_iPad"
                                                                                bundle:nil];
                                         
                                     }else{
                                         storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone"
                                                                                bundle:nil];
                                     }
                                     
                                     LogInViewController *login_success =
                                     (LogInViewController *)
                                     [storyboard instantiateViewControllerWithIdentifier:@"LogInViewController"];
//                                     [self presentViewController:login_success animated:YES completion:nil];
                                     [self showViewController:login_success sender:nil];

                                     
                                 }];
            [alertController addAction:ok];
            
            [self presentViewController:alertController animated:YES completion:nil];
            

            
        }
        else
        {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [alert show];
        }
        
    }else{
        if ([UIAlertController class])
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                 {
                                     [alertController dismissViewControllerAnimated:YES completion:nil];
                                     
                                     UIStoryboard *storyboard;
                                     if (g_GameSet.g_curDeviceModel == IPAD)
                                     {
                                         storyboard = [UIStoryboard storyboardWithName:@"Main_iPad"
                                                                                bundle:nil];
                                         
                                     }else{
                                         storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone"
                                                                                bundle:nil];
                                     }
                                     
                                     RegUnsucViewController *unsuccess =
                                     (RegUnsucViewController *)
                                     [storyboard instantiateViewControllerWithIdentifier:@"RegUnsucViewController"];
//                                     [self presentViewController:unsuccess animated:YES completion:nil];
                                     [self showViewController:unsuccess sender:nil];
   
                                 }
                                 ];
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

@end
