//
//  PostLocation.m
//  Re-Lease
//
//  Created by Alois Barreras on 3/7/15.
//  Copyright (c) 2015 Josip Injic. All rights reserved.
//

#import "PostLocation.h"
#import <Parse/PFObject+Subclass.h>

@implementation PostLocation

@dynamic name, location, address;

+ (void)load {
    dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        [self registerSubclass];
    });
}

+ (NSString *)parseClassName {
    return @"PostLocation";
}

@end
