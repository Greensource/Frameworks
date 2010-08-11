//
//  GSFadeMessageView.h
//  
//
//  Created by Pierre DUCHENE on 22/06/10.
//  Copyright 2010 Greensource. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GSFadeMessageView : UIView {
	
	UILabel		*_title;
	UILabel		*_message;
	NSInteger	_fadeDuration;
}

@property (assign) NSInteger fadeDuration;

+(id)fadeMessageWithTitle:(NSString*)title message:(NSString*)message duration:(NSInteger)duration;

- (void)show;
- (void)setTitle:(NSString*)title;
- (void)setMessage:(NSString*)message;
- (void)dismiss;

@end
