//
//  AppDelegate.m
//  PhotoWake
//
//  Created by 寺内 信夫 on 2014/10/24.
//  Copyright (c) 2014年 寺内 信夫. All rights reserved.
//

#import "AppDelegate.h"

#import "CustomAnnotation_Hata.h"
#import "CustomAnnotation_Photo.h"
#import "CustomAnnotation_GPS.h"
#import "CustomAnnotation_GPS_Old.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

	// Override point for customization after application launch.

	[self loadAnnotation_Hara];
	[self loadAnnotation_Photo];
	[self initAnnotation_GPS];
	[self initAnnotation_GPSOld];
	
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

- (void)loadAnnotation_Hara
{
	
	self.array_Hata = [[NSMutableArray alloc] init];
	
	CustomAnnotation_Hata *ca = [[CustomAnnotation_Hata alloc] init];
	
	ca.coordinate  = CLLocationCoordinate2DMake( 34.074, 134.556 );
	ca.no          = @"1";
	ca.title       = @"徳島城跡 １";
	ca.subtitle    = @"opening in Dec 1958";
	ca.explanation = @"34.074, 134.556";
	
	[self.array_Hata addObject: ca];
	
	
	ca = [[CustomAnnotation_Hata alloc] init];
	
	ca.coordinate  = CLLocationCoordinate2DMake( 34.0743, 134.5558 );
	ca.no          = @"2";
	ca.title       = @"徳島城跡 ２";
	ca.subtitle    = @"opening in Dec 1958";
	ca.explanation = @"34.074, 134.556";
	
	[self.array_Hata addObject: ca];
	
}

- (void)loadAnnotation_Photo
{
	
	self.array_Photo     = [[NSMutableArray alloc] init];
	self.array_Photo_Add = [[NSMutableArray alloc] init];
	
}

- (void)initAnnotation_GPS
{
	
	self.array_GPS = [[NSMutableArray alloc] init];
	
}

- (void)initAnnotation_GPSOld
{
	
	self.array_GPSOld     = [[NSMutableArray alloc] init];
	self.array_GPSOld_Add = [[NSMutableArray alloc] init];
	
}

@end
