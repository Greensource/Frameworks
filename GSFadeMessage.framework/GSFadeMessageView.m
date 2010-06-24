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
// MARK: Accessors
/////////////////////////////////////////////////////////////////////////////
@synthesize fadeDuration = _fadeDuration;


/////////////////////////////////////////////////////////////////////////////
// MARK: -
// MARK: Memory Management
/////////////////////////////////////////////////////////////////////////////

- (id)init {
    if ((self = [super initWithFrame:CGRectMake(VIEW_X, VIEW_Y, VIEW_WIDTH, VIEW_HEIGHT)])) {
		// Self settings
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
		self.layer.cornerRadius = 10.f;
		self.userInteractionEnabled = NO;
		self.hidden = NO;
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
		
		// _title settings
		_title = [[UILabel alloc] initWithFrame:CGRectMake(LABEL_X, 20, LABEL_WIDTH, 50)];
		_title.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		_title.backgroundColor = [UIColor clearColor];
		_title.text = nil;
		_title.textAlignment = UITextAlignmentCenter;
		_title.font = [UIFont boldSystemFontOfSize:40];
		_title.textColor = [UIColor whiteColor];
		[self addSubview:_title];
		
		// _message settigns
		_message = [[UILabel alloc] initWithFrame:CGRectMake(LABEL_X, 68, LABEL_WIDTH, 30)];
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
	
	UIDeviceOrientation currentOrientation = [[UIDevice currentDevice] orientation];
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
#define FONT_SIZE_MAX_TITLE	40
#define FONT_SIZE_MIN_TITLE	20
- (void)setTitle:(NSString*)title
{
	CGSize titleSizeMax = [title sizeWithFont:[UIFont boldSystemFontOfSize:FONT_SIZE_MAX_TITLE]];
	if (titleSizeMax.width <= LABEL_WIDTH) {
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
	if (messageSizeMax.width <= LABEL_WIDTH) {
		_message.font = [UIFont boldSystemFontOfSize:FONT_SIZE_MAX_MESSAGE];
	}
	else {
		_message.font = [UIFont boldSystemFontOfSize:FONT_SIZE_MIN_MESSAGE];
	}
	_message.text = message;
}

- (void)display
{
	[self removeFromSuperview];
	self.layer.opacity = 1;
	[[[UIApplication sharedApplication] keyWindow] addSubview:self]; 
}

- (void)fade
{
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:_fadeDuration];
	self.layer.opacity = 0;
	[UIView commitAnimations];
}

@end
