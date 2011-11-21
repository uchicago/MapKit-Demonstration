//
//  AppDelegate.m
//  MapKitDemonstration
//
//  Created by T. Andrew Binkowski on 11/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "NSArray+Shuffle.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;
@synthesize locationManager;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //
    // Logging Test 
    //
    
    // This will always log
    NSLog(@"NSLog statement");
    ALog(@"ALog is the same as NSLog");
    
    // This will only log if in "Debug" scheme
    DLog(@"DLog statement");    
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self.viewController = [[ViewController alloc] initWithNibName:@"ViewController_iPhone" bundle:nil];
    } else {
        self.viewController = [[ViewController alloc] initWithNibName:@"ViewController_iPad" bundle:nil];
    }
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    
    //
    // Test NSSArray+Shuffle Category
    //
    NSArray *places = [NSArray arrayWithObjects:@"Universal Studios", @"Disney World", @"Sea World", nil];
    NSLog(@"Places (before): %@",places);
    NSLog(@"Places (after): %@",[places shuffle]);
    
    //
    // Create an "accurate" location manager object 
    //
    locationManager = [[CLLocationManager alloc] init];
    [locationManager setDistanceFilter:kCLDistanceFilterNone];
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [locationManager setHeadingFilter:kCLDistanceFilterNone];
    locationManager.delegate = self;
    //[locationManager startUpdatingLocation];
    [locationManager startMonitoringSignificantLocationChanges];
    
    return YES;
}



- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

#pragma mark - Location Delegate
/*******************************************************************************
 * @method          locationManager:didUpdateToLocation:fromLocation
 * @abstract        <# Abstract #>
 * @description     <# Description #>
 ******************************************************************************/
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{ 
    NSLog(@"%@", newLocation);
}
/*******************************************************************************
 * @method          locationManager:didFailWithError
 * @abstract        <# Abstract #>
 * @description     <# Description #>
 ******************************************************************************/
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Could not find location: %@", error);
}

/*******************************************************************************
 * @method          locationManager:didUpdateWithHeading
 * @abstract        <# Abstract #>
 * @description     <# Description #>
 ******************************************************************************/
- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
    NSLog(@"%@",newHeading);
}
@end
