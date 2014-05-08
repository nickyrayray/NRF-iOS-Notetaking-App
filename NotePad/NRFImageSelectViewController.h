//
//  NRFImageSelectViewController.h
//  NotePad
//
//  Created by Nicholas Falba on 5/7/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NRFNote.h"

@interface NRFImageSelectViewController : UIViewController

-(instancetype) initWithNote:(NRFNote *)note;
-(instancetype) initWithNote:(NRFNote *)note fromViewer:(BOOL)fromViewer;
@end
