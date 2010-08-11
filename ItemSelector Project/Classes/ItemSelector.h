//
//  ItemSelector.h
//  ItemSelector
//
//  Created by Pierre DUCHENE on 08/06/10.
//  Copyright 2010 CapGemini. All rights reserved.
//

#import <UIKit/UIKit.h>

// MARK: Define
#define ITEM_SELECTOR_COLOR [UIColor colorWithRed:0.85 green:0.9 blue:0.9 alpha:1]

// MARK: Structures
typedef enum {
	LEFT,
	RIGHT
} ItemSelectorPosition;

@interface ItemSelector : UIView <UIScrollViewDelegate> {
	
	UIControl*				_overflowMin;
	UIControl*				_overflowMax;
	UIScrollView*			_scrollView;
	ItemSelectorPosition	_position;		// TODO: A implementer, for now, just righ position
}

@property (readonly) UIControl*		overflowMin;
@property (readonly) UIControl*		overflowMax;

- (void)addItem:(UIControl*)item;

- (void)removeItem:(UIControl*)item;

@end
