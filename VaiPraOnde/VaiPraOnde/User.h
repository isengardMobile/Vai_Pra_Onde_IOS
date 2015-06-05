//
//  User.h
//  VaiPraOnde
//
//  Created by Marcos Vinicius Souza Lacerda on 02/03/15.
//  Copyright (c) 2015 Marcos Lacerda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>

@interface User : NSObject
{
    NSString *_id;
    NSString *_firstName;
    NSString *_lastName;
    NSString *_email;
    NSString *_password;
    NSString *_phone;
    NSString *_city;
    NSString *_sex;
    NSString *_birthday;
    NSArray  *_lastPosition;
    NSString *_eventStatus;
}

@property (nonatomic,getter=getId)            NSString *Id;
@property (nonatomic,getter=getFirstName)     NSString *firstName;
@property (nonatomic,getter=getLastName)      NSString *lastName;
@property (nonatomic,getter=getEmail)         NSString *email;
@property (nonatomic,getter=getPassword)      NSString *password;
@property (nonatomic,getter=getPhone)         NSString *phone;
@property (nonatomic,getter=getCity)          NSString *city;
@property (nonatomic,getter=getSex)           NSString *sex;
@property (nonatomic,getter=getBirthday)      NSString *birthday;
@property (nonatomic,getter=getLastPosition)  NSArray  *lastPosition;
@property (nonatomic,getter=getEventStatus)   NSString *eventStatus;


+ (RKObjectMapping *) responseMapping;



// Serviços :
            //_* user/create
            //_* user/list
            //_* user/login


          //_* event/create
         /*
          id
          owner
          date
          quantityUser
          title
          address
          meetingAddress
          longitude
          latitude
        */








@end
