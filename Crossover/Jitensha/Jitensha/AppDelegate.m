//
//  AppDelegate.m
//  Jitensha
//
//  Created by Admin on 10/12/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "LoginViewModel.h"
#import "ViewModelServicesImpl.h"
#import <GoogleMaps/GoogleMaps.h>
#import "PlacesViewController.h"
#import "PlacesViewModel.h"
#import <SAMKeychain/SAMKeychain.h>

@interface AppDelegate ()

@property(strong, nonatomic) LoginViewModel *loginViewModel;
@property(strong, nonatomic) PlacesViewModel *placesViewModel;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    [SAMKeychain deletePasswordForService:@"JitenshaService" account:@"Jitensha"];
    NSString *authToken = [SAMKeychain passwordForService:@"JitenshaService" account:@"Jitensha"];
    if (authToken) {
        PlacesViewController *placesViewController = [storyboard instantiateViewControllerWithIdentifier:@"PlacesViewController"];
        self.placesViewModel = [[PlacesViewModel alloc] initWithServices:[ViewModelServicesImpl sharedInstance]];
        [placesViewController setViewModel:self.placesViewModel];
        self.window.rootViewController = placesViewController;
    }
    else {
        LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        self.loginViewModel = [[LoginViewModel alloc] initWithServices:[ViewModelServicesImpl sharedInstance]];
        [loginViewController setViewModel:self.loginViewModel];
        self.window.rootViewController = loginViewController;
    }
    
    [GMSServices provideAPIKey:@"AIzaSyDWwiyXqCAgPed0APFx1I90OckrCnzw6gw"];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
