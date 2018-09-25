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
#import <Notesapp-Swift.h>

@interface MainViewController () <UITableViewDelegate, UITableViewDataSource>

@property (class, nonatomic, readonly, weak) NSString *noteCellReuseIdentifier;
@property (class, nonatomic, readonly, weak) NSString *detailsSegueIdentifier;
@property (nonatomic, weak) IBOutlet UITableView *noteTableView;

@end

@implementation MainViewController

+ (NSString *)noteCellReuseIdentifier {
    return @"NoteItem";
}

+ (NSString *)detailsSegueIdentifier {
    return @"ShowDetails";
}

- (void) viewDidLoad {
    [super viewDidLoad];
    [self reloadNotes];
    [self.noteTableView registerNib:[UINib nibWithNibName:@"NoteTableCell" bundle:nil] forCellReuseIdentifier:MainViewController.noteCellReuseIdentifier];
    [self setRefreshControlToNoteTable];
}

- (void) setRefreshControlToNoteTable {
    self.noteTableView.refreshControl = [[UIRefreshControl alloc] init];
    [self.noteTableView.refreshControl addTarget:self
                                          action:@selector(reloadNotes)
                                forControlEvents:UIControlEventValueChanged];
}

- (void) reloadNotes {
    void (^completion)(void) = ^void(void) {
        [self stopRefreshControlAnimation];
    };
    void (^errorAction)(void) = ^void(void) {
        [self displayLoadingError];
    };
    [EntityManager.instance loadEntities:completion onError:errorAction];
}

- (void) stopRefreshControlAnimation {
    [self.noteTableView.refreshControl endRefreshing];
    [self.noteTableView reloadData];
}

- (void) displayLoadingError {
    [self stopRefreshControlAnimation];
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                   message:@"Error al intentar cargar las notas/categorías del servicio remoto."
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    Category *category = [EntityManager.instance.categories objectAtIndex:section];
    return category.title;
}

- (void) tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    header.textLabel.font = [UIFont boldSystemFontOfSize:22];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return [EntityManager.instance.categories count];
}

- (nonnull UITableViewCell *) tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NoteTableCell *cell = (NoteTableCell *)[tableView dequeueReusableCellWithIdentifier:MainViewController.noteCellReuseIdentifier forIndexPath:indexPath];
    [cell setCellContentsForIndexPath:indexPath];
    [self setTagGestureRecognizerToCell:cell];
    return cell;
}

- (void) setTagGestureRecognizerToCell:(NoteTableCell *)cell {
    id tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToDetailsView:)];
    [cell addGestureRecognizer:tapGestureRecognizer];
    cell.userInteractionEnabled = YES;
    [tapGestureRecognizer setCancelsTouchesInView:NO];
}

- (NSInteger) tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray<Note *> *notes = [EntityManager.instance getNotesForCategoryId:section];
    return [notes count];
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:MainViewController.detailsSegueIdentifier]) {
        NoteTableCell *tappedCell = (NoteTableCell *)((UIGestureRecognizer *)sender).view;
        DetailsViewController *destination = (DetailsViewController *)[segue destinationViewController];
        destination.note = tappedCell.note;
    }
}

- (void) goToDetailsView:(id)sender {
    [self performSegueWithIdentifier:MainViewController.detailsSegueIdentifier sender:sender];
}

@end
