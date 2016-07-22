//
//  RandomResultTableCell.h
//  Quizacation
//
//  Created by Maksym on 2/10/16.
//  Copyright (c) 2016 Maksym. All rights reserved.
//

#ifndef RandomResultTableCell_h
#define RandomResultTableCell_h

#import <UIKit/UIKit.h>

@interface RandomResultTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *m_pos_label;
@property (weak, nonatomic) IBOutlet UIImageView *m_pos_img;
@property (weak, nonatomic) IBOutlet UILabel *m_userName;
@property (weak, nonatomic) IBOutlet UILabel *m_point;
@property (weak, nonatomic) IBOutlet UILabel *m_time;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *m_image_width;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *m_name_width;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *m_pts_width;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *m_time_width;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *m_pos_label_width;


@end

#endif
