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

@property (weak, nonatomic) IBOutlet UITextField *noteTitle;

@property (weak, nonatomic) IBOutlet UITextView *noteText;


@property (nonatomic) NRFNote *note;

@end

@implementation NRFNoteEditViewController

- (instancetype)initWithNote:(NRFNote *)note
{
    self = [super initWithNibName:@"NRFNoteEditViewController" bundle:nil];
    if (self) {
        self.note = note;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(self.note){
        [self.noteTitle setText:self.note.title];
        [self.noteText setText:self.note.content];
    }
    
    self.title = @"Add Note:";
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveButtonPressed:)];
    
    self.navigationItem.rightBarButtonItem = saveButton;
    
}

- (void) saveButtonPressed:(id)sender
{
    if(!self.note){
        NRFNote *note = [[NRFNote alloc] init];
        self.note = note;
    }
    
    self.note.title = self.noteTitle.text;
    self.note.content = self.noteText.text;
    
    [self.delegate editViewController:self didFinishWithNote:self.note];
    
}




@end
