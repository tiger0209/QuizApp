//
//  PlayersTableCell.m
//  Quizacation
//
//  Created by Maksym on 12/30/15.
//  Copyright (c) 2015 Maksym. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PlayersTableCell.h"

#import "GameSet.h"

@interface PlayersTableCell ()


@end

@implementation PlayersTableCell

@synthesize player_name_label;

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