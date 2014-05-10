//
//  NRFTableViewController.m
//  NotePad
//
//  Created by Nicholas Falba on 5/6/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import "NRFTableViewController.h"
#import "NRFNote.h"
#import "NRFNoteDetailViewController.h"
#import "NRFNoteEditViewController.h"

@interface NRFTableViewController() <UITableViewDataSource, UITableViewDelegate,NRFNoteEditViewControllerDelegate, NRFNoteDetailViewControllerDelegate>

@property (nonatomic, strong) UITableView *tableView; //Main view for this app
@property (nonatomic, strong) NSMutableArray *notes; //Array of note objects for the cells of the TableView

@end


@interface NRFTableViewController ()

@end

@implementation NRFTableViewController


- (instancetype) init
{
    self = [super initWithStyle:UITableViewStylePlain];
    if(self){
        self.notes = [NSMutableArray array];
    }
    return self;
}

/* NSCoding methods to serialize this object in the AppDelegate */
 
-(id) initWithCoder:(NSCoder *)decoder
{
    if(self = [super init])
    {
        NSArray *array = [decoder decodeObjectForKey:@"notes"];
        self.notes = [[NSMutableArray alloc] initWithArray:array copyItems:YES];
    }
    return self;
}

-(void) encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.notes forKey:@"notes"];
}

//Loads the main view and assigns this controller as its delegate and datasource
- (void) loadView
{
    [super loadView];
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                          style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    self.tableView = tableView;
}

//Loads more things into the main view.
- (void) viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Notes";
    [self updateView];
    
}

//Updates the view. Called initially on loading and again after editMode has been entered for the UITableView
- (void) updateView
{
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonPressed:)];
    
    if(self.notes.count > 0){ //Only want to be able to edit the list if there are note objects
        UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editButtonPressed:)];
        self.navigationItem.leftBarButtonItem = editButton;
    }
    
    self.navigationItem.rightBarButtonItem = addButton;
}

/*Methods governing the editing of the TableView list.*/

//Enter edit mode on the table to delete some notes. Called when user presses "Edit"
-(void) editButtonPressed:(id)sender
{
    [self setEditing:YES animated:YES];
}

//Called when user is trying to edit or is done editing the list of notes. Updates the View
-(void) setEditing:(BOOL)editing animated:(BOOL)animated
{
    if(editing){
        [super setEditing:YES animated:YES];
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneEditingPressed:)];
        
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.rightBarButtonItem = doneButton;
    } else {
        [super setEditing:NO animated:YES];
        [self updateView];
    }
}

//Done button is pressed and turns of editing mode.
-(void) doneEditingPressed:(id)sender
{
    [self setEditing:NO animated:YES];
}

//Delete a row and remove the represented note from the datasource
-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.notes removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
}

/*Method governing the adding of rows and creating the associated view to do so*/

//User is trying to add a note. Instantiate an edit view controller to edit/create a note.
- (void) addButtonPressed:(id)sender
{
    NRFNoteEditViewController *noteEditVC = [[NRFNoteEditViewController alloc] initWithNote:nil];
    noteEditVC.delegate = self;
    
    [self.navigationController pushViewController:noteEditVC animated:YES];
    
}

/*UITableViewDataSource protocol methods*/

//Number of rows in the TableView
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.notes.count;
}

//Responsible for generating and reusing the cells.
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    NRFNote *current = self.notes[indexPath.row];
    
    cell.textLabel.text = current.title;
    UIImage *cellImage = [UIImage imageWithContentsOfFile:current.imagePath];
    cell.imageView.image = cellImage;
    NSString *cellDetail = [NSString stringWithFormat:@"%@%@", @"Created: ", current.dateCreated];
    cell.detailTextLabel.text = cellDetail;
    
    return cell;
}

/*UITableViewDelegate protocol methods*/

//Action taken when select a row. Creates a NoteDetailView to show the selected note's details
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NRFNoteDetailViewController *noteDetailVC = [[NRFNoteDetailViewController alloc] initWithNote:self.notes[indexPath.row] atRow:indexPath.row withDelegate:self];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.navigationController pushViewController:noteDetailVC animated:YES];
    
}

/*NRFNoteEditViewControllerDelegate method*/

//updates the view and adds created note to the list
- (void) editViewController:(NRFNoteEditViewController *)noteEditVC didFinishWithNote:(NRFNote *)note
{
    [self.notes addObject:note];
    
    [self.tableView reloadData];
    
    [self updateView];
    
    [self.navigationController  popViewControllerAnimated:YES];
    
}

/*NRFNoteDetaileViewController delegate methods*/

//updates the view and edits the cell of the note that was selected in the table
- (void) detailViewController:(NRFNoteDetailViewController *)noteDetailVC didFinishWithNote:(NRFNote *)note atRow:(NSInteger)row
{
    if(note)
    {
        [self.notes replaceObjectAtIndex:row withObject:note];
    } else {
        [self.notes removeObjectAtIndex:row];
    }
    
    [self.tableView reloadData];
    
    [self updateView];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
