//
//  NTViewController.m
//  test12
//
//  Created by 寺内 信夫 on 2013/04/10.
//  Copyright (c) 2013年 寺内 信夫. All rights reserved.
//

#import "NTViewController.h"

#import "CGUtil.h"
#import "NTAppDelegate.h"

@interface NTViewController (Private)

- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition)position;

- (AVCaptureConnection *)connectionWithMediaType:(NSString *)mediaType fromConnection:(NSArray *)connections;

@end

#define ORIENTATION [[UIDevice currentDevice] orientation]

@implementation NTViewController

- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition)position
{

	NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
	
	for (AVCaptureDevice *device in devices) {
		
		if ([device position] == position) return device;
		
	}
	
	return nil;
	
}

- (AVCaptureConnection *)connectionWithMediaType:(NSString *)mediaType fromConnection:(NSArray *)connections
{
	
	for (AVCaptureConnection *connection in connections) {
		
		for (AVCaptureInputPort *port in [connection inputPorts]) {
			
			if ([[port mediaType] isEqual:mediaType]) return connection;
			
		}
	}
	
	return nil;
	
}

- (void)viewDidLoad
{
	
    [super viewDidLoad];

	targetTransfrom = CGAffineTransformIdentity;

	[self yuruInit];

	targetView = nil;
	targetShow = NO;

	AVCaptureDevice *camera = [self cameraWithPosition:AVCaptureDevicePositionBack];//[self cameraWithPosition:AVCaptureDevicePositionFront];
	
	if (camera == nil) {
		
		camera = [self cameraWithPosition:AVCaptureDevicePositionBack];
		frontCamera = NO;
		
	} else {
		
		frontCamera = YES;
		
	}
	
	NSError *error = nil;
	AVCaptureDeviceInput *videoInput = [[AVCaptureDeviceInput alloc] initWithDevice:camera
																			  error:&error];
	
	stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
	
	AVCaptureSession *session = [[AVCaptureSession alloc] init];
	[session addInput:videoInput];
	[session addOutput:stillImageOutput];
	
	AVCaptureVideoPreviewLayer *captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
	[captureVideoPreviewLayer setFrame:CGRectMake(0, 0, _previewView.frame.size.width, _previewView.frame.size.height)];
	[captureVideoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
	
	CALayer *videoLayer = _previewView.layer;
	[videoLayer setMasksToBounds:YES];
	[videoLayer addSublayer:captureVideoPreviewLayer];
	
	drawView = [[DrawView alloc]initWithFrame:CGRectMake(0,0,CGRectGetWidth(_previewView.frame), CGRectGetHeight(_previewView.frame))];
	
	[_previewView addSubview:drawView];
	
	penColorDataSource = [[PenColorDataSource alloc]initWithDrawView:drawView];

	penStyleDataSource = [[PenStyleDataSource alloc]initWithDrawView:drawView];

	penColorStyleDataSource = [[PenColorStyleDataSource alloc]initWithDrawView:drawView];

	optionDataSource = [[NTOptionDataSource alloc] init];
	
	_optionTable.delegate = optionDataSource;
	_optionTable.dataSource = optionDataSource;
	
	[session startRunning];

	[_previewView bringSubviewToFront:_button];
	[_previewView bringSubviewToFront:_optionButton];
	[_previewView bringSubviewToFront:_optionTable];
		
}

- (void)yuruInit
{
	
	frameArray = [[NSMutableArray alloc] init];
	{
		UIImageView *frameView;
		
		UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
		
		if (UIInterfaceOrientationIsPortrait(orientation) == YES) {
			
			frameView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 378, 320, 90)];
			{
				frameView.userInteractionEnabled = YES;
				//frameView.contentMode = UIViewContentModeBottom;
				//frameView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
				
				frameView.image = [UIImage imageNamed:@"FrameBakTokushima01"];
				
				//[self.view addSubview:frameView];
				
				[frameArray addObject:frameView];
			}
			
		} else if (UIInterfaceOrientationIsLandscape(orientation) == YES) {
			
			frameView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 378, 320, 90)];
			{
				frameView.userInteractionEnabled = YES;
				//frameView.contentMode = UIViewContentModeBottom;
				//frameView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
				
				frameView.image = [UIImage imageNamed:@"FrameBakTokushima01"];
				
				//[self.view addSubview:frameView];
				
				[frameArray addObject:frameView];
			}
			
		}
		
		UIImage *image = [UIImage imageNamed:@"FrameNameTokushima01"];
		frameView = [[UIImageView alloc] initWithImage:image];
		{
			frameView.userInteractionEnabled = YES;
			frameView.contentMode = UIViewContentModeBottom;
			
			//[self.view addSubview:frameView];
			
			[frameArray addObject:frameView];
		}
	}
	
	yuruArray = [[NSMutableArray alloc] init];
	{
		UIImage *image = [UIImage imageNamed:@"YuruSudachi01"];
		UIImageView *yuruView = [[UIImageView alloc] initWithImage:image];
		{
			yuruView.userInteractionEnabled = YES;
			
			//[self.view addSubview:yuruView];
			
			[yuruArray addObject:yuruView];
		}
		
		image = [UIImage imageNamed:@"YuruSudachi02"];
		yuruView = [[UIImageView alloc] initWithImage:image];
		{
			yuruView.userInteractionEnabled = YES;
			
			//[self.view addSubview:yuruView];
			
			[yuruArray addObject:yuruView];
		}
	}
		
}

