//
//  RandomResultTableself.m
//  Quizacation
//
//  Created by Maksym on 2/10/16.
//  Copyright (c) 2016 Maksym. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RandomResultTableCell.h"

#import "GameSet.h"

@interface RandomResultTableCell ()


@end

@implementation RandomResultTableCell

@synthesize m_userName, m_point, m_time, m_image_width, m_name_width, m_pts_width, m_time_width, m_pos_label, m_pos_label_width;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        

    }
    return self;
}

- (UIEdgeInsets)layoutMargins
{
    return UIEdgeInsetsZero;
}

@end