//
//  main.m
//  ContactList
//
//  Created by asu on 2015-08-25.
//  Copyright (c) 2015 asu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InputCollector.h"
#import "Contact.h"
#import "ContactList.h"

NSDictionary* promptForPhoneNumber(InputCollector *inputCollector){
    NSString *phoneLabel = [inputCollector inputForPrompt:@"Enter the label of the phone number:"];
    
    if ( [phoneLabel isEqualToString:@""] ){
        return nil;
    }
    
    NSString *phoneNumber = [inputCollector inputForPrompt:@"Enter the phone number:"];
    
    NSDictionary *newPhone = @{ @"label":phoneLabel, @"number":phoneNumber };

    return newPhone;
}


Contact* promptForNewContact(InputCollector *inputCollector, ContactList *list){
    Contact* newContact = [[Contact alloc]init];
    
    newContact.email = [inputCollector inputForPrompt:@"Enter the Contact's email:"];
    
    if ( [list hasEmail:newContact.email] ){
        NSLog(@"That contact already exists!");
        return nil;
    }
    
    newContact.name = [inputCollector inputForPrompt:@"Enter the Contact's name:"];
    
    printf("\nEnter phone numbers for the contact.\n");
    printf("When you are done, enter a blank label.\n");
    
    while (YES) {
    
        printf("\n");
        NSDictionary *newPhone = promptForPhoneNumber(inputCollector);
        
        if (newPhone == nil)
            break;  // Stop prompting for phone numbers

        [newContact.phoneNumbers addObject:newPhone];
        
    }
    
    return newContact;
}



NSNumber* stringToNumber(NSString *inputString){
    
    NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
    return [numberFormatter numberFromString:inputString];

    
    
}

NSNumber* getIdFromInput(NSString* input){
    
    NSArray* components = [input componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSNumber *contactId = nil;
    
    if ( [components count] >= 2 ){
        NSString *idComponent = components[1];
        contactId = stringToNumber(idComponent);
    }
    
    return contactId;

}



int main(int argc, const char * argv[]) {
    @autoreleasepool {
    	
        InputCollector* inputCollector = [[InputCollector alloc] init];
        const char *prompt = "\n\n"
        				"What would you like do next?\n"
				       	"new - Create a new contact\n"
				        "list - List all contacts\n"
        				"show <id> - Show the details for contact <id>\n"
        				"find <partial name or email> - Show the details for all contacts that match\n"
				       	"quit - Exit Application\n"
                       	"> ";
        
        ContactList *contacts = [[ContactList alloc] init];
        
        BOOL stayInInputLoop = YES;
        
        NSString* const NewCommand = @"new";
        NSString* const ListCommand = @"list";
        NSString* const ShowCommand = @"show";
        NSString* const FindCommand = @"find";
        NSString* const QuitCommand = @"quit";
        
        while (stayInInputLoop){
	        NSString* input = [inputCollector inputForPrompt:[NSString stringWithUTF8String:prompt]];
        
            input = [[input stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] lowercaseString];
            
            if ([input isEqualToString:@""]){
            
            } else if ([input hasPrefix:NewCommand]) {
                Contact* newContact = promptForNewContact(inputCollector, contacts);
                if (newContact != nil){
                    [contacts addContact:newContact];
                }
            
            } else if ([input hasPrefix:ListCommand]) {
                [contacts listContacts];
                
            } else if ([input hasPrefix:ShowCommand]) {
                
                [contacts showContactWithId:getIdFromInput(input)];
            
            } else if ([input hasPrefix:FindCommand]) {

                NSString *stringToMatch = [[input substringFromIndex:[FindCommand length]]
                    stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                
                [contacts findContactsByStringMatch:stringToMatch];

            } else if ([input hasPrefix:QuitCommand]) {
                NSLog(@"Exiting.");
                stayInInputLoop = NO;
                break;

            };
        
        }
    }
    return 0;
}
