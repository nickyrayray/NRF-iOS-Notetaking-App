//
//  NRFNoteEditViewController.m
//  NotePad
//
//  Created by Nicholas Falba on 5/7/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import "NRFNoteEditViewController.h"
#import "NRFNote.h"

@interface NRFNoteEditViewController ()

@property (nonatomic) NRFNote *note;

@end

@implementation NRFNoteEditViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withNote:(NRFNote *) note
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.note = note;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
