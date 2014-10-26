//
//  NTViewController.h
//  test12
//
//  Created by 寺内 信夫 on 2013/04/10.
//  Copyright (c) 2013年 寺内 信夫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "DrawView.h"
#import "PenStyleDataSource.h"
#import "PenColorDataSource.h"
#import "PenColorStyleDataSource.h"
#import "NTOptionDataSource.h"

@interface NTViewController : UIViewController
{
	
	NSMutableArray *yuruArray;
	NSMutableArray *frameArray;
	
	//UIImageView *selectView;
	//UILabel *selectLabel;
	
	UIImageView *targetView;
	BOOL targetShow;
	
	CGFloat factor;
	BOOL factorFlag;
	
	CGFloat rotation;
	BOOL rotationFlag;
	
	CGAffineTransform targetTransfrom;

	//UIView *previewView;
	
	AVCaptureStillImageOutput *stillImageOutput;

	DrawView *drawView; // (2)
	
	UIView *colorChooseView; // (4)
	PenColorDataSource *penColorDataSource;
	
	UIView *styleChooseView; // (5)	
	PenStyleDataSource *penStyleDataSource;

	UIView *penColorStyleChooseView;
	PenColorStyleDataSource *penColorStyleDataSource;
	
	NTOptionDataSource *optionDataSource;

	BOOL frontCamera;
	
}

- (IBAction)doTap:(id)sender;
- (IBAction)doPan:(id)sender;
- (IBAction)doRotate:(id)sender;
- (IBAction)doPinch:(id)sender;

- (IBAction)seqObjects:(id)sender;
- (IBAction)takePhotoAction:(id)sender;
- (IBAction)clearAction:(id)sender;
- (IBAction)chooseColorAction:(id)sender;
- (IBAction)choosePenStyleAction:(id)sender;
- (IBAction)choosePenColorStyleAction:(id)sender;

- (void)setSelected;

@property (weak, nonatomic) IBOutlet UIView *previewView;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UIButton *optionButton;
@property (weak, nonatomic) IBOutlet UITableView *optionTable;

- (IBAction)pushOption:(id)sender;

@end
