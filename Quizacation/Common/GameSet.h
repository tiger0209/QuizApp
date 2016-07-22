//
//  GameSet.h
//  ThinkFast
//
//  Created by admin on 7/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


#define LOCAL_SERVER                0


//#ifdef LOCAL_SERVER
//
//#define LOGIN_URL                           [NSURL URLWithString: @"http://192.168.0.22/wordpress/api/login.php"]
//#define SIGNUP_URL                          [NSURL URLWithString: @"http://192.168.0.22/wordpress/api/register.php"]
//
//#else

#define LOGIN_URL                           [NSURL URLWithString: @"http://quizacation.com/wp-api/login.php"]
#define SIGNUP_URL                          [NSURL URLWithString: @"http://quizacation.com/wp-api/register.php"]
#define RANDOM_MODE_URL                     [NSURL URLWithString: @"http://quizacation.com/wp-api/single.php"]
#define PROFILE_MODE_URL                    [NSURL URLWithString: @"http://quizacation.com/wp-api/profile.php"]

#define SPECIAL_MODE_URL                    [NSURL URLWithString: @"http://quizacation.com/wp-api/special.php"]
#define H2H_MODE_URL                        [NSURL URLWithString: @"http://quizacation.com/wp-api/head.php"]

//#endif


typedef enum {
    IPHONE_4,
    IPHONE_5,
    IPHONE_6,
    IPHONE_6_PLUS,
    IPAD,
} CUR_DEVICE;


typedef enum {
    CTGY_NONE = 0,
    CTGY_SCIENCE,
    CTGY_ELECTIVES,
    CTGY_ENGLISH,
    CTGY_HISTORY,
    CTGY_MATH,
    CTGY_SPORTS,
    CTGY_ART,
    CTGY_SPECIAL
} CATEGORY;

typedef enum {
    NONE_MODE = 0,
    RANDOM_MODE,
    SPECIAL_MODE,
    HEAD_2_HEAD_MODE,
} GAME_MODE;



@interface QuizClass : NSObject
{
    NSString *_title;
    NSArray  *_answers_arr;
    NSString *_solution;
    NSString *_category;
}

@property (nonatomic, strong)    NSString       *title;
@property (nonatomic, strong)    NSArray        *answers_arr;
@property (nonatomic, strong)    NSString       *solution;
@property (nonatomic, strong)    NSString       *category;


@end

@interface QuizResultClass : NSObject
{
    NSString *_quiz_title;
    NSString *_quiz_result_status;
}


@property (nonatomic, strong)    NSString       *quiz_title;
@property (nonatomic, strong)    NSString        *quiz_result_status;

@end

@interface RandomQuizResultClass : NSObject
{
    NSString *_quiz_title;
    NSString *_quiz_result_status;
    int _total_point;
    float _total_time;
}

@property (nonatomic, strong)    NSString           *quiz_title;
@property (nonatomic, strong)    NSString           *quiz_result_status;
@property (nonatomic, assign)    int                total_point;
@property (nonatomic, assign)    float                total_time;

@end

@interface RandomQuizRateClass : NSObject
{
    NSString    *_m_userName;
    int         _m_point;
    float       _m_time;
    int         _m_place;
}

@property (nonatomic, strong)    NSString       *m_userName;
@property (nonatomic, assign)    int            m_point;
@property (nonatomic, assign)    float          m_time;
@property (nonatomic, assign)    int            m_place;

@end


@interface SpecialQuizInfo : NSObject
{
    NSString *_special_quiz_title;
    NSString *_special_teacher_name;
    NSString *_site_id;
    
    ////
    BOOL     _isSelected;
}
@property (nonatomic, strong)    NSString       *special_quiz_title;
@property (nonatomic, strong)    NSString       *special_teacher_name;
@property (nonatomic, strong)    NSString       *site_id;
@property (nonatomic, assign)    BOOL           isSelected;

@end



@interface GameSet : NSObject
{
    QuizClass                   *_g_randomQuiz;
    NSMutableArray              *_g_randomQuiz_Arr;
    NSMutableArray              *_g_random_quiz_result_Arr;
    int                         _g_random_current_ques_index;
    NSMutableArray              *_g_randomQuiz_rate_Arr;
    int                         _g_insert_id;
    
    int                         _g_curDeviceModel;
    NSMutableArray              *_g_curSpinCategory_Arr;
    NSMutableArray              *_g_remainCategory;
    CATEGORY                    _g_curCategory;
    CATEGORY                    _g_curSpinSelCategory;

    NSMutableArray              *_g_quiz_result_Arr;
    
    int                         _g_elimate_category_type;
    
    NSString                    *_g_cur_username;
    
