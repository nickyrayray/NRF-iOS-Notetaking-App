//
//  NRFNoteDetailViewController.m
//  NotePad
//
//  Created by Nicholas Falba on 5/7/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import "NRFNoteDetailViewController.h"
#import "NRFImageSelectViewController.h"

@interface NRFNoteDetailViewController () <NRFNoteEditViewControllerDelegate, MFMailComposeViewControllerDelegate>

@property (nonatomic) NRFNote *note;
@property (nonatomic) NSInteger row;

@property (weak, nonatomic) IBOutlet UITextView *noteText;
@property (weak, nonatomic) IBOutlet UILabel *timeLastModifiedLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLastModified;
@property (weak, nonatomic) IBOutlet UIButton *emailButton;
@property (weak, nonatomic) IBOutlet UILabel *timeCreatedLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeCreated;

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
    
    [self updateView];
    
}

-(void) updateView
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterMediumStyle];
    
    self.title = self.note.title;
    self.noteText.text = self.note.content;
    self.timeLastModified.text = self.note.lastModified;
    self.timeCreated.text = self.note.dateCreated;
    
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
    [self updateView];
}

- (IBAction)viewPictureButtonPressed:(id)sender {
    NRFImageSelectViewController *imageSelectVC = [[NRFImageSelectViewController alloc] initWithNote:self.note fromViewer:YES];
    [self.navigationController pushViewController:imageSelectVC animated:YES];
}

- (IBAction)emailButtonPressed:(id)sender {
    
    MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
    mailer.mailComposeDelegate = self;
    
    if(![self.note.imagePath isEqualToString:@""]){
        NSData *imageData = [NSData dataWithContentsOfFile:self.note.imagePath];
        NSString *fileName = [self.note.imageTitle stringByAppendingPathExtension:@"jpeg"];
        [mailer addAttachmentData:imageData mimeType:@"image/jpeg" fileName:fileName];
    }
    
    [mailer setSubject:self.note.title];
    
    [mailer setMessageBody:self.note.content isHTML:NO];
    
    [self presentViewController:mailer animated:YES completion:nil];
    
}

-(void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
