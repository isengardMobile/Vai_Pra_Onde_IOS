//
//  AppDelegate.h
//  VaiPraOnde
//
//  Created by Marcos Vinicius Souza Lacerda on 07/01/15.
//  Copyright (c) 2015 Marcos Lacerda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <ParseCrashReporting/ParseCrashReporting.h>
#import <ParseFacebookUtilsV4/PFFacebookUtils.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import <RestKit/RestKit.h>
#import <Fabric/Fabric.h>
#import <DigitsKit/DigitsKit.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow    *window;

//Propriedades RestKit
@property(nonatomic) RKObjectManager      *manager;
@property(nonatomic) RKRequestDescriptor  *putRequestDescriptor;
@property(nonatomic) RKResponseDescriptor *response;

@end

