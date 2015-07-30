//
//  FLEXServerSelectionTableViewController.m
//  Flipboard
//
//  Created by Ryan Olson on 2/8/15.
//  Copyright (c) 2015 Flipboard. All rights reserved.
//

#import "FLEXServerSelectionTableViewController.h"

#import "FLEXServerSelectionTableViewCell.h"
#import "FLEXServer.h"

#import "DNUtilities.h"
#import "DNAppConstants.h"

@interface FLEXServerSelectionTableViewController ()

/// Backing model
@property (nonatomic, copy) NSArray *availableServers;

@property (nonatomic, assign) BOOL rowInsertInProgress;

@end

@implementation FLEXServerSelectionTableViewController

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title = @"🔮  Servers";
    }
    return self;
}

- (void)dealloc
{
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.tableView registerClass:[FLEXServerSelectionTableViewCell class] forCellReuseIdentifier:kFLEXServerSelectionCellIdentifier];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = [FLEXServerSelectionTableViewCell preferredCellHeight];

    [self updateTransactions];
}

- (void)updateTransactions
{
    self.availableServers = @[
                              [FLEXServer serverWithID:@"PROD" name:@"Live Production"],
                              [FLEXServer serverWithID:@"CRASH" name:@"Crashtest Server"],
                              [FLEXServer serverWithID:@"STAG" name:@"Staging Server"],
                              [FLEXServer serverWithID:@"DEV" name:@"Local Development"],
                              [FLEXServer serverWithID:@"QA1" name:@"Quality Assurance #1"],
                              [FLEXServer serverWithID:@"QA2" name:@"Quality Assurance #2"],
                              [FLEXServer serverWithID:@"QA3" name:@"Quality Assurance #3"],
                              [FLEXServer serverWithID:@"QA4" name:@"Quality Assurance #4"],
                              [FLEXServer serverWithID:@"QA5" name:@"Quality Assurance #5"],
                              [FLEXServer serverWithID:@"QA6" name:@"Quality Assurance #6"],
                              [FLEXServer serverWithID:@"QA7" name:@"Quality Assurance #7"]
                              ];
}

- (void)setAvailableServers:(NSArray *)availableServers
{
    if (![_availableServers isEqual:availableServers]) {
        _availableServers = availableServers;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfRows = 0;
    if (tableView == self.tableView) {
        numberOfRows = [self.availableServers count];
    }
    return numberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FLEXServer* server = [self serverAtIndexPath:indexPath inTableView:tableView];

    FLEXServerSelectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kFLEXServerSelectionCellIdentifier forIndexPath:indexPath];
    cell.server = server;

    NSString*   existingServerCode  = [[DNUtilities appDelegate] settingsItem:@"ServerCode"];
    if ([existingServerCode isEqualToString:server.serverID])
    {
        cell.selected   = YES;
    }
    else
    {
        cell.selected   = NO;
    }

    // Since we insert from the top, assign background colors bottom up to keep them consistent for each transaction.
    NSInteger totalRows = [tableView numberOfRowsInSection:indexPath.section];
    if ((totalRows - indexPath.row) % 2 == 0) {
        cell.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    } else {
        cell.backgroundColor = [UIColor whiteColor];
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FLEXServer* server = [self serverAtIndexPath:indexPath inTableView:tableView];
    
    [[DNUtilities appDelegate] setSettingsItem:@"ServerCode" value:server.serverID];
    //[DNAppConstants reloadAllConstants];

    [self.availableServers enumerateObjectsUsingBlock:
     ^(id obj, NSUInteger idx, BOOL* stop)
     {
         UITableViewCell*    cell    = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:idx inSection:0]];
         cell.selected   = (idx == indexPath.row);
     }];
}

- (FLEXServer *)serverAtIndexPath:(NSIndexPath *)indexPath inTableView:(UITableView *)tableView
{
    FLEXServer *server = nil;
    if (tableView == self.tableView) {
        server = [self.availableServers objectAtIndex:indexPath.row];
    }
    return server;
}

@end
