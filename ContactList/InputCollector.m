//
//  InputCollector.m
//  ContactList
//
//  Created by asu on 2015-08-25.
//  Copyright (c) 2015 asu. All rights reserved.
//

#import "InputCollector.h"
#import "ContactList.h"

@implementation InputCollector

// getInput
// Issue a prompt to the user and return the typed input
//
- (NSString*) getInput:(NSString*)prompt{
    // 255 unit long array of characters
    char inputChars[255];
    char promptChars[512];
    [prompt getCString:promptChars maxLength:sizeof(promptChars) encoding:NSUTF8StringEncoding];
    
    printf("%s",promptChars);
    // limit input to max 255 characters
    fgets(inputChars, 255, stdin);
    
    // convert char array to an NSString object
    NSString *inputString = [NSString stringWithUTF8String:inputChars] ;
    
    // remove newline
    inputString = [inputString substringToIndex:[inputString length] - 1 ];
    
    return inputString;
}

// This method will take in a single string parameter promptString,
// and return whatever text the user inputs after that prompt.
-(NSString *)inputForPrompt:(NSString *)promptString{
    return [self getInput:promptString];
}

-(NSDictionary*) promptForPhoneNumber{
    NSString *phoneLabel = [self inputForPrompt:@"Enter the label of the phone number:"];
    
    if ( [phoneLabel isEqualToString:@""] ){
        return nil;
    }
    
    NSString *phoneNumber = [self inputForPrompt:@"Enter the phone number:"];
    
    NSDictionary *newPhone = @{ @"label":phoneLabel, @"number":phoneNumber };
    
    return newPhone;
}


-(Contact*) promptForNewContactForList:(ContactList *)list{
    Contact* newContact = [[Contact alloc]init];
    
    newContact.email = [self inputForPrompt:@"Enter the Contact's email:"];
    
    if ( [list hasEmail:newContact.email] ){
        NSLog(@"That contact already exists!");
        return nil;
    }
    
    newContact.name = [self inputForPrompt:@"Enter the Contact's name:"];
    
    printf("\nEnter phone numbers for the contact.\n");
    printf("When you are done, enter a blank label.\n");
    
    while (YES) {
        
        printf("\n");
        NSDictionary *newPhone = [self promptForPhoneNumber];
        
        if (newPhone == nil)
            break;  // Stop prompting for phone numbers
        
        [newContact.phoneNumbers addObject:newPhone];
        
    }
    
    return newContact;
}



@end
