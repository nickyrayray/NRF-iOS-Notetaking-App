//
//  NRFAppDelegate.h
//  NotePad
//
//  Created by Nicholas Falba on 5/5/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NRFTableViewController.h"

@interface NRFAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NRFTableViewController *noteList;

@end