/*- (IBAction)takePhotoAction:(id)sender
{

	AVCaptureConnection *videoConnection = [self connectionWithMediaType:AVMediaTypeVideo
														  fromConnection:[stillImageOutput connections]];
	
	[stillImageOutput captureStillImageAsynchronouslyFromConnection:videoConnection
												  completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error)
	 {
	
		 if (imageDataSampleBuffer != nil) {
			 
			 NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
			 
			 UIImage *image = [[UIImage alloc] initWithData:imageData];
			 
			 CGImageRef cgImage = [
													
												  }];
	
}*/

// 落書き画面と撮影画面を合成して保存
-(IBAction)takePhotoAction:(id)sender
{
	
	// ビデオ入力のAVCaptureConnectionを取得
	AVCaptureConnection *videoConnection = [self connectionWithMediaType:AVMediaTypeVideo
														  fromConnection:[stillImageOutput connections]];
	
	// ビデオ入力から画像を非同期で取得。ブロックで定義されている処理が呼び出され、画像データが引数から取得する
	[stillImageOutput captureStillImageAsynchronouslyFromConnection:videoConnection
												  completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error)
	 {
		 
		 if (imageDataSampleBuffer != NULL) {
			 
			 // 入力された画像データからJPEGフォーマットとしてデータを取得
			 NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
			 
			 // JPEGデータからUIImageを作成
			 UIImage *image = [[UIImage alloc] initWithData:imageData];
			 
			 // 落書き画像とビデオ入力の画像を重ね合わせする
			 // ビデオ入力は横向きなので、90度回転
			 CGImageRef cgImage = [CGUtil rotateImage:[image CGImage] mirrored:frontCamera];
			 // CGBitmapContextを作成
			 CGContextRef context = [CGUtil newBitmapContextFromCGImage:cgImage];
			 
			 CGContextDrawImage(context, CGRectMake(0, 0, CGImageGetWidth(cgImage), CGImageGetHeight(cgImage)), drawView.cgYuruImage);
			 
			 CGContextDrawImage(context, CGRectMake(100, 100, 200, 200), [drawView cgYuruChildImage:0]);
			 CGContextDrawImage(context, CGRectMake(0, 0, 200, 200), [drawView cgYuruChildImage:1]);
			 CGContextDrawImage(context, CGRectMake(300, 300, 200, 200), [drawView cgYuruChildImage:2]);
			 
			 // 落書き画像をビデオ入力から作成した画像の上に描画
			 CGContextDrawImage(context, CGRectMake(0, 0, CGImageGetWidth(cgImage), CGImageGetHeight(cgImage)), drawView.cgImage);
			 
			 CGImageRef drawedImage = CGBitmapContextCreateImage(context);
			 
			 CGContextRelease(context);
			 // 合成された画像からUIImageを作成
			 UIImage *newImage = [UIImage imageWithCGImage:drawedImage];
			 CGImageRelease(drawedImage);
			 
			 // iPhoneのアルバムに画像を保存
			 UIImageWriteToSavedPhotosAlbum(newImage,self,//nil,nil);
											@selector(savingImageIsFinished:didFinishSavingWithError:contextInfo:), nil);

		 }
		 
	 }];
	
}

