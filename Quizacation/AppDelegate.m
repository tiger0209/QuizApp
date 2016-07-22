//
//  AppDelegate.m
//  Quizacation
//
//  Created by Maksym on 12/30/15.
//  Copyright © 2015 Maksym. All rights reserved.
//

#import "AppDelegate.h"
#import "PlayerAcceptViewController.h"
#import "PlayerInviteViewController.h"

#import "GameSet.h"
#import "SpinViewController.h"
#import "WaitingViewController.h"
#import "StealCrownRespViewController.h"
#import "StealCrownResultViewController.h"
#import "LogInSuccessViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

@synthesize currentViewcontroller;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    

    
    g_GameSet = [[GameSet alloc] init];
    
    if([[UIDevice currentDevice] userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
    {
        if ([[UIScreen mainScreen] bounds].size.height == 568)
        {
            g_GameSet.g_curDeviceModel = IPHONE_5;
        }
        else if ([[UIScreen mainScreen] bounds].size.height == 667)
        {
            g_GameSet.g_curDeviceModel = IPHONE_6;
        }
        else if ([[UIScreen mainScreen] bounds].size.height == 736)
        {
            g_GameSet.g_curDeviceModel = IPHONE_6_PLUS;
        }
        else if ([[UIScreen mainScreen] bounds].size.height == 1024)
        {
            g_GameSet.g_curDeviceModel = IPAD;
        }
        else if ([[UIScreen mainScreen] bounds].size.height == 480)
        {
            //iphone 3.5 inch screen
            g_GameSet.g_curDeviceModel = IPHONE_4;
        }
    }
    else
    {
        //[ipad]
        g_GameSet.g_curDeviceModel = IPAD;
    }

    
    //////0214
    //-- Set Notification
    if ([application respondsToSelector:@selector(isRegisteredForRemoteNotifications)])
    {
        // iOS 8 Notifications
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        [application registerForRemoteNotifications];
    }
    else
    {
        // iOS < 8 Notifications
        [application registerForRemoteNotificationTypes:
         (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound)];
    }

    
    ///////
//    if (launchOptions != nil)
//    {
//        NSDictionary *dictionary = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
//        
//        if (dictionary != nil)
//        {
//            NSLog(@"Launched from push notification: %@", dictionary);
//            [self showViewControllerFromRemoteNotification:dictionary updateUI:YES];
//        }
//    }
    
    g_GameSet.g_cur_viewcontroller = self.window.rootViewController;
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    application.applicationIconBadgeNumber = 0;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Push Notification
- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    NSString *newToken = [deviceToken description];
    newToken = [newToken stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    newToken = [newToken stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"My token is: %@", newToken);
    
    g_GameSet.deviceToken = newToken;

    /*UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
     LoginViewController *vc = (LoginViewController *)[storyboard instantiateViewControllerWithIdentifier:@"Login"];
     vc.token = newToken;
     [vc registerToken];*/
    
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    if (error.code == 3010) {
        NSLog(@"Push notifications are not supported in the iOS Simulator.");
    } else {
        // show some alert or otherwise handle the failure to register.
        NSLog(@"application:didFailToRegisterForRemoteNotificationsWithError: %@", error);
    }}

- (void)application:(UIApplication*)application didReceiveRemoteNotification:(NSDictionary*)userInfo
{
    NSLog(@"Received notification: %@", userInfo);
    UIStoryboard *storyboard;
    UIViewController *v_viewController;
    if (g_GameSet.g_curDeviceModel == IPAD)
    {
        storyboard = [UIStoryboard storyboardWithName:@"Main_iPad"
                                               bundle:nil];
        
    }else{
        storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone"
                                               bundle:nil];
    }
    
//    NSString *alertValue = [[userInfo valueForKey:@"aps"] valueForKey:@"alert"];
    NSDictionary *v_data = [[userInfo valueForKey:@"aps"] valueForKey:@"data"];
    
    NSString *v_status = [v_data valueForKey:@"status"];
    
    if ([v_status isEqualToString:@"invite"]) {
        NSString *v_invite_user_id = [v_data valueForKey:@"invite_user_id"];
        NSString *v_user_id = [v_data valueForKey:@"user_id"];
        NSString *v_user_name = [v_data valueForKey:@"user_name"];
        
        g_GameSet.g_user_id = v_user_id;
        g_GameSet.g_h2h_invite_user_id = v_invite_user_id;
        g_GameSet.g_h2h_invite_user_name = v_user_name;
        
        PlayerAcceptViewController *response_view =
        (PlayerAcceptViewController *)
        [storyboard instantiateViewControllerWithIdentifier:@"PlayerAcceptViewController"];
//        [g_GameSet.g_cur_viewcontroller presentViewController:response_view animated:true completion:nil];
        [g_GameSet.g_cur_viewcontroller showViewController:response_view sender:nil];
        
        v_viewController = response_view;
    }
    
    if(application.applicationState == UIApplicationStateInactive) {
        
        NSLog(@"Inactive - the user has tapped in the notification when app was closed or in background");
        //do some tasks
        [self showViewControllerFromRemoteNotification:userInfo updateUI:YES view:v_viewController];
    }
    else if (application.applicationState == UIApplicationStateBackground) {
        
        NSLog(@"application Background - notification has arrived when app was in background");
//        NSString* contentAvailable = [NSString stringWithFormat:@"%@", [[userInfo valueForKey:@"aps"] valueForKey:@"content-available"]];
        
        //        if([contentAvailable isEqualToString:@"1"]) {
        // do tasks
        [self showViewControllerFromRemoteNotification:userInfo updateUI:YES view:v_viewController];
        NSLog(@"content-available is equal to 1");
        //        }
    }
    else {
        NSLog(@"application Active - notication has arrived while app was opened");
//        [g_GameSet.g_cur_viewcontroller presentViewController:v_viewController animated:true completion:nil];
        [g_GameSet.g_cur_viewcontroller showViewController:v_viewController sender:nil];

    }
    
}

- (void)showViewControllerFromRemoteNotification:(NSDictionary*)userInfo updateUI:(BOOL)updateUI view:(UIViewController*) viewController
{
    UIStoryboard *storyboard;
    if (g_GameSet.g_curDeviceModel == IPAD)
    {
        storyboard = [UIStoryboard storyboardWithName:@"Main_iPad"
                                               bundle:nil];
        
    }else{
        storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone"
                                               bundle:nil];
    }

//    [self.window.rootViewController presentViewController:viewController animated:true completion:nil];
    [g_GameSet.g_cur_viewcontroller showViewController:viewController sender:nil];


}

