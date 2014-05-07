//
//  NRFNoteDetailViewController.h
//  NotePad
//
//  Created by Nicholas Falba on 5/7/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NRFNoteEditViewController.h"

@class NRFNoteDetailViewController;

@protocol NRFNoteDetailViewControllerDelegate <NSObject>

- (void) detailViewController:(NRFNoteDetailViewController *)noteDetailVC
            didFinishWithNote:(NRFNote *)note atRow:(NSUInteger)row;

@end

@interface NRFNoteDetailViewController : UIViewController

- (instancetype) initWithNote:(NRFNote *)note atRow:(NSUInteger *)row;

@end
