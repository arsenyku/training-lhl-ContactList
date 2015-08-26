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
				        "reset - immediately deletes all contacts, including those previously stored\n"
				       	"quit - Exit Application\n"
                       	"> ";
        
        ContactList *contacts = [[ContactList alloc] init];
        [contacts readFromCache];
        
        BOOL stayInInputLoop = YES;
        
        NSString* const NewCommand = @"new";
        NSString* const ListCommand = @"list";
        NSString* const ShowCommand = @"show";
        NSString* const FindCommand = @"find";
        NSString* const ResetCommand = @"reset";
        NSString* const QuitCommand = @"quit";
        
        while (stayInInputLoop){
	        NSString* input = [inputCollector inputForPrompt:[NSString stringWithUTF8String:prompt]];
        
            input = [[input stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] lowercaseString];
            
            if ([input isEqualToString:@""]){
            
            } else if ([input hasPrefix:NewCommand]) {
                Contact* newContact = [inputCollector promptForNewContactForList:contacts];
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

            } else if ([input hasPrefix:ResetCommand]) {
                contacts = [[ContactList alloc] init];
                [contacts saveToCache];
                
            } else if ([input hasPrefix:QuitCommand]) {
                NSLog(@"Exiting.");
                [contacts saveToCache];
                stayInInputLoop = NO;
                break;

            };
        
        }
    }
    return 0;
}
