//
//  ItemSelector.m
//  ItemSelector
//
//  Created by Pierre DUCHENE on 08/06/10.
//  Copyright 2010 CapGemini. All rights reserved.
//

#import "ItemSelector.h"
#import <QuartzCore/CALayer.h>

@implementation ItemSelector


/////////////////////////////////////////////////////////////////////////////
// MARK: -
// MARK: Constants
/////////////////////////////////////////////////////////////////////////////
const float	leftPosition = 0.f;
const float rightPosition = 420.f;
const float selector_width = 60.f;
const float selector_height = 320.f;
const float scroll_offset = 25.f;
const float overflowView_height = 40.f;
const float item_side_size = 50.f;

/////////////////////////////////////////////////////////////////////////////
// MARK: -
// MARK: Memory Management
/////////////////////////////////////////////////////////////////////////////

- (id)init {
    if ((self = [super initWithFrame:CGRectMake(rightPosition, 0, selector_width, selector_height)])) {
		
		float x = self.frame.origin.x;
		float y = self.frame.origin.y;
		float w = self.frame.size.width;
		float h = self.frame.size.height;
		
		[self setBackgroundColor:ITEM_SELECTOR_COLOR];
		
		_scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(x, scroll_offset, w, (h - 2 * scroll_offset))];
		_scrollView.layer.masksToBounds = YES;
		_scrollView.layer.cornerRadius = 15.;
		_scrollView.backgroundColor = ITEM_SELECTOR_COLOR;
		_scrollView.contentSize = CGSizeMake(w, 0);
		_scrollView.contentOffset = CGPointZero;
		_scrollView.contentInset = UIEdgeInsetsMake(10, 0, 10, 0);
		_scrollView.showsHorizontalScrollIndicator = NO;
		_scrollView.showsVerticalScrollIndicator = NO;
		
        _overflowMin = [[UIControl alloc] initWithFrame:CGRectMake(x, y, w, overflowView_height)];
		UIImage* minImg = [UIImage imageNamed:@"overflowMin.png"];
		[_overflowMin addSubview:[[UIImageView alloc] initWithImage:minImg]];
		[minImg release];
		
		_overflowMax = [[UIControl alloc] initWithFrame:CGRectMake(x, h-overflowView_height, w, overflowView_height)];
		UIImage* maxImg = [UIImage imageNamed:@"overflowMax.png"];
		[_overflowMax addSubview:[[UIImageView alloc] initWithImage:maxImg]];
		[maxImg release];
		
		[self addSubview:_scrollView];
		[self addSubview:_overflowMin];
		[self addSubview:_overflowMax];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:CGRectMake(rightPosition, frame.origin.y, selector_width, frame.size.height)])) {
		
		float x = self.frame.origin.x;
		float y = self.frame.origin.y;
		float w = self.frame.size.width;
		float h = self.frame.size.height;
		
		[self setBackgroundColor:ITEM_SELECTOR_COLOR];
		
		_scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(x, y+scroll_offset, w, (h - 2 * scroll_offset))];
		_scrollView.layer.masksToBounds = YES;
		_scrollView.layer.cornerRadius = 15.;
		_scrollView.backgroundColor = ITEM_SELECTOR_COLOR;
		_scrollView.contentSize = CGSizeMake(w, 0);
		_scrollView.contentOffset = CGPointZero;
		_scrollView.contentInset = UIEdgeInsetsMake(10, 0, 10, 0);
		_scrollView.showsHorizontalScrollIndicator = NO;
		_scrollView.showsVerticalScrollIndicator = NO;
		
        _overflowMin = [[UIControl alloc] initWithFrame:CGRectMake(x, y, w, overflowView_height)];
		UIImage* minImg = [UIImage imageNamed:@"overflowMin.png"];
		[_overflowMin addSubview:[[UIImageView alloc] initWithImage:minImg]];
		[minImg release];
		
		_overflowMax = [[UIControl alloc] initWithFrame:CGRectMake(x, y + h - overflowView_height, w, overflowView_height)];
		UIImage* maxImg = [UIImage imageNamed:@"overflowMax.png"];
		[_overflowMax addSubview:[[UIImageView alloc] initWithImage:maxImg]];
		[maxImg release];
		
		[self addSubview:_scrollView];
		[self addSubview:_overflowMin];
		[self addSubview:_overflowMax];
    }
    return self;
}

- (void)dealloc {
	[_overflowMin release]; _overflowMin = nil;
	[_overflowMax release]; _overflowMax = nil;
	[_scrollView release]; _scrollView = nil;
	
    [super dealloc];
}


/////////////////////////////////////////////////////////////////////////////
// MARK: -
// MARK: Accessors
/////////////////////////////////////////////////////////////////////////////
@synthesize overflowMin = _overflowMin;
@synthesize overflowMax = _overflowMax;

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
	float newHeight = (_scrollView.contentSize.height + item_side_size + 5);
	[_scrollView setContentSize:CGSizeMake(selector_width, newHeight)];
	[_scrollView addSubview:item];
}

- (void)removeItem:(UIControl*)item
{
	float newHeight = (_scrollView.contentSize.height - item_side_size - 5);
	[_scrollView setContentSize:CGSizeMake(selector_width, newHeight)];
	[item removeFromSuperview];
}


@end
