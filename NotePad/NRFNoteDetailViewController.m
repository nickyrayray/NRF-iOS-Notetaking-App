//
//  NRFNoteDetailViewController.m
//  NotePad
//
//  Created by Nicholas Falba on 5/7/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import "NRFNoteDetailViewController.h"
#import "NRFNoteEditViewController.h"

@interface NRFNoteDetailViewController () <NRFNoteEditViewControllerDelegate>

@property (nonatomic) NRFNote *note;
@property (nonatomic) NSInteger *row;

@property (weak, nonatomic) IBOutlet UILabel *noteText;

@end

@implementation NRFNoteDetailViewController

- (id)initWithNote:(NRFNote *)note atRow:(NSUInteger *)row
{
    self = [super initWithNibName:@"NRFNoteDetailViewController" bundle:nil];
    if (self) {
        self.note = note;
        self.row = row;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = self.note.title;
    self.noteText.text = self.note.content;
    
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editButtonPressed:)];
    
    self.navigationItem.rightBarButtonItem = editButton;
    
}

-(void) editButtonPressed:(id)sender
{
    NRFNoteEditViewController *noteEditVC = [[NRFNoteEditViewController alloc] initWithNote:self.note];
    noteEditVC.delegate = self;
    
    [self.navigationController pushViewController:noteEditVC animated:YES];
}

-(void) editViewController:(NRFNoteEditViewController *)noteEditVC didFinishWithNote:(NRFNote *)note
{
    self.note = note;
}

@end
