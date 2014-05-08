//
//  NRFImageSelectViewController.m
//  NotePad
//
//  Created by Nicholas Falba on 5/7/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import "NRFImageSelectViewController.h"
#import "NRFNote.h"

@interface NRFImageSelectViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic) UIImage *image;
@property (nonatomic) NRFNote *note;
@property (nonatomic) BOOL fromViewer;
@property (weak, nonatomic) IBOutlet UIButton *fetchButton;

@end

@implementation NRFImageSelectViewController

- (id)initWithNote:(NRFNote *)note
{
    self = [super initWithNibName:@"NRFImageSelectViewController" bundle:nil];
    if (self) {
        self.note = note;
        self.fromViewer = NO;
    }
    return self;
}

- (instancetype)initWithNote:(NRFNote *)note fromViewer:(BOOL)fromViewer
{
    self = [super initWithNibName:@"NRFImageSelectViewController" bundle:nil];
    if (self) {
        self.note = note;
        self.fromViewer = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(self.note.image){
        self.image = self.note.image;
        self.imageView.image = self.image;
    }
    
    if(!self.fromViewer){
        UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveButtonPressed:)];
    
        self.navigationItem.rightBarButtonItem = saveButton;
    } else {
        self.fetchButton.hidden = YES;
    }
}

-(void) saveButtonPressed:(id)saveButtonPressed
{
    self.note.image = self.image;
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)searchImage:(id)sender
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum] == NO)
        return;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    imagePicker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    imagePicker.delegate = self;
    
    [self presentViewController:imagePicker animated:YES completion:nil];
}


-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    self.image = image;
    self.imageView.image = image;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
