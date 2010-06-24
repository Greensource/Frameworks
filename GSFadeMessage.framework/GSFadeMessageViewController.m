    //
//  GSFadeMessageViewController.m
//  Framework_WaitingView
//
//  Created by Pierre DUCHENE on 23/06/10.
//  Copyright 2010 CapGemini. All rights reserved.
//

#import "GSFadeMessageViewController.h"
#import "GSFadeMessageView.h"
#import <QuartzCore/QuartzCore.h>


@implementation GSFadeMessageViewController


/////////////////////////////////////////////////////////////////////////////
// MARK: -
// MARK: Accessors
/////////////////////////////////////////////////////////////////////////////
@synthesize fadeDuration = _fadeDuration;
- (void)setFadeDuration:(NSInteger)seconds
{
	_messageView.fadeDuration = seconds;
}

/////////////////////////////////////////////////////////////////////////////
// MARK: -
// MARK: Memory Management
/////////////////////////////////////////////////////////////////////////////
- (void)viewDidUnload {
    [super viewDidUnload];
    
	[_messageView release]; _messageView = nil;
}


/////////////////////////////////////////////////////////////////////////////
// MARK: -
// MARK: UIViewController methods
/////////////////////////////////////////////////////////////////////////////

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	self.view = [UIView new];
	self.view.frame = CGRectMake(0, 0, 320, 480);
	self.view.backgroundColor = [UIColor clearColor];
	self.view.userInteractionEnabled = NO;
	
	_messageView = [GSFadeMessageView new];
	[self.view addSubview:_messageView];
	
	self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
	[self setFadeDuration:3];
	[self fadeWithTimeInterval:1];
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

/////////////////////////////////////////////////////////////////////////////
// MARK: -
// MARK: GSFadeMessage methods
/////////////////////////////////////////////////////////////////////////////
- (void)setTitle:(NSString*)title
{
	[_messageView setTitle:title];
}

- (void)setMessage:(NSString*)message
{
	[_messageView setMessage:message];
}
- (void)fadeWithTimeInterval:(NSInteger)seconds
{
	[_messageView performSelector:@selector(fade) withObject:nil afterDelay:seconds];
}
@end
