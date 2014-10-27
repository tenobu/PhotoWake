//
//  CameraViewController.m
//  PhotoWake
//
//  Created by 寺内 信夫 on 2014/10/26.
//  Copyright (c) 2014年 寺内 信夫. All rights reserved.
//

#import "CameraViewController.h"

#import "AppDelegate.h"
#import "CustomAnnotation_Hata.h"
#import "CustomAnnotation_Photo.h"
#import "CustomAnnotation_GPS.h"
#import "CustomAnnotation_GPS_Old.h"

@interface CameraViewController ()
{
	
@private
	
	AppDelegate *app;
	
	CLLocationManager *locationManager;
	
	CLLocationCoordinate2D coordinate;
	
	CLLocationDegrees   latitude , latitude_G_Old , latitude_P_Old;
	CLLocationDegrees   longitude, longitude_G_Old, longitude_P_Old;
	CLLocationDirection heading;
	
}

@end

@implementation CameraViewController

- (void)viewDidLoad
{

	[super viewDidLoad];
	
	app = [[UIApplication sharedApplication] delegate];

	[self initLocationManager];

}

- (void)didReceiveMemoryWarning
{

	[super didReceiveMemoryWarning];

	// Dispose of any resources that can be recreated.

}

- (void)initLocationManager
{
	
	latitude_P_Old = longitude_P_Old = latitude_G_Old = longitude_G_Old = 9999;
	
	locationManager = [[CLLocationManager alloc] init];
	
	[locationManager requestAlwaysAuthorization];
	
	locationManager.delegate = self;
	
	locationManager.distanceFilter  = kCLDistanceFilterNone;
	locationManager.desiredAccuracy = kCLLocationAccuracyBest;
	
	if ( [CLLocationManager locationServicesEnabled] ) {
		
		[locationManager startUpdatingLocation];
		
	}
	
	if ( [CLLocationManager headingAvailable] ) {
		
		[locationManager startUpdatingHeading];
		
	}
	
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)     locationManager: (CLLocationManager *)manager
didChangeAuthorizationStatus: (CLAuthorizationStatus)status
{
	
	if ( status == kCLAuthorizationStatusNotDetermined ) {
		// ユーザが位置情報の使用を許可していない
	}
	
}

- (void)locationManager: (CLLocationManager *)manager
	 didUpdateLocations: (NSArray *)locations
{
	
	CLLocation* location = [locations lastObject];
	
	CLLocationDegrees lat = location.coordinate.latitude;
	CLLocationDegrees lon = location.coordinate.longitude;

	
	self.label_1.text = [NSString stringWithFormat: @"coord = (%f,%f)", lat, lon];

	
	if ( latitude_G_Old == 9999 && longitude_G_Old == 9999 ) {
		
		latitude  = latitude_G_Old  = lat;
		longitude = longitude_G_Old = lon;
		
		[self addAnnotation_GPS];
		
	} else {
		
		CLLocationDegrees _lat = lat - latitude_G_Old;
		CLLocationDegrees _lon = lon - longitude_G_Old;
		
		if ( _lat < 0 ) _lat *= -1;
		if ( _lon < 0 ) _lon *= -1;
		
		// 0.00007, 0.0001
		if ( _lat > 0.0001 || _lon > 0.0001 ) {
			
			CustomAnnotation_GPS *gps = [self lastAnnotation_GPS];
			
			[self addAnnotation_GPSOld];
			
			CustomAnnotation_GPS_Old *gps_old = [self lastAnnotation_GPSOld];
			
			gps_old.coordinate = gps.coordinate;
			
			latitude  = latitude_G_Old  = lat;
			longitude = longitude_G_Old = lon;
			
			gps.coordinate = CLLocationCoordinate2DMake( latitude, longitude );
			
		}
		
	}
	
}

- (void)locationManager: (CLLocationManager *)manager
	   didFailWithError: (NSError *)error
{
	
	
}

- (void)locationManager: (CLLocationManager *)manager
	   didUpdateHeading: (CLHeading *)newHeading
{
	
	heading = newHeading.trueHeading;
	
}

- (IBAction)button_Camera_Action:(id)sender
{

	CLLocationDegrees lat = latitude;
	CLLocationDegrees lon = longitude;
	
	if ( latitude_P_Old == 9999 && longitude_P_Old == 9999 ) {
		
		latitude_P_Old  = lat;
		longitude_P_Old = lon;
		
		[self addAnnotation_Photo];
		
	} else {
		
		CLLocationDegrees _lat = lat - latitude_P_Old;
		CLLocationDegrees _lon = lon - longitude_P_Old;
		
		if ( _lat < 0 ) _lat *= -1;
		if ( _lon < 0 ) _lon *= -1;
		
		// 0.00007, 0.0001
		if ( _lat > 0.0001 || _lon > 0.0001 ) {
			
			[self addAnnotation_Photo];
			
			latitude  = latitude_P_Old  = lat;
			longitude = longitude_P_Old = lon;

		}
		
	}
	
	//写真の登録

}

- (void) addAnnotation_Photo
{
	
	CustomAnnotation_Photo *ca = [[CustomAnnotation_Photo alloc] init];
	
	ca.coordinate  = CLLocationCoordinate2DMake( latitude, longitude );// 34.074, 134.554 );

	ca.title       = @"写真の撮影場所";
	ca.subtitle    = [NSString stringWithFormat: @"%f, %f", latitude, longitude];
	ca.explanation = @"";
	
	[app.array_Photo_Add addObject: ca];
	
}

- (void)addAnnotation_GPS
{
	
	CustomAnnotation_GPS *ca = [[CustomAnnotation_GPS alloc] init];
	
	ca.coordinate  = CLLocationCoordinate2DMake( latitude, longitude );// 34.076, 134.557 );
	ca.title       = @"自分の現在位置";
	ca.subtitle    = [NSString stringWithFormat: @"%f, %f", latitude, longitude];
	ca.explanation = @"";
	
	[app.array_GPSOld_Add addObject: ca];
	
}

- (CustomAnnotation_GPS *)lastAnnotation_GPS
{
	
	return [app.array_GPS lastObject];
	
}

- (void)addAnnotation_GPSOld
{
	
	CustomAnnotation_GPS_Old *ca = [[CustomAnnotation_GPS_Old alloc] init];
	
	ca.coordinate  = CLLocationCoordinate2DMake( latitude, longitude );// 34.074, 134.554 );
	ca.title       = @"Tokyo Tower";
	ca.subtitle    = @"opening in Dec 1958";
	ca.explanation = @"34.074, 134.556";
	
	[app.array_GPSOld_Add addObject: ca];
	
}

- (CustomAnnotation_GPS_Old *)lastAnnotation_GPSOld
{
	
	return [app.array_GPSOld_Add lastObject];
	
}

@end
