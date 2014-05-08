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
@property (nonatomic) NSInteger row;

@property (weak, nonatomic) IBOutlet UITextView *noteText;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *time;

@end

@implementation NRFNoteDetailViewController

- (id)initWithNote:(NRFNote *)note atRow:(NSInteger)row withDelegate:(id<NRFNoteDetailViewControllerDelegate>)delegate
{
    self = [super initWithNibName:@"NRFNoteDetailViewController" bundle:nil];
    if (self) {
        self.note = note;
        self.row = row;
        self.delegate = delegate;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self viewView];
    
}

-(void) viewView
{
    self.title = self.note.title;
    self.noteText.text = self.note.content;
    NSString *lastUpdated = [self.note.formatter stringFromDate:self.note.date];
    self.time.text = lastUpdated;
    
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editButtonPressed:)];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonPressed:)];
    
    self.navigationItem.rightBarButtonItem = editButton;
    self.navigationItem.leftBarButtonItem = doneButton;
}

-(void) editButtonPressed:(id)sender
{
    NRFNoteEditViewController *noteEditVC = [[NRFNoteEditViewController alloc] initWithNote:self.note];
    noteEditVC.delegate = self;
    
    [self.navigationController pushViewController:noteEditVC animated:YES];
}

-(void) doneButtonPressed:(id)sender
{
    [self.delegate detailViewController:self didFinishWithNote:self.note atRow:self.row];
}

-(void) editViewController:(NRFNoteEditViewController *)noteEditVC didFinishWithNote:(NRFNote *)note
{
    self.note = note;
    [self.navigationController popViewControllerAnimated:YES];
    [self viewView];
}




@end
