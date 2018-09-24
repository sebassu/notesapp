//
//  NoteTableCell.h
//  Notesapp
//
//  Created by Sebastián Uriarte Güimil on 9/19/18.
//  Copyright © 2018 OrangeLoops. All rights reserved.
//

#ifndef NoteTableCell_h
#define NoteTableCell_h

#import <UIKit/UIKit.h>
#import "Note.h"

@interface NoteTableCell : UITableViewCell

@property (nonatomic, weak) Note *note;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *contentLabel;
@property (nonatomic, weak) IBOutlet UILabel *dateLabel;

- (void) setCellContentsForIndexPath:(NSIndexPath *)indexPath;

@end

#endif
