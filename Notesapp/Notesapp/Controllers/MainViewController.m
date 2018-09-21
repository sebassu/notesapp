//
//  ViewController.m
//  Notesapp
//
//  Created by Sebastian Uriarte on 9/17/18.
//  Copyright © 2018 OrangeLoops. All rights reserved.
//

#import "MainViewController.h"
#import "EntityManager.h"
#import "NoteTableCell.h"
#import "NotesLoader+FromWebService.h"

@interface MainViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSString *noteCellReuseIdentifier;
@property (nonatomic, weak) IBOutlet UITableView *noteTableView;

@end

@implementation MainViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    self.noteCellReuseIdentifier = @"NoteItem";
    [self.noteTableView registerNib:[UINib nibWithNibName:@"NoteTableCell" bundle:nil] forCellReuseIdentifier:self.noteCellReuseIdentifier];
    [self setRefreshControlToNoteTable];
}

- (void) setRefreshControlToNoteTable {
    self.noteTableView.refreshControl = [[UIRefreshControl alloc] init];
    [self.noteTableView.refreshControl addTarget:self
                                          action:@selector(reloadNotes)
                                forControlEvents:UIControlEventValueChanged];
}

- (void) reloadNotes {
    [NotesLoader loadEntitiesFromWebService];
}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    Category *category = [EntityManager.instance.categories objectAtIndex:section];
    return category.title;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    header.textLabel.font = [UIFont boldSystemFontOfSize:22];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return [EntityManager.instance.categories count];
}

- (nonnull UITableViewCell *) tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NoteTableCell *cell = (NoteTableCell *)[tableView dequeueReusableCellWithIdentifier:self.noteCellReuseIdentifier];
    [cell setCellContentsForIndexPath:indexPath];
    return cell;
}

- (NSInteger) tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *notes = [EntityManager.instance getNotesForCategoryId:section];
    return [notes count];
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
