//
//  Message.h
//  Re-Lease
//
//  Created by Alois Barreras on 3/7/15.
//  Copyright (c) 2015 Josip Injic. All rights reserved.
//

#import <Parse/Parse.h>

@interface Message : PFObject <PFSubclassing>

@property (nonatomic, copy) NSString *body;
@property (nonatomic, copy) NSString *roomId;
@property (nonatomic, strong) PFUser *user;


@end
