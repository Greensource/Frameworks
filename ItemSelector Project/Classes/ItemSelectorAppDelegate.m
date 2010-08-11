//
//  ItemSelectorAppDelegate.m
//  ItemSelector
//
//  Created by Pierre DUCHENE on 07/06/10.
//  Copyright CapGemini 2010. All rights reserved.
//

#import "ItemSelectorAppDelegate.h"
#import "AppController.h"

@implementation ItemSelectorAppDelegate

@synthesize window;
@synthesize viewController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after app launch
	viewController = [AppController new];
	[viewController loadView];
	
	[window addSubview:viewController.view];
    [window makeKeyAndVisible];
	
	return YES;
}

- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
