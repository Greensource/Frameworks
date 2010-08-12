//	GSItemSelector.h
//	Copyright (C) 2010  Pierre DUCHENE
//
//	This program is free software: you can redistribute it and/or modify
//	it under the terms of the GNU General Public License as published by
//	the Free Software Foundation, either version 3 of the License, or
//	(at your option) any later version.
//
//	This program is distributed in the hope that it will be useful,
//	but WITHOUT ANY WARRANTY; without even the implied warranty of
//	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//	GNU General Public License for more details.
//
//	You should have received a copy of the GNU General Public License
//	along with this program.  If not, see <http://www.gnu.org/licenses/>.

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
 *				with many graphics items.
 *				The items are in fact UControl, and so you are responsible for affect to them targets and selectors
 *				The menu may be hide if you need all screen space. In hide mode, user see only a little button to show the menu.
 *				Its is recommanded to hide the menu when and only when user touch an item.
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

/*!
 *	@brief		color property
 *				Change the backgroung color of the menu
 */
@property (assign)	UIColor*	color;

/*!
 *	@brief		borderColor Property
 *				Change the border color of the Menu
 */
@property (assign)	UIColor*	borderColor;

/*!
 *	@brief		selectedItemIndex property
 *				Use this property to select an item,
 *				this action make the corrsponding item highlighted
 */
@property (assign)	NSInteger	selectedItemIndex;

/*!
 *	@brief		Add an item at the end of the menu.
 *	@param		item	The added item.
 */
- (void)addItem:(UIControl*)item;

/*!
 *	@brief		Remove the item gift in parameter from the menu.
 *	@param		item	The removed item
 */
- (void)removeItem:(UIControl*)item;

/*!
 *	@brief		Choose the position of the menu.
 *				For now only LEFT and RIGHT position are allowed
 *	@param		position  The new position for the menu
 */
- (void)setMenuPosition:(ItemSelectorPosition)position;

/*!
 *	@brief		Move the menu out of the screen and show only a little strip
 *				wich enable user to get back the menu.
 *	@param		mustPutAside  YES if the menu must be hide, otherwise NO.
 */
- (void)putAside:(BOOL)mustPutAside;

@end

// TODOLIST
//
// Enable possibility of reorganize item order
// Automatic hidding
// Position TOP and BOTTOM
