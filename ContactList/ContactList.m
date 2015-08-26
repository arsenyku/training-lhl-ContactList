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
        printf("Your contacts list is currently empty.");
        return;
    }
    
    for(int i = 0; i<[self.contacts count]; i++){
        Contact *contact = self.contacts[i];
        char output[255];
        [[NSString stringWithFormat:@"%d: %@ (%@)", i, contact.name, contact.email]
               getCString:output maxLength:sizeof(output) encoding:NSUTF8StringEncoding];
        printf("%s",output);
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
    int matches = 0;
    for (Contact *contact in self.contacts) {
        
        BOOL matchFound = ( [contact.name rangeOfString:stringToMatch].length > 0 ) ||
                          ( [contact.email rangeOfString:stringToMatch].length > 0 );

        if (matchFound){
        
            matches++;
            printf("\n");
            [contact show];
        
        }
        
    }
    
    char output[255];
    printf("\n");
    [[NSString stringWithFormat:@"Found %d matches\n", matches] getCString:output maxLength:255 encoding:NSUTF8StringEncoding];
    printf("%s", output);
}

-(BOOL)hasEmail:(NSString*)email{
    for (Contact *contact in self.contacts) {
        
        if ([contact.email isEqualToString:email]){
            return YES;
        }
    
    }
    
    return NO;
}




-(NSString*) cacheFilePath{
	
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    
    NSString *currentPath = [fileManager currentDirectoryPath];

    //Then write the file
    NSString *filePath = [currentPath stringByAppendingString:@"/Contacts.plist"];

    return filePath;
}

-(void) saveToCache{
    NSMutableArray *contactsAsPropertyList = [[NSMutableArray alloc] init];
    for (Contact* contact in self.contacts) {
		[contactsAsPropertyList addObject:[contact propertyList]];
    }
    BOOL saveSuccess = [contactsAsPropertyList writeToFile:[self cacheFilePath] atomically:YES];
    
    if (!saveSuccess){
	    NSLog(@"saveToCache: Failed to save to %@ using data %@", [self cacheFilePath], contactsAsPropertyList);
    }
}

-(void)readFromCache{

    NSArray *cachedData = [NSArray arrayWithContentsOfFile:[self cacheFilePath]];
    
    for (NSDictionary* contactData in cachedData) {
        [self.contacts addObject:[[Contact alloc] initWithPropertyList:contactData]];
    }
    
    
    //NSLog(@"Loaded %lu contacts from storage.", (unsigned long)[self.contacts count]);
}


@end