    ///Special Puzzle
    QuizClass                   *_g_specialQuiz;
    NSMutableArray              *_g_specialQuiz_Arr;
    GAME_MODE                   _g_game_mode;
    NSMutableArray              *_g_special_quiz_result_Arr;
    SpecialQuizInfo             *_g_special_quiz_info;
    int                         _g_current_ques_index;
    NSString                         *_g_user_id;
    NSString                         *_g_blog_id;
    
    
    /////Head to Head Mode
    NSMutableArray              *_g_h2h_user_Arr;
    NSString                    *_g_h2h_invite_user_id;
    NSString                    *_g_h2h_invite_user_name;
    
    BOOL                        _g_first_hit;
    BOOL                        _g_second_hit;
    BOOL                        _g_third_hit;
    
    NSMutableArray              *_g_h2h_stealQuiz_Arr;
    int                         _g_h2h_steal_current_ques_index;
    QuizClass                   *_g_h2h_stealQuiz;
    NSMutableArray              *_g_h2h_stealQuiz_result_Arr;

    NSMutableArray              *_g_h2h_steal_Category_Arr;

    int                         _g_h2h_steal_crown_main_score;
    int                         _g_h2h_steal_crown_invite_score;
    
    int                         _g_stealCrown_tryCount;
    
    NSArray                     *_g_h2h_steal_crown_main_crowns;
    NSArray                     *_g_h2h_steal_crown_invite_crowns;
    
    
    BOOL                        _g_is_master;

    /////Push notification
    UIViewController *_g_cur_viewcontroller;

}

@property (nonatomic, strong)           QuizClass                   *g_randomQuiz;
@property (nonatomic, strong)           NSMutableArray              *g_randomQuiz_Arr;
@property (nonatomic, readwrite)        NSMutableArray              *g_random_quiz_result_Arr;
@property (nonatomic, assign)           int                         g_random_current_ques_index;
@property (nonatomic, strong)           NSMutableArray              *g_randomQuiz_rate_Arr;
@property (nonatomic, readwrite)        int                         g_insert_id;


@property (nonatomic, readwrite)        int                         g_curDeviceModel;

@property (nonatomic, readwrite)        NSMutableArray              *g_curSpinCategory_Arr;
@property (nonatomic, readwrite)        NSMutableArray              *g_remainCategory;
@property (nonatomic, assign)           CATEGORY                    g_curCategory;
@property (nonatomic, assign)           CATEGORY                    g_curSpinSelCategory;


@property (nonatomic, readwrite)        NSMutableArray              *g_quiz_result_Arr;

@property (nonatomic, readwrite)        int                         g_elimate_category_type;

@property (nonatomic, strong)           NSString                    *g_cur_username;

@property (nonatomic, strong)           QuizClass                   *g_specialQuiz;
@property (nonatomic, assign)           GAME_MODE                   g_game_mode;
@property (nonatomic, readwrite)        NSMutableArray              *g_special_quiz_result_Arr;

@property (nonatomic, readwrite)        SpecialQuizInfo             *g_special_quiz_info;

@property (nonatomic, readwrite)        NSMutableArray              *g_specialQuiz_Arr;

@property (nonatomic, assign)           int                         g_current_ques_index;
@property (nonatomic, readwrite)        NSString                     *g_user_id;
@property (nonatomic, readwrite)        NSString                     *g_blog_id;

////0214
@property (nonatomic, strong)           NSString                    *deviceToken;

////H2H Mode
@property (nonatomic, readwrite)        NSMutableArray              *g_h2h_user_Arr;
@property (nonatomic, strong)           NSString                    *g_h2h_invite_user_id;
@property (nonatomic, strong)           NSString                    *g_h2h_invite_user_name;

@property (nonatomic, assign)           BOOL                        g_first_hit;
@property (nonatomic, assign)           BOOL                        g_second_hit;
@property (nonatomic, assign)           BOOL                        g_third_hit;

@property (nonatomic, readwrite)        NSMutableArray              *g_h2h_stealQuiz_Arr;
@property (nonatomic, assign)           int                         g_h2h_steal_current_ques_index;
@property (nonatomic, strong)           QuizClass                   *g_h2h_stealQuiz;
@property (nonatomic, readwrite)        NSMutableArray              *g_h2h_stealQuiz_result_Arr;

@property (nonatomic, strong)           UIViewController            *g_cur_viewcontroller;

@property (nonatomic, readwrite)        NSMutableArray              *g_h2h_steal_Category_Arr;

@property (nonatomic, assign)           int                         g_h2h_steal_crown_main_score;
@property (nonatomic, assign)           int                         g_h2h_steal_crown_invite_score;

@property (nonatomic, strong)           NSArray                     *g_h2h_steal_crown_main_crowns;
@property (nonatomic, strong)           NSArray                     *g_h2h_steal_crown_invite_crowns;

@property (nonatomic, assign)           int                         g_stealCrown_tryCount;

@property (nonatomic, assign)           BOOL                        g_is_master;


- (void) h2h_cofig_init;


@end

extern GameSet *g_GameSet;
