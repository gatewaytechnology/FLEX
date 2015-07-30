//
//  FLEXServerSelectionTableViewCell.m
//  Flipboard
//
//  Created by Ryan Olson on 2/8/15.
//  Copyright (c) 2015 Flipboard. All rights reserved.
//

#import "FLEXServerSelectionTableViewCell.h"
#import "FLEXServer.h"
#import "FLEXUtility.h"
#import "FLEXResources.h"

#import "DNUtilities.h"

NSString *const kFLEXServerSelectionCellIdentifier = @"kFLEXServerSelectionCellIdentifier";

@interface FLEXServerSelectionTableViewCell ()

@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation FLEXServerSelectionTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.font = [FLEXUtility defaultTableViewCellLabelFont];
        [self.contentView addSubview:self.nameLabel];
    }
    return self;
}

- (void)setServer:(FLEXServer *)server
{
    if (_server != server) {
        _server = server;
        [self setNeedsLayout];
    }
}

- (void)setSelected:(BOOL)selected
{
    if (selected == self.selected)
    {
        return;
    }
    
    [super setSelected:selected];
    
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    const CGFloat kVerticalPadding = 8.0;
    const CGFloat kLeftPadding = 10.0;

    CGFloat textOriginX = kLeftPadding;
    CGFloat availableTextWidth = self.contentView.bounds.size.width - textOriginX;

    self.nameLabel.font = [UIFont systemFontOfSize:18.0f];
    self.nameLabel.text = [self nameLabelText];
    CGSize nameLabelPreferredSize = [self.nameLabel sizeThatFits:CGSizeMake(availableTextWidth, CGFLOAT_MAX)];
    self.nameLabel.frame = CGRectMake(textOriginX, kVerticalPadding, availableTextWidth, nameLabelPreferredSize.height);
}

- (NSString *)nameLabelText
{
    NSString*   existingServerCode  = [[DNUtilities appDelegate] settingsItem:@"ServerCode"];
    if ([existingServerCode isEqualToString:self.server.serverID])
    {
        self.selected   = YES;
        return [NSString stringWithFormat:@"✅  %@", self.server.name];
    }

    return [NSString stringWithFormat:@"       %@", self.server.name];
}

+ (CGFloat)preferredCellHeight
{
    return 35.0;
}

@end
