//
//  GameSet.m
//  ThinkFast
//
//  Created by admin on 7/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameSet.h"

GameSet *g_GameSet = nil;


@implementation QuizClass

@synthesize title = _title;
@synthesize answers_arr = _answers_arr;
@synthesize solution = _solution;
@synthesize category = _category;

- (id) init
{
    if (self = [super init])
    {
        _title = nil;
        _answers_arr = [NSArray array];
        _solution = nil;
        _category = nil;
    }
    
    return self;
}
@end


@implementation QuizResultClass

@synthesize quiz_title = _quiz_title;
@synthesize quiz_result_status = _quiz_result_status;


- (id) init
{
    if (self = [super init])
    {
        _quiz_title = nil;
        _quiz_result_status = nil;
    }
    
    return self;
}
@end

@implementation RandomQuizResultClass

@synthesize quiz_title = _quiz_title;
@synthesize quiz_result_status = _quiz_result_status;
@synthesize total_point = _total_point;
@synthesize total_time = _total_time;


- (id) init
{
    if (self = [super init])
    {
        _quiz_title = nil;
        _quiz_result_status = nil;
        _total_point = 0;
        _total_time = 0.0;
    }
    
    return self;
}
@end

@implementation RandomQuizRateClass

@synthesize m_userName = _m_userName;
@synthesize m_point = _m_point;
@synthesize m_time = _m_time;
@synthesize m_place = _m_place;

- (id) init
{
    if (self = [super init])
    {
        _m_userName = nil;
        _m_point = 0;
        _m_time = 0.0;
        _m_place = 0;
    }
    
    return self;
}
@end


@implementation SpecialQuizInfo

@synthesize special_quiz_title = _special_quiz_title;
@synthesize special_teacher_name = _special_teacher_name;
@synthesize site_id = _site_id;
@synthesize isSelected = _isSelected;

- (id) init
{
    if (self = [super init])
    {
        _special_quiz_title = nil;
        _special_teacher_name = nil;
        _site_id = nil;
        _isSelected = NO;
    }
    return self;
}

@end


@implementation GameSet

@synthesize g_curDeviceModel = _g_curDeviceModel;
@synthesize g_randomQuiz = _g_randomQuiz;
@synthesize g_randomQuiz_Arr = _g_randomQuiz_Arr;
@synthesize g_random_quiz_result_Arr = _g_random_quiz_result_Arr;
@synthesize g_random_current_ques_index = _g_random_current_ques_index;
@synthesize g_randomQuiz_rate_Arr = _g_randomQuiz_rate_Arr;
@synthesize g_insert_id = _g_insert_id;

@synthesize g_remainCategory = _g_remainCategory;
@synthesize g_curCategory = _g_curCategory;
@synthesize g_curSpinSelCategory = _g_curSpinSelCategory;

@synthesize g_quiz_result_Arr = _g_quiz_result_Arr;
@synthesize g_elimate_category_type = _g_elimate_category_type;
@synthesize g_cur_username = _g_cur_username;

@synthesize g_specialQuiz = _g_specialQuiz;
@synthesize g_game_mode = _g_game_mode;
@synthesize g_special_quiz_result_Arr = _g_special_quiz_result_Arr;
@synthesize g_special_quiz_info = _g_special_quiz_info;
@synthesize g_specialQuiz_Arr = _g_specialQuiz_Arr;
@synthesize g_current_ques_index = _g_current_ques_index;

@synthesize g_blog_id = _g_blog_id;
@synthesize g_user_id = _g_user_id;

@synthesize deviceToken = _deviceToken;

@synthesize g_h2h_user_Arr = _g_h2h_user_Arr;
@synthesize g_h2h_invite_user_id = _g_h2h_invite_user_id;
@synthesize g_h2h_invite_user_name = _g_h2h_invite_user_name;
@synthesize g_first_hit = _g_first_hit;
@synthesize g_second_hit = _g_second_hit;
@synthesize g_third_hit = _g_third_hit;

@synthesize g_h2h_stealQuiz_Arr = _g_h2h_stealQuiz_Arr;
@synthesize g_h2h_steal_current_ques_index = _g_h2h_steal_current_ques_index;
@synthesize g_h2h_stealQuiz = _g_h2h_stealQuiz;
@synthesize g_h2h_stealQuiz_result_Arr = _g_h2h_stealQuiz_result_Arr;

@synthesize g_h2h_steal_Category_Arr = _g_h2h_steal_Category_Arr;

@synthesize g_h2h_steal_crown_main_score = _g_h2h_steal_crown_main_score;
@synthesize g_h2h_steal_crown_invite_score = _g_h2h_steal_crown_invite_score;

@synthesize g_h2h_steal_crown_main_crowns = _g_h2h_steal_crown_main_crowns;
@synthesize g_h2h_steal_crown_invite_crowns = _g_h2h_steal_crown_invite_crowns;