- (void) application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    
    UIStoryboard *storyboard;
    UIViewController *v_viewController;
    if (g_GameSet.g_curDeviceModel == IPAD)
    {
        storyboard = [UIStoryboard storyboardWithName:@"Main_iPad"
                                               bundle:nil];
        
    }else{
        storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone"
                                               bundle:nil];
    }

//    NSString *alertValue = [[userInfo valueForKey:@"aps"] valueForKey:@"alert"];
    NSDictionary *v_data = [[userInfo valueForKey:@"aps"] valueForKey:@"data"];
    
    NSString *v_status = [v_data valueForKey:@"status"];
    
    if ([v_status isEqualToString:@"invite"]) {
        NSString *v_invite_user_id = [v_data valueForKey:@"invite_user_id"];
        NSString *v_user_id = [v_data valueForKey:@"user_id"];
        NSString *v_user_name = [v_data valueForKey:@"user_name"];
        
        g_GameSet.g_user_id = v_user_id;
        g_GameSet.g_h2h_invite_user_id = v_invite_user_id;
        g_GameSet.g_h2h_invite_user_name = v_user_name;
        
        PlayerAcceptViewController *response_view =
        (PlayerAcceptViewController *)
        [storyboard instantiateViewControllerWithIdentifier:@"PlayerAcceptViewController"];

        v_viewController = response_view;
        
//        ////////test test test 0220
        g_GameSet.g_is_master = false;
    }
    else if ([v_status isEqualToString:@"accept"]) {
        
        NSString *message = [NSString stringWithFormat:@"%@ accepted your head to head challenge!", g_GameSet.g_h2h_invite_user_name];
        if ([UIAlertController class])
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                 {
                                     [self showSpinViewController];
                                     [alertController dismissViewControllerAnimated:YES completion:nil];
                                     
                                 }];
            [alertController addAction:ok];
            v_viewController = alertController;
            
        }
        else
        {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        
//        ////////test test test 0220
//        g_GameSet.g_is_master = true;
    }
    else if ([v_status isEqualToString:@"competition_waiting"]) {
        
        WaitingViewController *response_view =
        (WaitingViewController *)
        [storyboard instantiateViewControllerWithIdentifier:@"WaitingViewController"];
        
        response_view.m_category_id = CTGY_SCIENCE;
        
        v_viewController = response_view;
    }
    else if ([v_status isEqualToString:@"spin"]) {
        NSString *v_category_name = [v_data valueForKey:@"category_name"];
//        NSString *v_invite_user_id = [v_data valueForKey:@"playe_id"];

        ///test test test 0224
//        WaitingViewController *response_view =
//        (WaitingViewController *)
//        [storyboard instantiateViewControllerWithIdentifier:@"WaitingViewController"];
//        if ([v_category_name isEqualToString:@"Science"]) {
//            response_view.m_category_id = CTGY_SCIENCE;
//        }
//        if ([v_category_name isEqualToString:@"History"]) {
//            response_view.m_category_id = CTGY_HISTORY;
//        }
//        if ([v_category_name isEqualToString:@"Math"]) {
//            response_view.m_category_id = CTGY_MATH;
//        }
//        if ([v_category_name isEqualToString:@"Sports"]) {
//            response_view.m_category_id = CTGY_SPORTS;
//        }
//        if ([v_category_name isEqualToString:@"English"]) {
//            response_view.m_category_id = CTGY_ENGLISH;
//        }
//        if ([v_category_name isEqualToString:@"Elective"]) {
//            response_view.m_category_id = CTGY_ELECTIVES;
//        }
//        if ([v_category_name isEqualToString:@"Art"]) {
//            response_view.m_category_id = CTGY_ART;
//        }
//        
//        v_viewController = response_view;
        
        if ([g_GameSet.g_cur_viewcontroller isKindOfClass:[WaitingViewController class]]) {
            WaitingViewController * response_view = (WaitingViewController*)g_GameSet.g_cur_viewcontroller;
            
            if ([v_category_name isEqualToString:@"Science"]) {
                response_view.m_category_id = CTGY_SCIENCE;
            }
            if ([v_category_name isEqualToString:@"History"]) {
                response_view.m_category_id = CTGY_HISTORY;
            }
            if ([v_category_name isEqualToString:@"Math"]) {
                response_view.m_category_id = CTGY_MATH;
            }
            if ([v_category_name isEqualToString:@"Sports"]) {
                response_view.m_category_id = CTGY_SPORTS;
            }
            if ([v_category_name isEqualToString:@"English"]) {
                response_view.m_category_id = CTGY_ENGLISH;
            }
            if ([v_category_name isEqualToString:@"Elective"]) {
                response_view.m_category_id = CTGY_ELECTIVES;
            }
            if ([v_category_name isEqualToString:@"Art"]) {
                response_view.m_category_id = CTGY_ART;
            }

            [response_view loadNewScreen];
        }

    }
    else if ([v_status isEqualToString:@"swap"]) {
        NSString *message = [NSString stringWithFormat:@"Your turn!"];
        if ([UIAlertController class])
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                 {
                                     [self showSpinViewController_swap];
                                     [alertController dismissViewControllerAnimated:YES completion:nil];
                                     
                                 }];
            [alertController addAction:ok];
            v_viewController = alertController;
            
        }
        else
        {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        
//        ////////test test test 0220
//        g_GameSet.g_is_master = !g_GameSet.g_is_master;

    }
    else if ([v_status isEqualToString:@"challenge"]) {
        
        NSMutableArray  *v_array = [v_data valueForKey:@"data"];
        //        NSString *v_player_id = [v_data valueForKey:@"playe_id"];
        
        
        g_GameSet.g_h2h_stealQuiz_Arr = [v_array mutableCopy];
        g_GameSet.g_h2h_steal_current_ques_index = 0;
        NSDictionary *firstQuiz = [g_GameSet.g_h2h_stealQuiz_Arr objectAtIndex:g_GameSet.g_h2h_steal_current_ques_index];
        
        NSString *problem_title = [firstQuiz objectForKey:@"title"];
        NSMutableArray  *answers_arr = [NSMutableArray arrayWithArray:[firstQuiz objectForKey:@"answers"]];
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
        [g_GameSet.g_cur_viewcontroller showViewController:response_view sender:nil];
        
        
    }
    else if ([v_status isEqualToString:@"end_challenge"]) {

//        NSString  *v_status = [v_data valueForKey:@"status"];
//        int v_result = [[v_data valueForKey:@"result"] intValue];
        int main_score = [[v_data valueForKey:@"main_score"] intValue];
        int invite_score = [[v_data valueForKey:@"invite_score"] intValue];
        NSArray *main_crowns = [v_data valueForKey:@"main_crowns"];
        NSArray *invite_crowns = [v_data valueForKey:@"invite_crowns"];
        
        if (g_GameSet.g_is_master) {
            g_GameSet.g_h2h_steal_crown_main_score = main_score;
            g_GameSet.g_h2h_steal_crown_invite_score = invite_score;
            
            g_GameSet.g_h2h_steal_crown_main_crowns = main_crowns;
            g_GameSet.g_h2h_steal_crown_invite_crowns = invite_crowns;
            
        }else{
            g_GameSet.g_h2h_steal_crown_main_score = invite_score;
            g_GameSet.g_h2h_steal_crown_invite_score = main_score;
            
            g_GameSet.g_h2h_steal_crown_main_crowns = invite_crowns;
            g_GameSet.g_h2h_steal_crown_invite_crowns = main_crowns;

        }
        
        StealCrownResultViewController *response_view =
        (StealCrownResultViewController *)
        [storyboard instantiateViewControllerWithIdentifier:@"StealCrownResultViewController"];
        [g_GameSet.g_cur_viewcontroller showViewController:response_view sender:nil];

        
    }
    else if ([v_status isEqualToString:@"cancel_competition"])
    {
        NSString *v_user_id = [v_data valueForKey:@"login_id"];
        
        g_GameSet.g_user_id = v_user_id;

        LogInSuccessViewController *spinView =
        (LogInSuccessViewController *)
        [storyboard instantiateViewControllerWithIdentifier:@"LogInSuccessViewController"];
        
        [g_GameSet.g_cur_viewcontroller showViewController:spinView sender:nil];
        
        [g_GameSet h2h_cofig_init];

    }
    
    ////test test test 0224
    if (v_viewController == nil) {
        return;
    }
    
    if(application.applicationState == UIApplicationStateInactive) {
        
        NSLog(@"Inactive - the user has tapped in the notification when app was closed or in background");
        //do some tasks
        [self showViewControllerFromRemoteNotification:userInfo updateUI:YES view:v_viewController];
        completionHandler(UIBackgroundFetchResultNewData);
    }
    else if (application.applicationState == UIApplicationStateBackground) {
        
        NSLog(@"application Background - notification has arrived when app was in background");
//        NSString* contentAvailable = [NSString stringWithFormat:@"%@", [[userInfo valueForKey:@"aps"] valueForKey:@"content-available"]];
        
//        if([contentAvailable isEqualToString:@"1"]) {
            // do tasks
            [self showViewControllerFromRemoteNotification:userInfo updateUI:YES view:v_viewController];
            NSLog(@"content-available is equal to 1");
            completionHandler(UIBackgroundFetchResultNewData);
//        }
    }
    else {
        NSLog(@"application Active - notication has arrived while app was opened");
//        [g_GameSet.g_cur_viewcontroller presentViewController:v_viewController animated:true completion:nil];
        [g_GameSet.g_cur_viewcontroller showViewController:v_viewController sender:nil];
        
        completionHandler(UIBackgroundFetchResultNewData);
    }
}

