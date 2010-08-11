    //
//  ItemSelectorController.m
//  ItemSelector
//
//  Created by Pierre DUCHENE on 10/06/10.
//  Copyright 2010 CapGemini. All rights reserved.
//

#import "ItemSelectorController.h"
#import "GSItemSelector.h"

@implementation ItemSelectorController

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	self.view = [[GSItemSelector alloc] init];
	UIColor *patternColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_pattern.png"]];
	[(GSItemSelector*)self.view setColor:patternColor];
	[(GSItemSelector*)self.view setBorderColor:patternColor];
	//[(GSItemSelector*)self.view setColor:[UIColor colorWithRed:.8 green:.8 blue:.8 alpha:.8]];
	//[(GSItemSelector*)self.view setBorderColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1]];
	[(GSItemSelector*)self.view setMenuPosition:RIGHT];
	
	UIButton* b1 = [UIButton buttonWithType:UIButtonTypeCustom];
	[b1 setImage:[UIImage imageNamed:@"item1.png"] forState:UIControlStateNormal];
	[b1 addTarget:self action:@selector(itemAction) forControlEvents:UIControlEventTouchDown];
	
	UIButton* b2 = [UIButton buttonWithType:UIButtonTypeCustom];
	[b2 setImage:[UIImage imageNamed:@"item2.png"] forState:UIControlStateNormal];
	[b2 addTarget:self action:@selector(itemAction) forControlEvents:UIControlEventTouchDown];
	
	UIButton* b3 = [UIButton buttonWithType:UIButtonTypeCustom];
	[b3 setImage:[UIImage imageNamed:@"item3.png"] forState:UIControlStateNormal];
	[b3 addTarget:self action:@selector(itemAction) forControlEvents:UIControlEventTouchDown];
	
	UIButton* b4 = [UIButton buttonWithType:UIButtonTypeCustom];
	[b4 setImage:[UIImage imageNamed:@"item4.png"] forState:UIControlStateNormal];
	[b4 addTarget:self action:@selector(itemAction) forControlEvents:UIControlEventTouchDown];
	
	UIButton* b5 = [UIButton buttonWithType:UIButtonTypeCustom];
	[b5 setImage:[UIImage imageNamed:@"item5.png"] forState:UIControlStateNormal];
	[b5 addTarget:self action:@selector(itemAction) forControlEvents:UIControlEventTouchDown];
	
	UIButton* b6 = [UIButton buttonWithType:UIButtonTypeCustom];
	[b6 setImage:[UIImage imageNamed:@"item6.png"] forState:UIControlStateNormal];
	[b6 addTarget:self action:@selector(itemAction) forControlEvents:UIControlEventTouchDown];
	
	[(GSItemSelector*)self.view addItem:b1];
	[(GSItemSelector*)self.view addItem:b2];
	[(GSItemSelector*)self.view addItem:b3];
	[(GSItemSelector*)self.view addItem:b4];
	[(GSItemSelector*)self.view addItem:b5];
	[(GSItemSelector*)self.view addItem:b6];
	
}

- (void)itemAction
{
	[(GSItemSelector*)self.view putAside:YES];
}

@end
