//
//  GSFadeMessageViewController.h
//  Framework_WaitingView
//
//  Created by Pierre DUCHENE on 23/06/10.
//  Copyright 2010 CapGemini. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GSFadeMessageView;

@interface GSFadeMessageViewController : UIViewController {
	
	GSFadeMessageView*	_messageView;
	NSInteger			_fadeDuration;

}

@property (assign) NSInteger fadeDuration;

- (void)setTitle:(NSString*)title;
- (void)setMessage:(NSString*)message;
- (void)fadeWithTimeInterval:(NSInteger)seconds;


@end