// 完了を知らせる
- (void) savingImageIsFinished:(UIImage *)_image didFinishSavingWithError:(NSError *)_error contextInfo:(void *)_contextInfo
{
 	 
    if (_error) {
		
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"エラー"
														message:@"画像の保存に失敗しました。"
													   delegate:nil
											  cancelButtonTitle:nil
											  otherButtonTitles:@"OK", nil
							  ];
		
        [alert show];
		
    }
	
}

// 落書きを消去
/*-(IBAction)clearAction:(id)sender
{
	
	[drawView clearDrawing];
	
	[drawView setNeedsDisplay];
	
}

- (IBAction)chooseColorAction:(id)sender
{

	if (colorChooseView == nil) {

		colorChooseView = [[UIView alloc]initWithFrame:CGRectMake(0,240,320, 240)];
		colorChooseView.backgroundColor = [UIColor whiteColor];
		
		UIPickerView *pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0,40,320,200)];
		
		pickerView.showsSelectionIndicator = YES;
		
		pickerView.dataSource = penColorDataSource;
		
		pickerView.delegate = penColorDataSource;
		[colorChooseView addSubview:pickerView];
		
		UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0,0,320,44)];
		UIBarButtonItem *closeButton = [[UIBarButtonItem alloc]initWithTitle:@"閉じる" style:UIBarButtonItemStyleBordered target:self action:@selector(disappearColorChooseView:)];
		
		UIBarButtonItem *flex = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
		
		[toolBar setItems:[NSArray arrayWithObjects:flex,closeButton,nil]];

		[colorChooseView addSubview:toolBar];

	}
	
	[self.view addSubview:colorChooseView];
	[self.view bringSubviewToFront:colorChooseView];

}

// 閉じるボタンを押したときに呼び出されるメソッド
- (void)disappearColorChooseView:(id)sender
{

	// Viewを画面から削除
	[colorChooseView removeFromSuperview];

}

// ペンの太さ選択肢を表示
-(IBAction)choosePenStyleAction:(id)sender
{

	if (styleChooseView == nil) {
		// 選択肢のViewを作成
		styleChooseView = [[UIView alloc]initWithFrame:CGRectMake(0,240,320, 240)];
		styleChooseView.backgroundColor = [UIColor whiteColor];
		// UIPickerViewを作成
		UIPickerView *pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0,40,320,200)];
		pickerView.showsSelectionIndicator = TRUE;
		// DataSourceは、PenStyleDataSourceのインスタンス
		pickerView.dataSource = penStyleDataSource;
		// Delegateは、PenStyleDataSourceのインスタンス
		pickerView.delegate = penStyleDataSource;
		[styleChooseView addSubview:pickerView];

		// 選択肢のViewの上部にツールバーを配置し、閉じるボタンを配置
		UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0,0,320,44)];
		UIBarButtonItem *closeButton = [[UIBarButtonItem alloc]initWithTitle:@"閉じる" style:UIBarButtonItemStyleBordered target:self action:@selector(disappearStyleChooseView:)];
		// 余白表示用のボタン
		UIBarButtonItem *flex = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
		// 閉じるボタンはツールバーの右端に配置する
		[toolBar setItems:[NSArray arrayWithObjects:flex,closeButton,nil]];

		[styleChooseView addSubview:toolBar];

	}

	[penStyleDataSource setPenColor:[drawView penColor]];
	
	[self.view addSubview:styleChooseView];
	[self.view bringSubviewToFront:styleChooseView];

}

// 閉じるボタンを押したときに呼び出されるメソッド
- (void)disappearStyleChooseView:(id)sender
{

	[styleChooseView removeFromSuperview];

}

- (IBAction)choosePenColorStyleAction:(id)sender
{
	
	if (penColorStyleChooseView == nil) {
		
		penColorStyleChooseView = [[UIView alloc]initWithFrame:CGRectMake(0,240,320, 240)];
		penColorStyleChooseView.backgroundColor = [UIColor whiteColor];
		
		UIPickerView *pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0,40,320,200)];
		
		pickerView.showsSelectionIndicator = YES;
		
		pickerView.dataSource = penColorStyleDataSource;
		
		pickerView.delegate = penColorStyleDataSource;
		[penColorStyleChooseView addSubview:pickerView];
		
		UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0,0,320,44)];
		UIBarButtonItem *closeButton = [[UIBarButtonItem alloc]initWithTitle:@"閉じる" style:UIBarButtonItemStyleBordered target:self action:@selector(disappearColorStyleChooseView:)];
		
		UIBarButtonItem *flex = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
		
		[toolBar setItems:[NSArray arrayWithObjects:flex,closeButton,nil]];
		
		[penColorStyleChooseView addSubview:toolBar];
		
	}
	
	[self.view addSubview:penColorStyleChooseView];
	[self.view bringSubviewToFront:penColorStyleChooseView];
	
	
}

// 閉じるボタンを押したときに呼び出されるメソッド
- (void)disappearColorStyleChooseView:(id)sender
{
	
	[penColorStyleChooseView removeFromSuperview];
	
}*/

