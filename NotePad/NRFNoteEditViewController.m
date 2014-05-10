//
//  NRFNoteEditViewController.m
//  NotePad
//
//  Created by Nicholas Falba on 5/7/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import "NRFNoteEditViewController.h"
#import "NRFNote.h"
#import "NRFImageSelectViewController.h"

@interface NRFNoteEditViewController ()

@property (weak, nonatomic) IBOutlet UITextField *noteTitle;

@property (weak, nonatomic) IBOutlet UITextView *noteText;
@property (weak, nonatomic) IBOutlet UILabel *noteTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLastModifiedLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLastModified;
@property (weak, nonatomic) IBOutlet UILabel *timeCreatedLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeCreated;

@property (nonatomic) NRFNote *note;

@end

@implementation NRFNoteEditViewController

/*Housekeeping for creation of the view controller*/

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
    
    
    if(self.note){//If a note exists load its values to edit them further.
        
        [self.noteTitle setText:self.note.title];
        [self.noteText setText:self.note.content];
        self.timeCreated.text = self.note.dateCreated;
        self.timeLastModified.text = self.note.lastModified;
        self.title = @"Edit Note:";
        
    } else {//No note so update the View to default values
        self.title = @"Add Note:";
        self.timeLastModified.text = @"Now";
        self.timeCreated.text = @"Now";
    }
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveButtonPressed:)];
    
    self.navigationItem.rightBarButtonItem = saveButton;
    
}

/*User wants to save changes to a note. So either updates a note object's properties
 or creates the note based on the properties the user has entered.*/
- (void) saveButtonPressed:(id)sender
{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterMediumStyle];
    
    if([self.noteTitle.text isEqualToString:@""]){//Make sure the note has a title.
        [[[UIAlertView alloc] initWithTitle:@"No Title Found" message:@"Please enter a title for your note; otherwise use the back button to return to previous screen." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
        return;
    }
    
    if([self.noteText.text isEqualToString:@""]){//Make sure the note has content
        [[[UIAlertView alloc] initWithTitle:@"No Content Found" message:@"Please enter content for your note; otherwise use the back button to return to previous screen." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
        return;
    }
    
    if(!self.note){ //If the note doesn't exist, create it.
        NRFNote *note = [[NRFNote alloc] init];
        self.note = note;
        self.note.dateCreated = [formatter stringFromDate:[NSDate date]];
    }
    
    //Update the note's properties
    self.note.title = self.noteTitle.text;
    self.note.content = self.noteText.text;
    self.note.lastModified = [formatter stringFromDate:[NSDate date]];
    
    [self.delegate editViewController:self didFinishWithNote:self.note];
    
}

//User wants to add an image so generate an NRFImageSelectViewController in edit mode
- (IBAction)selectImageForNote:(id)sender {
    NRFImageSelectViewController *imageSelectorVC = [[NRFImageSelectViewController alloc] initWithNote:self.note];
    [self.navigationController pushViewController:imageSelectorVC animated:YES];
}

@end
