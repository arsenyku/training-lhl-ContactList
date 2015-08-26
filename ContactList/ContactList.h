//
//  ContactList.h
//  ContactList
//
//  Created by asu on 2015-08-25.
//  Copyright (c) 2015 asu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Contact.h"

@interface ContactList : NSObject

-(void)addContact:(Contact *)newContact;
-(void)listContacts;
-(void)showContactWithId:(NSNumber*)idNumber;
-(void)findContactsByStringMatch:(NSString*)stringToMatch;
-(BOOL)hasEmail:(NSString*)email;

@end
