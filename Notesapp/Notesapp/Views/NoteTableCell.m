//
//  NoteTableCell.m
//  Notesapp
//
//  Created by Sebastián Uriarte Güimil on 9/19/18.
//  Copyright © 2018 OrangeLoops. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NoteTableCell.h"
#import "EntityManager.h"

@interface NoteTableCell ()

@end

@implementation NoteTableCell

- (void)setCellContentsForIndexPath:(NSIndexPath *)indexPath {
    NSArray<Note *> *notesForSection = [EntityManager.instance getNotesForCategoryId:indexPath.section];
    Note *note = [notesForSection objectAtIndex:indexPath.row];
    [self setTextContents:note];
    [self setFormattedNoteCreationDate:note];
}

- (void)setTextContents:(Note *)note {
    self.titleLabel.text = note.title;
    self.contentLabel.text = note.content;
    self.contentLabel.textAlignment = NSTextAlignmentJustified;
}

- (void)setFormattedNoteCreationDate:(Note *)note {
    NSDateFormatter *objDateFormatter = [[NSDateFormatter alloc] init];
    [objDateFormatter setDateFormat:@"dd/MM/yyyy HH:mm"];
    self.dateLabel.text =[objDateFormatter stringFromDate:note.createdDate];
}

@end
