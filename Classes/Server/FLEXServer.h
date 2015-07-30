//
//  FLEXServer.h
//  Flipboard
//
//  Created by Ryan Olson on 2/8/15.
//  Copyright (c) 2015 Flipboard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"

@interface FLEXServer : NSObject

@property (nonatomic, copy) NSString *serverID;
@property (nonatomic, copy) NSString *name;

+ (instancetype)serverWithID:(NSString *)serverID name:(NSString *)name;

@end
