//	GSItemSelector.m
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

#import "GSItemSelector.h"
#import <QuartzCore/CALayer.h>

@implementation GSItemSelector


/////////////////////////////////////////////////////////////////////////////
// MARK: -
// MARK: Constants
/////////////////////////////////////////////////////////////////////////////
const float selector_width = 60.f;
const float selector_height = 320.f;
const float scroll_offset = 25.f;
const float overflowView_height = 40.f;
const float item_side_size = 50.f;
const float item_offset_size = 20.f;
const float drill_width = 40.f;
const float drill_height = 40.f;
const float selector_x_offset = 30.f;

const float view_width = 60 + 30;
const float	leftPosition = 0.f;
const float rightPosition = 480 - 90;

/////////////////////////////////////////////////////////////////////////////
// MARK: -
// MARK: Memory Management
/////////////////////////////////////////////////////////////////////////////

- (id)init {
    return [self initWithFrame:CGRectMake(rightPosition, 0, selector_width, selector_height)];
}

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:CGRectMake(rightPosition, frame.origin.y, view_width, frame.size.height)])) {
		
		// Some settings
		_position = RIGHT;
		
		float w = selector_width;
		float h = self.frame.size.height;
		
		_selectedItemIndex = NSIntegerMax;
		
		// Self settings
		[self setBackgroundColor:[UIColor clearColor]];
		
		// _menuView settings
		_menuView = [[UIView alloc] initWithFrame:CGRectMake(selector_x_offset, 0, w, h)];
		[_menuView setBackgroundColor:ITEM_SELECTOR_COLOR_DEFAULT];
		_menuView.layer.cornerRadius = 10.f;
		_menuView.layer.borderColor = [ITEM_SELECTOR_COLOR_DEFAULT CGColor];
		_menuView.layer.borderWidth = 1.f;
		_menuView.clipsToBounds = YES;
		_menuView.opaque = NO;
		
		// _scrollView settings
		_scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, scroll_offset, w, (h - 2 * scroll_offset))];
		_scrollView.layer.masksToBounds = YES;
		_scrollView.layer.cornerRadius = 15.;
		_scrollView.backgroundColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.2];
		_scrollView.contentSize = CGSizeMake(w, 0);
		_scrollView.contentOffset = CGPointZero;
		_scrollView.contentInset = UIEdgeInsetsMake(10, 0, 10, 0);
		_scrollView.showsHorizontalScrollIndicator = NO;
		_scrollView.showsVerticalScrollIndicator = NO;
		_scrollView.layer.shadowOpacity = 0.8;
		_scrollView.layer.shadowOffset = CGSizeMake(1, 1);
		_scrollView.layer.shadowColor = [[UIColor blackColor] CGColor];
		
		// _overflowMin settings
		_overflowMin = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, w, overflowView_height)];
		UIImage* minImg = [UIImage imageNamed:@"overflowMin.png"];
		[_overflowMin addSubview:[[[UIImageView alloc] initWithImage:minImg] autorelease]];
		
		// _overflowMax settings
		_overflowMax = [[UIControl alloc] initWithFrame:CGRectMake(0, h - overflowView_height, w, overflowView_height)];
		UIImage* maxImg = [UIImage imageNamed:@"overflowMax.png"];
		[_overflowMax addSubview:[[[UIImageView alloc] initWithImage:maxImg] autorelease]];
		
		// _drillButton settings
		_drillButton = [[UIControl alloc] initWithFrame:CGRectMake(0, 10, drill_width, drill_height)];
		[_drillButton setBackgroundColor:ITEM_SELECTOR_COLOR_DEFAULT];
		_drillButton.layer.cornerRadius = 8.f;
		_drillButton.userInteractionEnabled = NO;
		_drillButton.layer.opacity = 0;
		_drillButton.clipsToBounds = YES;
		[_drillButton addTarget:self action:@selector(show) forControlEvents:UIControlEventTouchDown];
		
		// Create the view hierarchy
		[self addSubview:_menuView];
		[_menuView addSubview:_scrollView];
		[_menuView addSubview:_overflowMin];
		[_menuView addSubview:_overflowMax];
		[self addSubview:_drillButton];
	}
	return self;
}

- (void)dealloc {
	[_overflowMin release]; _overflowMin = nil;
	[_overflowMax release]; _overflowMax = nil;
	[_scrollView release]; _scrollView = nil;
	[_color release]; _color = nil;
	[_borderColor release]; _color = nil;
	
	[super dealloc];
}


/////////////////////////////////////////////////////////////////////////////
// MARK: -
// MARK: Accessors
/////////////////////////////////////////////////////////////////////////////
@synthesize color = _color;
- (void)setColor:(UIColor*)newColor
{
	if (newColor != _color) {
		[_color release];
		_color = [newColor retain];
		
		[_menuView setBackgroundColor:_color];
	}
}

