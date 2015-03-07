//
//  Message.m
//  Re-Lease
//
//  Created by Alois Barreras on 3/7/15.
//  Copyright (c) 2015 Josip Injic. All rights reserved.
//

#import "Message.h"
#import <Parse/PFObject+Subclass.h>


@implementation Message

@dynamic roomId, body, user;

+ (void)load {
    dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        [self registerSubclass];
    });
}

+ (NSString *)parseClassName {
    return @"Message";
}

@end
