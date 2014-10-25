//
//  MapViewController.m
//  MapEditor
//
//  Created by ビザンコムマック０９ on 2014/10/23.
//  Copyright (c) 2014年 ビザンコムマック０９. All rights reserved.
//

#import "MapViewController.h"

#import "CustomAnnotation_Hata.h"
#import "CustomAnnotation_Photo.h"
#import "CustomAnnotation_GPS.h"
#import "CustomAnnotation_GPS_Old.h"

@interface MapViewController ()
{

@private
	
	CLLocationDegrees   latitude;
	CLLocationDegrees   longitude;
	CLLocationDirection heading;
	
	NSInteger integer_HaraCount;
	NSInteger integer_PhotoCount;
	NSInteger integer_GPSCount;
	
	NSMutableArray *array_Hata;
	NSMutableArray *array_Photo;
	NSMutableArray *array_GPS;

	NSTimer *timer;
	
}

@end

@implementation MapViewController

- (void)viewDidLoad
{
	
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	self.mapView.delegate = self;

	self.mapView.showsUserLocation = YES;
	self.mapView.mapType = MKMapTypeHybrid;

	
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
	
	[self loadAnnotation_Hara];
	[self loadAnnotation_Photo];
	[self initAnnotation_GPS];
	
	MKCoordinateRegion region;
	MKCoordinateSpan span;
	span.latitudeDelta = 0.005;
	span.longitudeDelta = 0.005;
	
	CLLocation *loc = [locationManager location];

	CLLocationCoordinate2D location;
	location.latitude  = [loc coordinate].latitude;// 34.07511029;
	location.longitude = [loc coordinate].longitude;// 134.556;//55709219;
	
	region.span   = span;
	region.center = location;
	

	[self.mapView setRegion: region
				   animated: YES];
	
}

- (void)didReceiveMemoryWarning
{
	
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
	
}

- (void)mapViewWillStartLoadingMap: (MKMapView *)mapView
{
	
	MKCoordinateRegion region = mapView.region;
	
	CLLocationCoordinate2D coord = region.center;
	MKCoordinateSpan span = region.span;
	
	NSLog( @"1 coord = (%f,%f) span = (%f,%f)", coord.latitude, coord.longitude, span.latitudeDelta, span.longitudeDelta );
	
	self.label_1.text = [NSString stringWithFormat: @"coord = (%f,%f)", coord.latitude    , coord.longitude];
	self.label_2.text = [NSString stringWithFormat: @"span  = (%f,%f)", span.latitudeDelta, span.longitudeDelta];
	
}

- (void)mapViewDidFinishLoadingMap: (MKMapView *)mapView
{
	
}

- (void)        mapView: (MKMapView *)mapView
didSelectAnnotationView: (MKAnnotationView *)view
{
	
	MKCoordinateRegion region = mapView.region;
	
	CLLocationCoordinate2D coord = region.center;
	MKCoordinateSpan span = region.span;
	
	NSLog( @"2 coord = (%f,%f) span = (%f,%f)", coord.latitude, coord.longitude, span.latitudeDelta, span.longitudeDelta );
	
	self.label_1.text = [NSString stringWithFormat: @"coord = (%f,%f)", coord.latitude    , coord.longitude];
	self.label_2.text = [NSString stringWithFormat: @"span  = (%f,%f)", span.latitudeDelta, span.longitudeDelta];
	
}

- (MKOverlayRenderer *)mapView: (MKMapView *)mapView
			rendererForOverlay: (id<MKOverlay>)overlay
{
	
	return nil;
	
}

- (void)       mapView: (MKMapView *)mapView
didAddOverlayRenderers: (NSArray *)renderers
{
	
	MKCoordinateRegion region = mapView.region;
	
	CLLocationCoordinate2D coord = region.center;
	MKCoordinateSpan span = region.span;
	
	NSLog( @"3 coord = (%f,%f) span = (%f,%f)", coord.latitude, coord.longitude, span.latitudeDelta, span.longitudeDelta );
	
	self.label_1.text = [NSString stringWithFormat: @"coord = (%f,%f)", coord.latitude    , coord.longitude];
	self.label_2.text = [NSString stringWithFormat: @"span  = (%f,%f)", span.latitudeDelta, span.longitudeDelta];
	
}

- (void)      mapView: (MKMapView *)mapView
didAddAnnotationViews: (NSArray *)views
{
	
	// add detail disclosure button to callout
	[views enumerateObjectsUsingBlock: ^( id obj, NSUInteger idx, BOOL* stop ) {
		
		((MKAnnotationView*)obj).rightCalloutAccessoryView = [UIButton buttonWithType: UIButtonTypeDetailDisclosure];
		
	}];
	
}

-(void)               mapView: (MKMapView *)mapView
               annotationView: (MKAnnotationView *)view
calloutAccessoryControlTapped: (UIControl *)control
{

	// create right accessory view
	UILabel* sample = [[UILabel alloc] initWithFrame: CGRectMake( 0.f, 0.f, 100.f, 32.f )];
	
	sample.backgroundColor = [UIColor clearColor];
	sample.font = [UIFont fontWithName:@"Helvetica" size: 13];
	sample.text = ((CustomAnnotation *)view.annotation).explanation;
	sample.textColor = [UIColor whiteColor];
	
	// add view to callout
	//view.rightCalloutAccessoryView = nil; // ??
	view.rightCalloutAccessoryView = sample;

}

- (void)          mapView: (MKMapView *)mapView
didDeselectAnnotationView: (MKAnnotationView *)view
{

//	view.rightCalloutAccessoryView = [UIButton buttonWithType: UIButtonTypeDetailDisclosure];

	
}

