//
//  MedalsTableCell.m
//  Quizacation
//
//  Created by Maksym on 12/30/15.
//  Copyright (c) 2015 Maksym. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MedalsTableCell.h"

#import "GameSet.h"

@interface MedalsTableCell ()


@end

@implementation MedalsTableCell

@synthesize category_img_view, category_name_label, points_label, crown_img_view;

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