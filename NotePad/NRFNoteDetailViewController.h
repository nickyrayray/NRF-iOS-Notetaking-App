//
//  NRFNoteDetailViewController.h
//  NotePad
//
//  Created by Nicholas Falba on 5/7/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <Foundation/Foundation.h>
#import "NRFNoteEditViewController.h"

@class NRFNoteDetailViewController;

//Protocol so that main table view can update the records
@protocol NRFNoteDetailViewControllerDelegate <NSObject>

- (void) detailViewController:(NRFNoteDetailViewController *)noteDetailVC
            didFinishWithNote:(NRFNote *)note
                        atRow:(NSInteger)row;

@end

@interface NRFNoteDetailViewController : UIViewController

@property (nonatomic) id<NRFNoteDetailViewControllerDelegate> delegate;

- (instancetype) initWithNote:(NRFNote *)note atRow:(NSInteger)row withDelegate:(id<NRFNoteDetailViewControllerDelegate>) delegate;

@end