@synthesize g_stealCrown_tryCount = _g_stealCrown_tryCount;

@synthesize g_is_master = _g_is_master;

@synthesize g_cur_viewcontroller = _g_cur_viewcontroller;

- (id) init
{
    if (self = [super init])
    {
        _g_randomQuiz = [[QuizClass alloc] init];
        _g_randomQuiz_Arr = [[NSMutableArray alloc] init];
        _g_random_quiz_result_Arr = [[NSMutableArray alloc] init];
        _g_random_current_ques_index = 0;
        _g_randomQuiz_rate_Arr = [[NSMutableArray alloc] init];
        _g_insert_id = 0;
        
        _g_curDeviceModel = IPHONE_5;
        _g_curSpinCategory_Arr = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:CTGY_SCIENCE],
                                  [NSNumber numberWithInt:CTGY_ELECTIVES],
                                  [NSNumber numberWithInt:CTGY_ENGLISH],
                                  [NSNumber numberWithInt:CTGY_HISTORY],
                                  [NSNumber numberWithInt:CTGY_MATH],
                                  [NSNumber numberWithInt:CTGY_SPORTS],
                                  [NSNumber numberWithInt:CTGY_ART],
                                  [NSNumber numberWithInt:CTGY_SPECIAL],
                                    nil];
        _g_remainCategory = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:CTGY_SCIENCE],
                             [NSNumber numberWithInt:CTGY_ELECTIVES],
                             [NSNumber numberWithInt:CTGY_ENGLISH],
                             [NSNumber numberWithInt:CTGY_HISTORY],
                             [NSNumber numberWithInt:CTGY_MATH],
                             [NSNumber numberWithInt:CTGY_SPORTS],
                             [NSNumber numberWithInt:CTGY_ART],
                             [NSNumber numberWithInt:CTGY_SPECIAL],
                             nil];
        _g_quiz_result_Arr = [[NSMutableArray alloc] init];
        
        _g_elimate_category_type = CTGY_NONE;
        
        _g_cur_username = @"User Name";
        
        ////
        _g_specialQuiz = [[QuizClass alloc] init];
        _g_game_mode = NONE_MODE;
        _g_special_quiz_result_Arr = [[NSMutableArray alloc] init];
        
        _g_special_quiz_info = [[SpecialQuizInfo alloc] init];
        
        _g_specialQuiz_Arr = [[NSMutableArray alloc] init];
        
        _g_current_ques_index = 0;
        
        _g_user_id = nil;
        _g_blog_id = nil;

        _g_h2h_user_Arr = [[NSMutableArray alloc] init];
        _g_h2h_invite_user_id = nil;
        _g_h2h_invite_user_name = nil;
        
        _g_first_hit = false;
        _g_second_hit = false;
        _g_third_hit = false;
        
        _g_cur_viewcontroller = nil;
        
        _g_h2h_stealQuiz_Arr = [[NSMutableArray alloc] init];
        _g_h2h_steal_current_ques_index = 0;
        _g_h2h_stealQuiz = [[QuizClass alloc] init];
        _g_h2h_stealQuiz_result_Arr = [[NSMutableArray alloc] init];
        _g_h2h_steal_Category_Arr = [[NSMutableArray alloc] init];
        
        _g_h2h_steal_crown_main_crowns = [[NSArray alloc] init];
        _g_h2h_steal_crown_invite_crowns = [[NSArray alloc] init];
        
        _g_h2h_steal_crown_main_score = 0;
        _g_h2h_steal_crown_invite_score = 0;
        
        _g_stealCrown_tryCount = 3;
        
        _g_is_master = false;

    }
    
    return self;
}

- (void) h2h_cofig_init
{
    _g_h2h_user_Arr = [[NSMutableArray alloc] init];
    _g_h2h_invite_user_id = nil;
    _g_h2h_invite_user_name = nil;
    
    _g_first_hit = false;
    _g_second_hit = false;
    _g_third_hit = false;
    
    _g_h2h_stealQuiz_Arr = [[NSMutableArray alloc] init];
    _g_h2h_steal_current_ques_index = 0;
    _g_h2h_stealQuiz = [[QuizClass alloc] init];
    _g_h2h_stealQuiz_result_Arr = [[NSMutableArray alloc] init];
    _g_h2h_steal_Category_Arr = [[NSMutableArray alloc] init];
    
    _g_h2h_steal_crown_main_crowns = [[NSArray alloc] init];
    _g_h2h_steal_crown_invite_crowns = [[NSArray alloc] init];
    
    _g_h2h_steal_crown_main_score = 0;
    _g_h2h_steal_crown_invite_score = 0;
    
    _g_stealCrown_tryCount = 3;

    _g_is_master = false;

}

@end
