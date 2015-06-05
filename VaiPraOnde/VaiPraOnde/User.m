//
//  User.m
//  VaiPraOnde
//
//  Created by Marcos Vinicius Souza Lacerda on 02/03/15.
//  Copyright (c) 2015 Marcos Lacerda. All rights reserved.
//

#import "User.h"

@implementation User
@synthesize Id,firstName,lastName,email,password,phone,city,sex,birthday,lastPosition,eventStatus;

+ (NSDictionary*)elementToPropertyMappings
{
    return @{
             @"Id"           : @"id",
             @"firstName"    : @"firstName",
             @"lastName"     : @"lastName",
             @"email"        : @"email"   ,
             @"password"     : @"password",
             @"phone"        : @"phone"   ,
             @"city"         : @"city"    ,
             @"sex"          : @"sex"     ,
             @"birthday"     : @"birthday",
             @"lastPosition" : @"lastPosition",
             @"eventStatus"  : @"eventStatus",
            };
}

+ (RKObjectMapping *) responseMapping
{
    // Create an object mapping.
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[User class]];
    [mapping addAttributeMappingsFromDictionary:[User elementToPropertyMappings]];
    
    
    return mapping;
}
@end
