//
//  Post.m
//  Re-Lease
//
//  Created by Alois Barreras on 3/6/15.
//  Copyright (c) 2015 Josip Injic. All rights reserved.
//

#import "Post.h"
#import <Parse/PFObject+Subclass.h>

@implementation Post

+ (void)load {
    dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        [self registerSubclass];
    });
}

+ (NSString *)parseClassName {
    return @"Course";
}

@end
