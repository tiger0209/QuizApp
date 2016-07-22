//
//  SpinViewController.h
//  Quizacation
//
//  Created by Maksym on 12/30/15.
//  Copyright © 2015 Maksym. All rights reserved.
//

#ifndef SpinViewController_h
#define SpinViewController_h

#import <UIKit/UIKit.h>

#import "SMWheelControl.h"

#import "GameSet.h"


@interface SpinViewController : UIViewController<SMWheelControlDelegate, SMWheelControlDataSource>

@property (nonatomic, weak) IBOutlet UIView *wheelContainer;


@end


#endif /* SpinViewController_h */
