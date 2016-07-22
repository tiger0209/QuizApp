//
//  SubStatTableCell.h
//  Quizacation
//
//  Created by Maksym on 12/30/15.
//  Copyright (c) 2015 Maksym. All rights reserved.
//

#ifndef SubStatTableCell_h
#define SubStatTableCell_h

#import <UIKit/UIKit.h>

@interface SubStatTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *category_img_view;
@property (weak, nonatomic) IBOutlet UILabel *category_name_label;
@property (weak, nonatomic) IBOutlet UILabel *points_label;
@property (weak, nonatomic) IBOutlet UILabel *pro_label;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pro_label_width;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *point_label_width;

@end

#endif
