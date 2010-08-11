//
//  ItemSelectorAppDelegate.h
//  ItemSelector
//
//  Created by Pierre DUCHENE on 07/06/10.
//  Copyright CapGemini 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemSelectorAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    UIViewController* viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) UIViewController *viewController;

@end

