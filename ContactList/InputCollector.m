//
//  InputCollector.m
//  ContactList
//
//  Created by asu on 2015-08-25.
//  Copyright (c) 2015 asu. All rights reserved.
//

#import "InputCollector.h"


@implementation InputCollector

// getInput
// Issue a prompt to the user and return the typed input
//
- (NSString*) getInput:(NSString*)prompt{
    // 255 unit long array of characters
    char inputChars[255];
    char promptChars[255];
    [prompt getCString:promptChars maxLength:255 encoding:NSUTF8StringEncoding];
    
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


@end
