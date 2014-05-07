//
//  NRFTableViewController.m
//  NotePad
//
//  Created by Nicholas Falba on 5/6/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import "NRFTableViewController.h"
#import "NRFNote.h"
#import "NRFNoteEditViewController.h"

@interface NRFTableViewController() <UITableViewDataSource, UITableViewDelegate,NRFNoteEditViewControllerDelegate>

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
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonPressed:)];
    
    self.navigationItem.rightBarButtonItem = addButton;
    
}

- (void) addButtonPressed:(id)sender
{
    NRFNoteEditViewController *noteEditVC = [[NRFNoteEditViewController alloc] initWithNote:nil];
    noteEditVC.delegate = self;
    
    [self.navigationController pushViewController:noteEditVC animated:YES];
    
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NRFNote *current = self.notes[indexPath.row];
    cell.textLabel.text = current.title;
    return cell;
}

- (void) tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void) editViewController:(NRFNoteEditViewController *)noteEditVC didFinishWithNote:(NRFNote *)note
{
    [self.notes addObject:note];
    
    [self.tableView reloadData];
    
    [self.navigationController  popViewControllerAnimated:YES];
    
}


@end
