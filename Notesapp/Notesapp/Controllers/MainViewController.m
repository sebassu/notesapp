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

@property (nonatomic, strong) NSString *noteCellReuseIdentifier;
@property (nonatomic, weak) IBOutlet UITableView *noteTableView;

@end

@implementation MainViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    [self reloadNotes];
    self.noteCellReuseIdentifier = @"NoteItem";
    [self.noteTableView registerNib:[UINib nibWithNibName:@"NoteTableCell" bundle:nil] forCellReuseIdentifier:self.noteCellReuseIdentifier];
    [self setTagGestureRecognizerToTable];
    [self setRefreshControlToNoteTable];
}

- (void) setTagGestureRecognizerToTable {
    id tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToDetailsView)];
    [self.noteTableView addGestureRecognizer:tapGestureRecognizer];
    self.noteTableView.userInteractionEnabled = YES;
    [tapGestureRecognizer setCancelsTouchesInView:NO];
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

- (void)stopRefreshControlAnimation {
    [self.noteTableView.refreshControl endRefreshing];
    [self.noteTableView reloadData];
}

-(void) displayLoadingError {
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
    NSArray<Note *> *notes = [EntityManager.instance getNotesForCategoryId:section];
    return [notes count];
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowDetails"]) {
        NoteTableCell *cell = [self.noteTableView cellForRowAtIndexPath:[self.noteTableView indexPathForSelectedRow]];
        DetailsViewController *destination = (DetailsViewController *)[segue destinationViewController];
        destination.note = cell.note;
    }
}

-(void) goToDetailsView {
    [self performSegueWithIdentifier:@"ShowDetails" sender:nil];
}

@end
