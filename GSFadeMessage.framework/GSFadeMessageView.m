//
//  GSFadeMessageView.m
//  
//
//  Created by Pierre DUCHENE on 22/06/10.
//  Copyright 2010 Greensource. All rights reserved.
//

#import "GSFadeMessageView.h"
#import <QuartzCore/QuartzCore.h>

@implementation GSFadeMessageView


/////////////////////////////////////////////////////////////////////////////
// MARK: -
// MARK: Constants
/////////////////////////////////////////////////////////////////////////////
const float kWidth_landscape = 400;
const float kWidth_portrait = 300;
const float kHeight = 120;

/////////////////////////////////////////////////////////////////////////////
// MARK: -
// MARK: Accessors
/////////////////////////////////////////////////////////////////////////////
@synthesize fadeDuration = _fadeDuration;


/////////////////////////////////////////////////////////////////////////////
// MARK: -
// MARK: Memory Management
/////////////////////////////////////////////////////////////////////////////

- (id)init {
	UIDeviceOrientation currentOrientation = [[UIDevice currentDevice] orientation];
	
	
	CGFloat viewWidth = 0.f;
	CGFloat viewHeight = 0.f;
	CGFloat viewX = 0.f;
	CGFloat viewY = 0.f;
	CGFloat labelWidth = 0.f;
	CGRect screenFrame = [[UIScreen mainScreen] bounds];
	
	// set frame properties
	switch (currentOrientation) {
		case UIDeviceOrientationLandscapeRight:
		case UIDeviceOrientationLandscapeLeft:
			viewWidth = kWidth_landscape;
			viewHeight = kHeight;
			break;
		case UIDeviceOrientationPortrait:
		case UIDeviceOrientationPortraitUpsideDown:
			viewWidth = kWidth_portrait;
			viewHeight = kHeight;
			break;
		default:
			viewWidth = kWidth_portrait;
			viewHeight = kHeight;
			break;
	}

	viewX = (screenFrame.size.width - viewWidth) / 2;
	viewY = (screenFrame.size.height - viewHeight) / 2;
	labelWidth = viewWidth-20;
	
    if ((self = [super initWithFrame:CGRectMake(viewX, viewY, viewWidth, viewHeight)])) {
		// Self settings
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
		self.layer.cornerRadius = 10.f;
		self.userInteractionEnabled = YES;
		self.hidden = NO;
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
		
		// _title settings
		_title = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, labelWidth, 50)];
		_title.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		_title.backgroundColor = [UIColor clearColor];
		_title.text = nil;
		_title.textAlignment = UITextAlignmentCenter;
		_title.font = [UIFont boldSystemFontOfSize:40];
		_title.textColor = [UIColor whiteColor];
		[self addSubview:_title];
		
		// _message settigns
		_message = [[UILabel alloc] initWithFrame:CGRectMake(10, 68, labelWidth, 30)];
		_message.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		_message.backgroundColor = [UIColor clearColor];
		_message.text = nil;
		_message.textAlignment = UITextAlignmentCenter;
		_message.font = [UIFont boldSystemFontOfSize:20];
		_message.textColor = [UIColor whiteColor];
		[self addSubview:_message];
		
		// _fadeDuration init
		_fadeDuration = 2;
    }
	
	
	switch (currentOrientation) {
		case UIDeviceOrientationLandscapeRight:
			self.transform = CGAffineTransformRotate(self.transform, 3*M_PI/2);
			break;
		case UIDeviceOrientationLandscapeLeft:
			self.transform = CGAffineTransformRotate(self.transform, M_PI/2);
			break;
		case UIDeviceOrientationPortraitUpsideDown:
			self.transform = CGAffineTransformRotate(self.transform, M_PI);
			break;
		default:
			break;
	}
	
    return self;
}

- (void)dealloc {
	
	[_title release]; _title = nil;
	[_message release]; _message = nil;
	
    [super dealloc];
}


/////////////////////////////////////////////////////////////////////////////
// MARK: -
// MARK: UIView methods
/////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////
// MARK: -
// MARK: GSFadeMessage methods
/////////////////////////////////////////////////////////////////////////////
+(id)fadeMessageWithTitle:(NSString*)title message:(NSString*)message duration:(NSInteger)duration
{
	id fadeMessage = [[GSFadeMessageView new] autorelease];
	[fadeMessage setTitle:title];
	[fadeMessage setMessage:message];
	if (duration > 0) {
		[fadeMessage setFadeDuration:duration];
	}
	
	[fadeMessage show];
	[fadeMessage dismiss];
	
	return fadeMessage;
}

#define FONT_SIZE_MAX_TITLE	40
#define FONT_SIZE_MIN_TITLE	20
- (void)setTitle:(NSString*)title
{
	CGSize titleSizeMax = [title sizeWithFont:[UIFont boldSystemFontOfSize:FONT_SIZE_MAX_TITLE]];
	if (titleSizeMax.width <= _title.frame.size.width) {
		_title.font = [UIFont boldSystemFontOfSize:FONT_SIZE_MAX_TITLE];
	}
	else {
		_title.font = [UIFont boldSystemFontOfSize:FONT_SIZE_MIN_TITLE];
	}
	_title.text = title;
}

#define FONT_SIZE_MAX_MESSAGE	20
#define FONT_SIZE_MIN_MESSAGE	10
- (void)setMessage:(NSString*)message
{
	CGSize messageSizeMax = [message sizeWithFont:[UIFont boldSystemFontOfSize:FONT_SIZE_MAX_MESSAGE]];
	if (messageSizeMax.width <= _message.frame.size.width) {
		_message.font = [UIFont boldSystemFontOfSize:FONT_SIZE_MAX_MESSAGE];
	}
	else {
		_message.font = [UIFont boldSystemFontOfSize:FONT_SIZE_MIN_MESSAGE];
	}
	_message.text = message;
}

- (void)show
{
	[self removeFromSuperview];
	self.layer.opacity = 1;
	UIWindow *window = [[UIApplication sharedApplication] keyWindow];
	[window addSubview:self];
	[window bringSubviewToFront:self];
}

- (void)dismiss
{
	[UIView animateWithDuration:_fadeDuration animations:^{
		self.layer.opacity = 0;
	}];
}	

@end
