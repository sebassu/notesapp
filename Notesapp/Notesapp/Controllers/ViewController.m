//
//  ViewController.m
//  Notesapp
//
//  Created by Sebastian Uriarte on 9/17/18.
//  Copyright © 2018 OrangeLoops. All rights reserved.
//

#import "ViewController.h"
#import "EntityManager.h"

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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    [self setCellContents:cell indexPath:indexPath];
    return cell;
}

- (void)setCellContents:(UITableViewCell *)cell indexPath:(nonnull NSIndexPath *)indexPath {
    Note *note = [[self getNotesForSection:indexPath.section] objectAtIndex:indexPath.row];
    cell.textLabel.text = note.title;
    cell.detailTextLabel.text = note.content;
    cell.detailTextLabel.numberOfLines = 0;
    cell.detailTextLabel.textAlignment = NSTextAlignmentJustified;
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
