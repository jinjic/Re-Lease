//
//  PostLocation.h
//  Re-Lease
//
//  Created by Alois Barreras on 3/7/15.
//  Copyright (c) 2015 Josip Injic. All rights reserved.
//

#import <Parse/Parse.h>

@interface PostLocation : PFObject <PFSubclassing>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, strong) PFGeoPoint *location;


@end
