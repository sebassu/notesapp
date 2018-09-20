//
//  ViewController.m
//  Notesapp
//
//  Created by Sebastian Uriarte on 9/17/18.
//  Copyright © 2018 OrangeLoops. All rights reserved.
//

#import "ViewController.h"
#import "EntityManager.h"
#import "NoteTableCell.h"

@interface ViewController ()

@end

@implementation ViewController

- (void) viewDidLoad {
    [super viewDidLoad];
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
    static NSString *identifier = @"NoteItem";
    NoteTableCell *cell = (NoteTableCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"NoteTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    [self setCellContents:cell indexPath:indexPath];
    return cell;
}

- (void)setCellContents:(NoteTableCell *)cell indexPath:(nonnull NSIndexPath *)indexPath {
    Note *note = [[self getNotesForSection:indexPath.section] objectAtIndex:indexPath.row];
    cell.titleLabel.text = note.title;
    cell.contentLabel.text = note.content;
    cell.contentLabel.textAlignment = NSTextAlignmentJustified;
    [self setFormattedNoteCreationDateToCell:cell note:note];
}

- (void)setFormattedNoteCreationDateToCell:(NoteTableCell *)cell note:(Note *)note {
    NSDateFormatter *objDateFormatter = [[NSDateFormatter alloc] init];
    [objDateFormatter setDateFormat:@"dd/MM/yyyy HH:mm"];
    cell.dateLabel.text =[objDateFormatter stringFromDate:note.createdDate];
}

- (NSInteger) tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *notes = [self getNotesForSection:section];
    return [notes count];
}

- (NSArray *) getNotesForSection:(NSInteger)section {
    EntityManager *entities = EntityManager.instance;
    Category *category = [entities.categories objectAtIndex:section];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"category == %@", category];
    return [entities.notes filteredArrayUsingPredicate:predicate];
}

@end