- (BOOL)shouldAutorotate
{
	
    if (ORIENTATION == UIDeviceOrientationPortrait ||
		ORIENTATION == UIDeviceOrientationLandscapeLeft ||
		ORIENTATION == UIDeviceOrientationLandscapeRight ) {
		
        if (ORIENTATION == UIDeviceOrientationPortrait ) {
			
            //縦回転時の処理
			UIImageView *frameView = [frameArray objectAtIndex:0];
			
			frameView.frame = CGRectMake(0, 378, 320, 90);
			
        }else {
			
            //左右回転時の処理
			UIImageView *frameView = [frameArray objectAtIndex:0];
			
			frameView.frame = CGRectMake(0, 170, 480, 130);
        }
		
        return YES;
    }
	
    return NO;
	
}

/*- (NSUInteger)supportedInterfaceOrientations
 {
 
 return UIInterfaceOrientationMaskAllButUpsideDown;
 
 }*/

- (void)didReceiveMemoryWarning
{
	
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
	
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	
	UITouch *tou = touches.anyObject;
	
	if ([[[tou.view class] description] isEqualToString:@"UIImageView"] == YES) {
		
		targetView = (UIImageView*)tou.view;
		
	} else {
		
		targetView = nil;
		
	}
	
}

/*- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
 {
 
 targetTransfrom = targetView.transform;
 
 NSLog(@"targetTransfrom %@", NSStringFromCGAffineTransform(targetTransfrom));
 
 }*/

- (IBAction)doTap:(id)sender
{
	
	//UITapGestureRecognizer *tg = sender;
	
	//CGPoint point = [tg locationInView:self.view];
	
	//NSLog(@"point %@", NSStringFromCGPoint(point));
	
	//selectView.center = targetView.center;
	
	//[self.view bringSubviewToFront:selectView];
	
	//[selectView setHidden:NO];
	
	targetShow = YES;
	
}

- (IBAction)doPan:(id)sender
{
	
	if (targetView == nil || targetShow == NO) return;
	
	UIPanGestureRecognizer *pr = sender;
	
	CGPoint translation = [pr translationInView:self.view];
	
	CGPoint center = targetView.center;
	
	center.x += translation.x;
	center.y += translation.y;
	
	/*selectView.center =*/ targetView.center = center;
	
	[pr setTranslation:CGPointZero inView:self.view];
	
}

