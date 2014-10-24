//
//  MapViewController.m
//  MapEditor
//
//  Created by ビザンコムマック０９ on 2014/10/23.
//  Copyright (c) 2014年 ビザンコムマック０９. All rights reserved.
//

#import "MapViewController.h"

#import "CustomAnnotation1.h"
#import "CustomAnnotation2.h"

@interface MapViewController ()

@end

@implementation MapViewController

- (void)viewDidLoad
{
	
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	self.mapView.delegate = self;
	
	self.mapView.showsUserLocation = YES;
	self.mapView.mapType = MKMapTypeHybrid;
	
	MKCoordinateRegion region;
	MKCoordinateSpan span;
	span.latitudeDelta = 0.005;
	span.longitudeDelta = 0.005;
	
	CLLocationCoordinate2D location;
	location.latitude = 34.07511029;
	location.longitude = 134.556;//55709219;
	
	region.span   = span;
	region.center = location;
	
	[self.mapView setRegion: region
				   animated: YES];
	
	CustomAnnotation1 *tt1 = [[CustomAnnotation1 alloc] init];
	
	tt1.coordinate = CLLocationCoordinate2DMake( 34.074, 134.556 );
	tt1.title       = @"Tokyo Tower";
	tt1.subtitle    = @"opening in Dec 1958";
	tt1.explanation = @"34.074, 134.556";
	
	// Tokyo Skytree
	CustomAnnotation1 *st1 = [[CustomAnnotation1 alloc] init];
	
	st1.coordinate = CLLocationCoordinate2DMake( 34.076, 134.557 );
	st1.title = @"Tokyo Skytree";
	st1.subtitle = @"opening in May 2012";
	st1.explanation = @"34.076, 134.557";
	
	// add annotations to map
	[self.mapView addAnnotations: @[tt1, st1]];
	
	
	CustomAnnotation2 *tt2 = [[CustomAnnotation2 alloc] init];
	
	tt2.coordinate = CLLocationCoordinate2DMake( 34.074, 134.554 );
	tt2.title = @"Tokyo Tower";
	tt2.subtitle = @"opening in Dec 1958";
	tt2.explanation = @"34.074, 134.556";
	
	// Tokyo Skytree
	CustomAnnotation2 *st2 = [[CustomAnnotation2 alloc] init];
	
	st2.coordinate = CLLocationCoordinate2DMake( 34.076, 134.552 );
	st2.title = @"Tokyo Skytree";
	st2.subtitle = @"opening in May 2012";
	st2.explanation = @"34.076, 134.557";
	
	// add annotations to map
	[self.mapView addAnnotations: @[tt2, st2]];
	
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

-(MKAnnotationView *)mapView: (MKMapView*)mapView
		   viewForAnnotation: (id)annotation
{
	
	if ( [annotation isKindOfClass: [CustomAnnotation1 class]] ) {
	
		CustomAnnotation1 *ca1 = (CustomAnnotation1 *)annotation;
		
		MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier: @"CustomAnnotation1"];
		
		if ( annotationView == nil ) {
			
			annotationView = ca1.annotationView;
			
		} else {
			
			annotationView.annotation = annotation;
			
		}
		
		return annotationView;
		
	} else if ( [annotation isKindOfClass: [CustomAnnotation2 class]] ) {
		
		CustomAnnotation2 *ca2 = (CustomAnnotation2 *)annotation;
		
		MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier: @"CustomAnnotation2"];
		
		if ( annotationView == nil ) {
			
			annotationView = ca2.annotationView;
			
		} else {
			
			annotationView.annotation = annotation;
			
		}
		
		return annotationView;
		
	} else {
		
		return nil;
		
	}
	
////	static NSString *PinIdentifier = @"Pin";
////	
////	MKAnnotationView *av = (MKAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier: PinIdentifier];
////	
////	if ( av == nil ) {
////		
////		av = [[MKAnnotationView alloc] initWithAnnotation: annotation
////										  reuseIdentifier: PinIdentifier];
////		
////		av.image = [UIImage imageNamed: @"maps.png"];  // アノテーションの画像を指定する
////		av.canShowCallout = YES;  // ピンタップ時にコールアウトを表示する
////	
////	}
////	
////	return av;
	
}

- (IBAction)button_TokusimaJyou_Action: (id)sender
{
	
	MKCoordinateRegion region;
	MKCoordinateSpan span;
	span.latitudeDelta = 0.005;
	span.longitudeDelta = 0.005;
	
	CLLocationCoordinate2D location;
	location.latitude = 34.07511029;
	location.longitude = 134.556;//55709219;
	
	region.span = span;
	region.center = location;
	
	[self.mapView setRegion: region animated: YES];
	
}

- (IBAction)button_bb1_Action: (id)sender
{

//	[[self presentingViewController] dismissModalViewControllerAnimated:YES];
//	[self ]
}

@end
