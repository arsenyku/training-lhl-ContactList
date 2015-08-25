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

Contact* promptForNewContact(InputCollector* inputCollector){
    Contact* newContact = [[Contact alloc]init];
    
    newContact.name = [inputCollector inputForPrompt:@"Enter the Contact's name:"];
    newContact.email = [inputCollector inputForPrompt:@"Enter the Contact's email:"];
    
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
        
    	    //NSLog(@"%@", input);
            
            input = [[input stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] lowercaseString];
            
            //NSLog(@"%@",[input substringToIndex:[ShowCommand length]]);

            if ([input isEqualToString:@""]){
            
            } else if ([input isEqualToString:NewCommand]) {
                [contacts addContact:promptForNewContact(inputCollector)];
            
            } else if ([input isEqualToString:ListCommand]) {
                [contacts listContacts];
                
            } else if ([[input substringToIndex:[ShowCommand length]] isEqualToString:@"show"]) {
                [contacts showContactWithId:getIdFromInput(input)];
            
            } else if ([[input substringToIndex:[FindCommand length]] isEqualToString:@"find"]) {
                NSString *stringToMatch = [[input substringFromIndex:[FindCommand length]]
                    stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                
                [contacts findContactsByStringMatch:stringToMatch];

            } else if ([input isEqualToString:QuitCommand]) {
                NSLog(@"Exiting.");
                stayInInputLoop = NO;
                break;
            } else{
        	};
        
        }
    }
    return 0;
}
