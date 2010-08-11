//
//  ItemSelector.h
//  ItemSelector
//
//  Created by Pierre DUCHENE on 08/06/10.
//  Copyright 2010 CapGemini. All rights reserved.
//

#import <UIKit/UIKit.h>

// MARK: Define
#define ITEM_SELECTOR_COLOR_DEFAULT [UIColor whiteColor]

// MARK: Structures
typedef enum {
	LEFT,
	RIGHT
} ItemSelectorPosition;

/*!
 *	@class		ItemSelector
 *	@brief		The ItemSelector Class is a view that display a scrolling menu
 *				with many graphics item.
 *	@author		Pierre DUCHENE
 */
@interface GSItemSelector : UIView {
	
	// Properties
	UIView					*_menuView;
	UIControl				*_overflowMin;
	UIControl				*_overflowMax;
	UIScrollView			*_scrollView;
	NSInteger				_selectedItemIndex;
	UIControl				*_drillButton;
	
	// Settings
	ItemSelectorPosition	_position;
	UIColor					*_color;
	UIColor					*_borderColor;
	
}

@property (assign)	UIColor*	color;
@property (assign)	UIColor*	borderColor;
@property (assign)	NSInteger	selectedItemIndex;

- (void)addItem:(UIControl*)item;

- (void)removeItem:(UIControl*)item;

- (void)setMenuPosition:(ItemSelectorPosition)position;

- (void)putAside:(BOOL)mustPutAside;

@end

