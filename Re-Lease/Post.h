//
//  Post.h
//  Re-Lease
//
//  Created by Alois Barreras on 3/6/15.
//  Copyright (c) 2015 Josip Injic. All rights reserved.
//

#import <Parse/Parse.h>

@interface Post : PFObject <PFSubclassing>

@property (nonatomic, copy) NSString *description;
@property (nonatomic, copy) NSString *rent;
@property (nonatomic, strong) NSArray *utilities;
@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *endDate;

@property bool pets;

@end
