//
//  FLEXServer.m
//  Flipboard
//
//  Created by Ryan Olson on 2/8/15.
//  Copyright (c) 2015 Flipboard. All rights reserved.
//

#import "FLEXServer.h"

@implementation FLEXServer

+ (instancetype)serverWithID:(NSString *)serverID name:(NSString *)name;
{
    FLEXServer *server = [[self alloc] init];
    server.serverID = serverID;
    server.name     = name;
    return server;
}

- (NSString *)description
{
    NSString *description = [super description];

    description = [description stringByAppendingFormat:@" id = %@;", self.serverID];
    description = [description stringByAppendingFormat:@" name = %@;", self.name];

    return description;
}

@end
