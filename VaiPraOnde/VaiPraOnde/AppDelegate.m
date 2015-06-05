//
//  AppDelegate.m
//  VaiPraOnde
//
//  Created by Marcos Vinicius Souza Lacerda on 07/01/15.
//  Copyright (c) 2015 Marcos Lacerda. All rights reserved.
//

#import "AppDelegate.h"
#import "PonyDebugger.h"
#import "User.h"
#import "GetContatosDevice.h"
#import "ControllerLogin.h"

#define NSLog(FORMAT, ...) printf("%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [Parse enableLocalDatastore];
    
    [self initParseCrashReporting];
    [self initParse:launchOptions];
    [self registerPushNotification:application];
    [self configObjectManager];
    [GMSServices provideAPIKey:@"AIzaSyCbmrIau15A_UJyQL81COM0ReRsA2MBAS0"];
    [GetContatosDevice compartilharContatos];

    [self initRootViewController:@"Login"];
    [self configAppearance];
    
    [Fabric with:@[DigitsKit]];


    return YES;
}

#pragma mark - Método de Inicialização do PonyDebugger Client

-(void)initPonyDebugger
{
    [[PDDebugger defaultInstance] connectToURL:[NSURL URLWithString:@"ws://localhost:9000/device"]];
    [[PDDebugger defaultInstance] enableNetworkTrafficDebugging];
    [[PDDebugger defaultInstance] forwardAllNetworkTraffic];
    [[PDDebugger defaultInstance] enableViewHierarchyDebugging];
}

#pragma mark - Método de Inicialiação e Configuração do ParseCrashReportingSDK

-(void)initParseCrashReporting
{
    [ParseCrashReporting enable];
    [Parse setApplicationId:@"isrKj5pAaT66jup4vCs22Plvo3sxCzILVqOvLM7n" clientKey:@"ECpAJommsK25ZBEbnuY9RbaQoS4JObDlb8L6n3KB"];
}

#pragma mark - Método de Inicialiação e Configuração do ParseSDK
-(void)initParse : (NSDictionary *)launchOptions
{
    [Parse setApplicationId:@"isrKj5pAaT66jup4vCs22Plvo3sxCzILVqOvLM7n" clientKey:@"ECpAJommsK25ZBEbnuY9RbaQoS4JObDlb8L6n3KB"];
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    [PFFacebookUtils initializeFacebookWithApplicationLaunchOptions:launchOptions];
}

#pragma mark - Métodos de Registro e Configuração do Push Notification

-(void)registerPushNotification : (UIApplication *)application
{
    id settings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound) categories:nil];
    
    [application registerUserNotificationSettings:((UIUserNotificationSettings *)settings)];
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [[PFInstallation currentInstallation] setDeviceTokenFromData:deviceToken];
    [[PFInstallation currentInstallation] saveInBackground];
    
    NSLog(@"Token APNS: %@", [[NSString stringWithFormat:@"%@",deviceToken] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]]);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    if (application.applicationState == UIApplicationStateInactive)
    {
        [PFAnalytics trackAppOpenedWithRemoteNotificationPayload:userInfo];
    }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [PFPush handlePush:userInfo];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [[FBSDKApplicationDelegate sharedInstance] application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [FBSDKAppEvents activateApp];
}

-(void)configObjectManager
{
    
[self setManager:[RKObjectManager managerWithBaseURL:[NSURL URLWithString:@"http://appserver-danilopereira.rhcloud.com/rest/"]]];
[[[self manager] HTTPClient] setDefaultHeader:@"Content-Type" value:RKMIMETypeJSON];
    
[self setPutRequestDescriptor:[RKRequestDescriptor requestDescriptorWithMapping:[[User responseMapping] inverseMapping]
                               objectClass:[User class] rootKeyPath:nil method:RKRequestMethodPUT]];


[[self manager] setRequestSerializationMIMEType:RKMIMETypeJSON];
[[self manager] addRequestDescriptor :[self putRequestDescriptor]];

}

#pragma mark - Método para Inicializar o RootViewController

-(void)initRootViewController : (NSString *)rootController
{
    [self setWindow:[[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds]];
    
    UISplitViewController  *controllerSplit    = [[self defineStoryboard] instantiateViewControllerWithIdentifier:@"ControllerSplit"];
    UINavigationController *navigation         = [[self defineStoryboard] instantiateViewControllerWithIdentifier:@"Navigation"];
    ControllerLogin        *controllerLogin    = [[self defineStoryboard] instantiateViewControllerWithIdentifier:@"ControllerLogin"];
    
    
    [[navigation navigationItem] setLeftBarButtonItem :[controllerSplit displayModeButtonItem]];
    [[navigation navigationItem] setLeftItemsSupplementBackButton:YES];
    
    [controllerSplit setPreferredPrimaryColumnWidthFraction:0.5];
    [controllerSplit setMaximumPrimaryColumnWidth :160.0f];
    
    if ([rootController isEqualToString:@"Login"])
        [[self window] setRootViewController:controllerLogin];
    
    if ([rootController isEqualToString:@"Home"])
        [[self window] setRootViewController:controllerSplit];
    
    [[self window] makeKeyAndVisible];
}

#pragma mark - Método que obtêm a instância do Storyboard baseado no Device

-(UIStoryboard *)defineStoryboard
{
    UIStoryboard *storyboard;
    int height = [UIScreen mainScreen].bounds.size.height;
    
    if (height == 480)
        storyboard = [UIStoryboard storyboardWithName:@"Iphone4"     bundle:nil];
    if (height == 568)
        storyboard = [UIStoryboard storyboardWithName:@"Iphone5"     bundle:nil];
    if (height == 667)
        storyboard = [UIStoryboard storyboardWithName:@"Iphone6"     bundle:nil];
    if (height == 736)
        storyboard = [UIStoryboard storyboardWithName:@"Iphone6Plus" bundle:nil];
    
    return storyboard;
}


#pragma mark - Método que Define á aparência de uma Classe

-(void)configAppearance
{
    [[UINavigationBar appearance]  setBackIndicatorImage               :[UIImage imageNamed:@"menu.png"]];
    [[UINavigationBar appearance]  setTintColor                        :[UIColor whiteColor]];
    [[UINavigationBar appearance]  setBackIndicatorTransitionMaskImage :[UIImage imageNamed:@"menu.png"]];
}

@end
