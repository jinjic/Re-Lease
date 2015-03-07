//
//  UserChat.m
//  Re-Lease
//
//  Created by Alois Barreras on 3/7/15.
//  Copyright (c) 2015 Josip Injic. All rights reserved.
//

#import "UserChat.h"
#import <Parse/PFObject+Subclass.h>

@implementation UserChat

@dynamic description, roomId, user;

+ (void)load {
    dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        [self registerSubclass];
    });
}

+ (NSString *)parseClassName {
    return @"UserChat";
}

@end
