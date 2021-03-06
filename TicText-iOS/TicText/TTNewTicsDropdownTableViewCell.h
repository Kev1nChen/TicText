//
//  TTUnreadTicsTableViewCell.h
//  TicText
//
//  Created by Kevin Yufei Chen on 4/24/15.
//  Copyright (c) 2015 Kevin Yufei Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTTic.h"

@interface TTNewTicsDropdownTableViewCell : UITableViewCell

+ (CGFloat)height;

+ (NSString *)reuseIdentifier;

- (void)updateCellWithSendTimestamp:(NSDate *)sendTimestamp timeLimit:(NSTimeInterval)timeLimit;

- (void)updateCellWithNumberOfTicsFromSameSender:(NSInteger)numberOfNewTics;

@end
