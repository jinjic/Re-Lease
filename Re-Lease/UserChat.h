//
//  UserChat.h
//  Re-Lease
//
//  Created by Alois Barreras on 3/7/15.
//  Copyright (c) 2015 Josip Injic. All rights reserved.
//

#import <Parse/Parse.h>

@interface UserChat : PFObject <PFSubclassing>

@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *roomId;
@property (nonatomic, strong) PFUser *user;
@property (nonatomic, copy) NSString *lastMessage;

@end