- (void) showSpinViewController
{
    UIStoryboard *storyboard;
//    UIViewController *v_viewController;
    if (g_GameSet.g_curDeviceModel == IPAD)
    {
        storyboard = [UIStoryboard storyboardWithName:@"Main_iPad"
                                               bundle:nil];
        
    }else{
        storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone"
                                               bundle:nil];
    }

    SpinViewController *spinView =
    (SpinViewController *)
    [storyboard instantiateViewControllerWithIdentifier:@"SpinViewController"];
    
    PlayerInviteViewController *v_view= (PlayerInviteViewController*)g_GameSet.g_cur_viewcontroller;
    [v_view post_start_request];
    
    
//    [g_GameSet.g_cur_viewcontroller presentViewController:spinView animated:true completion:nil];
    [g_GameSet.g_cur_viewcontroller showViewController:spinView sender:nil];
    
    g_GameSet.g_is_master = true;
}

- (void) showSpinViewController_swap
{
    UIStoryboard *storyboard;
    if (g_GameSet.g_curDeviceModel == IPAD)
    {
        storyboard = [UIStoryboard storyboardWithName:@"Main_iPad"
                                               bundle:nil];
        
    }else{
        storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone"
                                               bundle:nil];
    }
    
    SpinViewController *spinView =
    (SpinViewController *)
    [storyboard instantiateViewControllerWithIdentifier:@"SpinViewController"];
    
//    [g_GameSet.g_cur_viewcontroller presentViewController:spinView animated:true completion:nil];
    [g_GameSet.g_cur_viewcontroller showViewController:spinView sender:nil];

}


@end
