//
//  WaitingViewController.h
//  Quizacation
//
//  Created by Maksym on 2/16/15.
//  Copyright © 2015 Maksym. All rights reserved.
//

#ifndef WaitingViewController_h
#define WaitingViewController_h

#import <UIKit/UIKit.h>
#import "GameSet.h"


@interface WaitingViewController : UIViewController

@property (assign, nonatomic) CATEGORY m_category_id;

- (void) loadNewScreen;

@end


#endif /* WaitingViewController_h */
