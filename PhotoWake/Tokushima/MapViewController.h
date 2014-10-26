//
//  MapViewController.h
//  MapEditor
//
//  Created by ビザンコムマック０９ on 2014/10/23.
//  Copyright (c) 2014年 ビザンコムマック０９. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MapViewController : UIViewController < MKMapViewDelegate, CLLocationManagerDelegate >
{
	
	CLLocationManager *locationManager;
	
	CLLocationCoordinate2D coordinate; // 現在の緯度経度
	
}

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
//@property (weak, nonatomic) CLLocationManager *locationManager;

@property (weak, nonatomic) IBOutlet UIButton *button_TokusimaJyou;
@property (weak, nonatomic) IBOutlet UIButton *button_bb1;
@property (weak, nonatomic) IBOutlet UIButton *button_Ima;

@property (weak, nonatomic) IBOutlet UILabel *label_1;
@property (weak, nonatomic) IBOutlet UILabel *label_2;

@end