- (MKAnnotationView *)mapView: (MKMapView*)mapView
  		    viewForAnnotation: (id)annotation
{
	
	if ( [annotation isKindOfClass: [CustomAnnotation_Hata class]] ) {
	
		CustomAnnotation_Hata *ca1 = (CustomAnnotation_Hata *)annotation;
		
		MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier: @"CustomAnnotation_Hata"];
		
		if ( annotationView == nil ) {
			
			annotationView = ca1.annotationView;
			
		} else {
			
			annotationView.annotation = annotation;
			
		}
		
		return annotationView;
		
	} else if ( [annotation isKindOfClass: [CustomAnnotation_Photo class]] ) {
		
		CustomAnnotation_Photo *ca2 = (CustomAnnotation_Photo *)annotation;
		
		MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier: @"CustomAnnotation_Photo"];
		
		if ( annotationView == nil ) {
			
			annotationView = ca2.annotationView;
			
		} else {
			
			annotationView.annotation = annotation;
			
		}
		
		return annotationView;
		
	} else if ( [annotation isKindOfClass: [CustomAnnotation_GPS class]] ) {
		
		CustomAnnotation_GPS *ca3 = (CustomAnnotation_GPS *)annotation;
		
		MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier: @"CustomAnnotation_GPS"];
		
		if ( annotationView == nil ) {
			
			annotationView = ca3.annotationView;
			
		} else {
			
			annotationView.annotation = annotation;
			
		}
		
		return annotationView;
		
	} else if ( [annotation isKindOfClass: [CustomAnnotation_GPS_Old class]] ) {
		
		CustomAnnotation_GPS_Old *ca4 = (CustomAnnotation_GPS_Old *)annotation;
		
		MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier: @"CustomAnnotation_GPS_Old"];
		
		if ( annotationView == nil ) {
			
			annotationView = ca4.annotationView;
			
		} else {
			
			annotationView.annotation = annotation;
			
		}
		
		return annotationView;
		
	} else {
		
		return nil;
		
	}
	
}

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
	
//	latitude  = location.coordinate.latitude;
//	longitude = location.coordinate.longitude;
	CLLocationDegrees lat = location.coordinate.latitude;
	CLLocationDegrees lon = location.coordinate.longitude;

	
	if ( )
	[self addAnnotation_GPS];
	
	[self gps_Action];
	
}

- (void)locationManager: (CLLocationManager *)manager
	   didFailWithError: (NSError *)error
{

	
}

- (void)locationManager: (CLLocationManager *)manager
	   didUpdateHeading: (CLHeading *)newHeading
{
	
	heading = newHeading.trueHeading;

	[self gps_Action];
	
}

- (IBAction)button_TokusimaJyou_Action: (id)sender
{
	
	MKCoordinateRegion region;
	region.span   = MKCoordinateSpanMake      ( 0.005, 0.005 );
	region.center = CLLocationCoordinate2DMake( 34.07511029, 134.556 );
	
	[self.mapView setRegion: region
				   animated: YES];
	
}

- (IBAction)button_Ima_Action:(id)sender
{

	MKCoordinateRegion region;
	MKCoordinateSpan span;
	span.latitudeDelta = 0.005;
	span.longitudeDelta = 0.005;
	
	region.span   = span;
	region.center = CLLocationCoordinate2DMake( latitude, longitude );

	[self.mapView setRegion: region
				   animated: YES];
	
}

- (void)gps_Action
{

	NSLog( @"3 coord = (%f,%f)", latitude, longitude );
	
	self.label_1.text = [NSString stringWithFormat: @"coord = (%f,%f)", latitude , longitude];
	
}

- (void)loadAnnotation_Hara
{
	
	array_Hata = [[NSMutableArray alloc] init];
	
	CustomAnnotation_Hata *ca = [[CustomAnnotation_Hata alloc] init];
	
	ca.coordinate = CLLocationCoordinate2DMake( 34.074, 134.556 );
	ca.title       = @"Tokyo Tower";
	ca.subtitle    = @"opening in Dec 1958";
	ca.explanation = @"34.074, 134.556";
	
	[array_Hata addObject: ca];
	
	integer_HaraCount ++;
	
	[self.mapView addAnnotations: array_Hata];
	
}

- (void)loadAnnotation_Photo
{
	
	array_Photo = [[NSMutableArray alloc] init];
	
	CustomAnnotation_Photo *ca = [[CustomAnnotation_Photo alloc] init];
	
	ca.coordinate = CLLocationCoordinate2DMake( 34.076, 134.557 );
	ca.title = @"Tokyo Skytree";
	ca.subtitle = @"opening in May 2012";
	ca.explanation = @"34.076, 134.557";
	
	[array_Photo addObject: ca];
	
	[self.mapView addAnnotations: array_Photo];
	
}

- (void)initAnnotation_GPS
{
	
	array_GPS = [[NSMutableArray alloc] init];

	integer_GPSCount = 0;
	
}

- (void)addAnnotation_GPS
{

	CustomAnnotation_GPS *ca = [[CustomAnnotation_GPS alloc] init];
	
	ca.coordinate = CLLocationCoordinate2DMake( latitude, longitude );// 34.074, 134.554 );
	ca.title = @"Tokyo Tower";
	ca.subtitle = @"opening in Dec 1958";
	ca.explanation = @"34.074, 134.556";
	
	[array_GPS addObject: ca];
	
	[self.mapView addAnnotations: array_GPS];

	integer_GPSCount ++;
	
}

@end
