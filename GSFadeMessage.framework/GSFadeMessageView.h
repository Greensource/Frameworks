//
//  GSFadeMessageView.h
//  
//
//  Created by Pierre DUCHENE on 22/06/10.
//  Copyright 2010 Greensource. All rights reserved.
//

#import <UIKit/UIKit.h>

#define VIEW_WIDTH		300
#define VIEW_HEIGHT		120
#define VIEW_X			((320-VIEW_WIDTH)/2)
#define VIEW_Y			((460-VIEW_HEIGHT)/2)
#define LABEL_WIDTH		(VIEW_WIDTH-20)
#define LABEL_X			((VIEW_WIDTH-LABEL_WIDTH)/2)

@interface GSFadeMessageView : UIView {
	
	UILabel		*_title;
	UILabel		*_message;
	NSInteger	_fadeDuration;
}

@property (assign) NSInteger fadeDuration;

- (void)display;
- (void)setTitle:(NSString*)title;
- (void)setMessage:(NSString*)message;
- (void)fade;

@end
