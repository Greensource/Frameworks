//
//  AppController.m
//  ItemSelector
//
//  Created by Pierre DUCHENE on 08/06/10.
//  Copyright 2010 CapGemini. All rights reserved.
//

#import "AppController.h"
#import "ItemSelectorController.h"
#import <QuartzCore/QuartzCore.h>

@implementation AppController

- (id) init
{
	self = [super init];
	if (self != nil) {
		menuController = [ItemSelectorController new];
	}
	return self;
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	
	self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
	UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.png"]];
	[self.view addSubview:background];
	[menuController loadView];
	[self.view addSubview:menuController.view];
}

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/


//*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}
//*/


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[menuController release];
	
    [super dealloc];
}

@end
