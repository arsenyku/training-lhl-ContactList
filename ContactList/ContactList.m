//
//  ContactList.m
//  ContactList
//
//  Created by asu on 2015-08-25.
//  Copyright (c) 2015 asu. All rights reserved.
//

#import "ContactList.h"

@interface ContactList()

@property (nonatomic, strong) NSMutableArray* contacts;
    
@end

@implementation ContactList

-(instancetype)init{
    self = [super init];
    _contacts = [[NSMutableArray alloc] init];
    return self;
}

-(void)addContact:(Contact *)newContact{
    [self.contacts addObject:newContact];
}

-(void)listContacts{
    if ([self.contacts count] < 1){
        NSLog(@"Your contacts list is currently empty");
        return;
    }
    
    for(int i = 0; i<[self.contacts count]; i++){
        Contact *contact = self.contacts[i];
        NSLog(@"%d: %@ (%@)", i, contact.name, contact.email);
    }
}

-(void)showContactWithId:(NSNumber *)idNumber{
    
    if (idNumber == nil){
        NSLog(@"Sorry I don't recognize the contact ID you provided.");
        return;
    }
    
    int index = [idNumber intValue];
    
    if (index < 0 || index >= [self.contacts count]){
        NSLog(@"Sorry, there is no contact with ID %d", index);
        return;
    }
    
    Contact* contactToShow = self.contacts[index];
    [contactToShow show];
    
}

-(void)findContactsByStringMatch:(NSString*)stringToMatch{
    for (Contact *contact in self.contacts) {
        
        if (stringToMatch init)
        
    }
}


@end
