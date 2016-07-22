//
//  ResultTableCell.h
//  Quizacation
//
//  Created by Maksym on 1/25/16.
//  Copyright (c) 2016 Maksym. All rights reserved.
//

#ifndef ResultTableCell_h
#define ResultTableCell_h

#import <UIKit/UIKit.h>

@interface ResultTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *quizProblem_label;
@property (weak, nonatomic) IBOutlet UILabel *resultStatus_label;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *resultStatus_label_width;

@end

#endif
