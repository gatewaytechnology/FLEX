//
//  FLEXServerSelectionTableViewCell.h
//  Flipboard
//
//  Created by Ryan Olson on 2/8/15.
//  Copyright (c) 2015 Flipboard. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const kFLEXServerSelectionCellIdentifier;

@class FLEXServer;

@interface FLEXServerSelectionTableViewCell : UITableViewCell

@property (nonatomic, strong) FLEXServer *server;

+ (CGFloat)preferredCellHeight;

@end
