//
//  Contact.m
//  ContactList
//
//  Created by asu on 2015-08-25.
//  Copyright (c) 2015 asu. All rights reserved.
//

#import "Contact.h"

@implementation Contact

-(instancetype)init{
    self = [super init];
    _name = @"";
    _email = @"";
    return self;
}

-(void) show{
    NSLog(@"");
    NSLog(@"Name: %@", self.name);
    NSLog(@"Email: %@", self.email);
    NSLog(@"");
}


@end
