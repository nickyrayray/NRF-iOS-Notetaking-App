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

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *notes;

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

- (void) loadView
{
    [super loadView];
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                          style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    self.tableView = tableView;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Notes";
    [self selectView];
    
}

- (void) selectView
{
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonPressed:)];
    
    if(self.notes.count > 0){
        UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editButtonPressed:)];
        self.navigationItem.leftBarButtonItem = editButton;
    }
    
    self.navigationItem.rightBarButtonItem = addButton;
}

- (void) addButtonPressed:(id)sender
{
    NRFNoteEditViewController *noteEditVC = [[NRFNoteEditViewController alloc] initWithNote:nil];
    noteEditVC.delegate = self;
    
    [self.navigationController pushViewController:noteEditVC animated:YES];
    
}

-(void) editButtonPressed:(id)sender
{
    [self setEditing:YES animated:YES];
}

-(void) setEditing:(BOOL)editing animated:(BOOL)animated
{
    if(editing){
        [super setEditing:YES animated:YES];
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneEditingPressed:)];
        
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.rightBarButtonItem = doneButton;
    } else {
        [super setEditing:NO animated:YES];
        [self selectView];
    }
}


-(void) doneEditingPressed:(id)sender
{
    [self setEditing:NO animated:YES];
}


-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.notes removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.notes.count;
}

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

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NRFNoteDetailViewController *noteDetailVC = [[NRFNoteDetailViewController alloc] initWithNote:self.notes[indexPath.row] atRow:indexPath.row withDelegate:self];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.navigationController pushViewController:noteDetailVC animated:YES];
    
}

- (void) editViewController:(NRFNoteEditViewController *)noteEditVC didFinishWithNote:(NRFNote *)note
{
    [self.notes addObject:note];
    
    [self.tableView reloadData];
    
    [self selectView];
    
    [self.navigationController  popViewControllerAnimated:YES];
    
}

- (void) detailViewController:(NRFNoteDetailViewController *)noteDetailVC didFinishWithNote:(NRFNote *)note atRow:(NSInteger)row
{
    if(note)
    {
        [self.notes replaceObjectAtIndex:row withObject:note];
    } else {
        [self.notes removeObjectAtIndex:row];
    }
    
    [self.tableView reloadData];
    
    [self selectView];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
