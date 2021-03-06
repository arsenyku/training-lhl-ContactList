//
//  Contact.h
//  ContactList
//
//  Created by asu on 2015-08-25.
//  Copyright (c) 2015 asu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Contact : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSMutableArray *phoneNumbers;

-(void) show;

-(NSDictionary*)propertyList;
-(instancetype)initWithPropertyList:(NSDictionary*)propertyList;

@end
