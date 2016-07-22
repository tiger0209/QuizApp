//
//  ResultTableCell.m
//  Quizacation
//
//  Created by Maksym on 1/26/16.
//  Copyright (c) 2016 Maksym. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ResultTableCell.h"

#import "GameSet.h"

@interface ResultTableCell ()


@end

@implementation ResultTableCell

@synthesize quizProblem_label, resultStatus_label;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        if (g_GameSet.g_curDeviceModel == IPHONE_5) {
            [self.quizProblem_label setFont:[UIFont boldSystemFontOfSize:13]];
            [self.resultStatus_label setFont:[UIFont boldSystemFontOfSize:13]];
            self.resultStatus_label_width.constant *= 1.0f;
        }
        else if (g_GameSet.g_curDeviceModel == IPHONE_6) {
            [self.quizProblem_label setFont:[UIFont boldSystemFontOfSize:15]];
            [self.resultStatus_label setFont:[UIFont boldSystemFontOfSize:15]];
            self.resultStatus_label_width.constant *= 1.2f;
        }
        else if (g_GameSet.g_curDeviceModel == IPHONE_6_PLUS) {
            [self.quizProblem_label setFont:[UIFont boldSystemFontOfSize:15]];
            [self.resultStatus_label setFont:[UIFont boldSystemFontOfSize:15]];
            self.resultStatus_label_width.constant *= 1.3f;
        }
        else if (g_GameSet.g_curDeviceModel == IPAD) {
            [self.quizProblem_label setFont:[UIFont boldSystemFontOfSize:30]];
            [self.resultStatus_label setFont:[UIFont boldSystemFontOfSize:30]];
            self.resultStatus_label_width.constant *= 2.0f;
        }
        else if (g_GameSet.g_curDeviceModel == IPHONE_4) {
            [self.quizProblem_label setFont:[UIFont boldSystemFontOfSize:12]];
            [self.resultStatus_label setFont:[UIFont boldSystemFontOfSize:12]];
            self.resultStatus_label_width.constant *= 1.0f;
            
        }

    }
    return self;
}

- (UIEdgeInsets)layoutMargins
{
    return UIEdgeInsetsZero;
}

@end