- (IBAction)doRotate:(id)sender
{
	
	if (targetView == nil || targetShow == NO) return;
	
	NSLog(@"Rotate");
	
	UIRotationGestureRecognizer *rg = sender;
	
	rotation = rg.rotation;
	rotationFlag = YES;
	
	if (factorFlag == NO) {
		
		targetView.transform = CGAffineTransformMakeRotation (rotation);
		
	} else {
		
		CGAffineTransform transform1 = CGAffineTransformMakeRotation (rotation);
		CGAffineTransform transform2 = CGAffineTransformMakeScale (factor, factor);
		
		targetView.transform = CGAffineTransformConcat (transform1, transform2);
		
	}
	
}

- (IBAction)doPinch:(id)sender
{
	
	if (targetView == nil || targetShow == NO) return;
	
	UIPinchGestureRecognizer *pg = sender;
	
	factor = pg.scale;
	factorFlag = YES;
	
	if (rotationFlag == NO) {
		
		targetView.transform = CGAffineTransformMakeScale (factor, factor);
		
	} else {
		
		CGAffineTransform transform1 = CGAffineTransformMakeRotation (rotation);
		CGAffineTransform transform2 = CGAffineTransformMakeScale (factor, factor);
		
		targetView.transform = CGAffineTransformConcat (transform1, transform2);
		
	}
	
}

- (IBAction)pushOption:(id)sender
{

	UIButton *button = (UIButton*)sender;

	if (_optionTable.hidden == YES) {
	
		[button setTitle:NSLocalizedString(@"buttonOptionClose", nil) forState:UIControlStateNormal];

		_optionTable.hidden = NO;
		
	} else {
		
		[button setTitle:NSLocalizedString(@"buttonOptionOpen", nil) forState:UIControlStateNormal];

		_optionTable.hidden = YES;

	}
	
	/*NTAppDelegate *app = [[UIApplication sharedApplication] delegate];
	CGRect screen = [[UIScreen mainScreen] bounds];
	
	UIViewController *viewCont1 = [[UIViewController alloc] init];
	UIViewController *viewCont2 = [[UIViewController alloc] init];
	UIViewController *viewCont3 = [[UIViewController alloc] init];
	
	app.navigationController = [[UINavigationController alloc] initWithRootViewController:viewCont1];
	
	NSArray *array = [NSArray arrayWithObjects:viewCont1, viewCont2, viewCont3, nil];
	app.navigationController.viewControllers = array;
	
	//app.navigationController.toolbarHidden = NO;
	
	UITableView *optionView = [[UITableView alloc] initWithFrame:CGRectMake(0, 71, screen.size.width, screen.size.height)
														   style:UITableViewStyleGrouped];
	optionDataSource = [[NTOptionDataSource alloc] init];
	
	optionView.dataSource = optionDataSource;
	optionView.delegate = optionDataSource;
	
	[viewCont1.view addSubview:optionView];
	
	[_previewView addSubview:app.navigationController.view];
	
	app.navigationController.view.frame = CGRectMake(0, 71, screen.size.width, screen.size.height - 71);
	app.navigationController.view.hidden = YES;
	
	 //[_previewView bringSubviewToFront:app.navigationController.view];
	
	if (app.navigationController.view.hidden == YES) {

		[button setTitle:NSLocalizedString(@"buttonOptionClose", nil) forState:UIControlStateNormal];

		app.navigationController.view.hidden = NO;
		//_optionTable.hidden = NO;
		
	} else {
		
		[button setTitle:NSLocalizedString(@"buttonOptionOpen", nil) forState:UIControlStateNormal];
		
		NTAppDelegate *app = [[UIApplication sharedApplication] delegate];
		
		app.navigationController.view.hidden = YES;
		//_optionTable.hidden = YES;
		
	}*/


}

@end
