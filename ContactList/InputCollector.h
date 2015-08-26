//
//  InputCollector.h
//  ContactList
//
//  Created by asu on 2015-08-25.
//  Copyright (c) 2015 asu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Contact.h"
#import "ContactList.h"

@interface InputCollector : NSObject

@property (nonatomic, strong) NSMutableArray* history;

-(NSString *)inputForPrompt:(NSString *)promptString;

-(Contact*) promptForNewContactForList:(ContactList *)list;

-(void)addToHistory:(NSString*)command;
-(NSArray*)retrieveLastCommands:(NSNumber*)numberOfCommands;

@end
