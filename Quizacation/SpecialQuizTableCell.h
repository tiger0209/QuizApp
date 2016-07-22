//
//  SpecialQuizTableCell.h
//  Quizacation
//
//  Created by Maksym on 12/30/15.
//  Copyright (c) 2015 Maksym. All rights reserved.
//

#ifndef SpecialQuizTableCell_h
#define SpecialQuizTableCell_h

#import <UIKit/UIKit.h>


@interface SpecialQuizTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *quiz_btn;
@property (weak, nonatomic) IBOutlet UILabel *teacher_name;


@end

#endif
