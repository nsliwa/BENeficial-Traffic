//
//  AppDelegate.m
//  B.E.N.-Lab1
//
//  Created by Nicole Sliwa on 2/3/15.
//  Copyright (c) 2015 Team B.E.N. All rights reserved.
//

#import "AppDelegate.h"
#import <Foundation/Foundation.h>

@interface AppDelegate () <CLLocationManagerDelegate>

@property NSTimer* timer;

@end

@implementation AppDelegate
/*
-(NSTimer*) timer {
    
    if(!_timer)
        _timer = ;
    
    return _timer;
    
}
*/
-(CLLocationManager*) locationManager {
    
    if(!_locationManager)
        _locationManager = [[CLLocationManager alloc] init];
    
    NSLog(@"init loc mngr in app del");
    
    return _locationManager;
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.locationManager = [[CLLocationManager alloc] init];
    if ([CLLocationManager locationServicesEnabled]) {
        [self.locationManager setDelegate:self];
        
        if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
            [self.locationManager requestAlwaysAuthorization];
        }
        
        [self.locationManager startUpdatingLocation];
        NSLog(@"loc serv enbld");
    }
    
    return YES;
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status == kCLAuthorizationStatusAuthorizedAlways) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kCLAuthorizationStatusAuthorizedAlways" object:self];
        NSLog(@"chngd auth stat");
    }
    NSLog([NSString stringWithFormat:@"auth status: %d", status]);
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    NSLog([NSString stringWithFormat:@"did update location: (%f, %f)",
    [[locations lastObject] coordinate].latitude,
    [[locations lastObject] coordinate].longitude]);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kCLAuthorizationStatusAuthorizedAlways" object:self];
    NSLog(@"chngd auth stat");
    
    [self.locationManager stopUpdatingLocation];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(_turnOnLocationManager)  userInfo:nil repeats:NO];
}

- (void)_turnOnLocationManager {
    [self.locationManager startUpdatingLocation];
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
