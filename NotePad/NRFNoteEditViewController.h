//
//  NRFNoteEditViewController.h
//  NotePad
//
//  Created by Nicholas Falba on 5/7/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "NRFNote.h"

@class NRFNoteEditViewController;

@protocol NRFNoteEditViewControllerDelegate <NSObject>

- (void) editViewController:(NRFNoteEditViewController *)noteEditVC didFinishWithNote:(NRFNote *)note;

@end

@interface NRFNoteEditViewController : UIViewController

@property (nonatomic) id<NRFNoteEditViewControllerDelegate> delegate;

- (instancetype) initWithNote:(NRFNote *)note;

@end
