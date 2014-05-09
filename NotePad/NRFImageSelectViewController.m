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
@property (weak, nonatomic) IBOutlet UITextField *imageTitle;

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
    
    if(!self.fromViewer){
        UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveButtonPressed:)];
    
        self.navigationItem.rightBarButtonItem = saveButton;
        self.title = @"Add Image";
        if(self.note.imagePath){
            UIImage *noteImage = [UIImage imageWithContentsOfFile:self.note.imagePath];
            self.image = noteImage;
            self.imageView.image = self.image;
            self.imageTitle.text = self.note.imageTitle;
            [self.fetchButton setTitle:@"Change Image" forState:UIControlStateNormal];
            self.title = @"Edit image";
        }
    } else {
        self.fetchButton.hidden = YES;
        self.imageTitle.hidden = YES;
        self.title = self.note.imageTitle;
        UIImage *noteImage = [UIImage imageWithContentsOfFile:self.note.imagePath];
        self.image = noteImage;
        self.imageView.image = self.image;
    }
}

-(void) saveButtonPressed:(id)saveButtonPressed
{
    if(!self.imageView.image){
        [[[UIAlertView alloc] initWithTitle:@"No Image Found" message:@"Please select an image to save; otherwise use the back button to return to previous screen." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
        return;
    }
    
    if(![self.imageTitle.text isEqual: @""]){
        self.note.imageTitle = self.imageTitle.text;
    } else {
        [[[UIAlertView alloc] initWithTitle:@"No Image Title Found" message:@"Please input an image title at the bottom of the screen in the text field." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
        return;
    }
    
    NSData *imageData = UIImageJPEGRepresentation(self.imageView.image, 1.0f);
    NSString *filename = [self.note.imageTitle stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *imagePath = [documentsPath stringByAppendingPathComponent:filename];
    [imageData writeToFile:imagePath atomically:YES];
    
    self.note.imagePath = imagePath;
    self.image = self.imageView.image;
    
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
    if(self.image){
        [self.fetchButton setTitle:@"Change Image" forState:UIControlStateNormal];
    }
}

-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    if(self.image){
        [self.fetchButton setTitle:@"Change Image" forState:UIControlStateNormal];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