@synthesize borderColor = _borderColor;
- (void)setBorderColor:(UIColor*)newColor
{
	if (newColor != _borderColor) {
		[_borderColor release];
		_borderColor = [newColor retain];
		
		_menuView.layer.borderColor = [_borderColor CGColor];
		[_drillButton setBackgroundColor:_borderColor];
	}
}

@synthesize selectedItemIndex = _selectedItemIndex;
- (void)setSelectedItemIndex:(NSInteger)index
{
	// Remove old border
	if (_selectedItemIndex < [_scrollView.subviews count]) {
		UIView* selectedItem = [_scrollView.subviews objectAtIndex:_selectedItemIndex];
		selectedItem.layer.borderWidth = 1.2f;
	}
	
	// Add the new
	_selectedItemIndex = index;
	if (_selectedItemIndex < [_scrollView.subviews count]) {
		UIView* selectedItem = [_scrollView.subviews objectAtIndex:_selectedItemIndex];
		selectedItem.layer.borderWidth = 2.5f;
	}
}

/////////////////////////////////////////////////////////////////////////////
// MARK: -
// MARK: UIView Methods
/////////////////////////////////////////////////////////////////////////////
- (void)layoutSubviews
{
	NSUInteger i, count = [_scrollView.subviews count];
	for (i = 0; i < count; i++) {
		UIView * view = [_scrollView.subviews objectAtIndex:i];
		[view setFrame:CGRectMake(5, (i*(item_side_size+5)), item_side_size, item_side_size)];
	}
}

/////////////////////////////////////////////////////////////////////////////
// MARK: -
// MARK: ItemSelector Methods
/////////////////////////////////////////////////////////////////////////////
- (void)addItem:(UIControl*)item
{
	item.layer.masksToBounds = YES;
	item.layer.cornerRadius = 10.;
	item.layer.borderColor = [[UIColor whiteColor] CGColor];
	item.layer.borderWidth = 1.2f;
	
	[_scrollView addSubview:item];
	float newHeight = ([_scrollView.subviews count]*item_side_size + item_offset_size);
	
	float h = self.frame.size.height;
	if (newHeight <= (h - 2 * scroll_offset)) {
		newHeight = (h - 2 * scroll_offset) + 1;
	}
	[_scrollView setContentSize:CGSizeMake(selector_width, newHeight)];
}

- (void)removeItem:(UIControl*)item
{
	float newHeight = (_scrollView.contentSize.height - item_side_size - item_offset_size);
	[_scrollView setContentSize:CGSizeMake(selector_width, newHeight)];
	[item removeFromSuperview];
}

- (void)setMenuPosition:(ItemSelectorPosition)position
{
	//float x = self.frame.origin.x;
	float y = self.frame.origin.y;
	float w = self.frame.size.width;
	float h = self.frame.size.height;
	
	switch (position) {
		case RIGHT:
			[self setFrame:CGRectMake(rightPosition, y, w, h)];
			break;
		case LEFT:
			[self setFrame:CGRectMake(leftPosition, y, w, h)];
			break;
		default:
			[self setFrame:CGRectMake(rightPosition, y, w, h)];
			break;
	}
	
	_position = position;
}

- (void)putAside:(BOOL)mustPutAside
{
	NSInteger offset = 0;
	switch (_position) {
		case RIGHT:
			offset = selector_width;
			break;
		case LEFT:
			offset = -selector_width;
			break;
		default:
			break;
	}
	
	if (mustPutAside) {
		[UIView animateWithDuration:0.8
							  delay:0
							options:UIViewAnimationOptionCurveEaseIn
						 animations:
		 ^{
			 CGPoint pos = self.layer.position;
			 pos.x += offset;
			 self.layer.position = pos; 
		 }
						 completion:NULL];
		
		[UIView animateWithDuration:0.6
							  delay:0.6
							options:UIViewAnimationOptionTransitionNone
						 animations:
		 ^{
			 _drillButton.layer.opacity = 1.f;
		 }
						 completion:NULL];
	}
	else {
		[UIView animateWithDuration:0.3
							  delay:0
							options:UIViewAnimationOptionCurveEaseIn
						 animations:
		 ^{
			 _drillButton.layer.opacity = 0.f;
		 }
						 completion:NULL];
		
		[UIView animateWithDuration:0.6
							  delay:0.3
							options:UIViewAnimationOptionTransitionNone
						 animations:
		 ^{
			 CGPoint pos = self.layer.position;
			 pos.x -= offset;
			 self.layer.position = pos; 
		 }
						 completion:NULL];
	}
	
	_drillButton.userInteractionEnabled = mustPutAside;	
}

- (void)show
{
	[self putAside:NO];
}



/////////////////////////////////////////////////////////////////////////////
// MARK: -
// MARK: User Interactions
/////////////////////////////////////////////////////////////////////////////
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	[super touchesBegan:touches withEvent:event];
	NSLog(@"[%@ %@]",[self class], NSStringFromSelector(_cmd));
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	[super touchesEnded:touches withEvent:event];
	NSLog(@"[%@ %@]",[self class], NSStringFromSelector(_cmd));
}

@end
