//
//  AppDelegate.h
//  PhotoWake
//
//  Created by 寺内 信夫 on 2014/10/24.
//  Copyright (c) 2014年 寺内 信夫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder < UIApplicationDelegate >
{
	
@private
		
//	NSInteger integer_HaraCount;
//	NSInteger integer_PhotoCount;
//	NSInteger integer_GPSCount;
//	NSInteger integer_GPSOldCount;
//	
//	NSMutableArray *array_Hata;
//	NSMutableArray *array_Photo;
//	NSMutableArray *array_GPS;
//	NSMutableArray *array_GPSOld;
	
}

@property (strong, nonatomic) UIWindow *window;

//@property NSInteger integer_HaraCount;
//@property NSInteger integer_PhotoCount;
//@property NSInteger integer_GPSCount;
//@property NSInteger integer_GPSOldCount;

@property NSMutableArray *array_Hata;
@property NSMutableArray *array_Photo;
@property NSMutableArray *array_Photo_Add;
@property NSMutableArray *array_GPS;
@property NSMutableArray *array_GPSOld;
@property NSMutableArray *array_GPSOld_Add;

@end

