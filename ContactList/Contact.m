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
    _phoneNumbers = [[NSMutableArray alloc] init];
    return self;
}

-(void) show{
    char output[255];
    printf("\n");
    
    [[NSString stringWithFormat:@"Name: %@\n", self.name] getCString:output maxLength:255 encoding:NSUTF8StringEncoding] ;
    printf("%s", output);
    
    [[NSString stringWithFormat:@"Email: %@\n", self.email] getCString:output maxLength:255 encoding:NSUTF8StringEncoding];
    printf("%s", output);
    
    if ([self.phoneNumbers count] > 0){
        
        printf("Phone numbers:\n");
    
	    for (NSDictionary* phoneDetails in self.phoneNumbers) {
            
            NSString *phoneLabel = [phoneDetails objectForKey:@"label"];
            NSString *phoneNumber = [phoneDetails objectForKey:@"number"];
            
            [[NSString stringWithFormat:@"    %@:%@\n", phoneLabel, phoneNumber] getCString:output maxLength:255 encoding:NSUTF8StringEncoding];
            printf("%s", output);
    	}
    }
        
    NSLog(@"");
}


@end
