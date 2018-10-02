#ifndef NoteTableCell_h
#define NoteTableCell_h

#import <UIKit/UIKit.h>

#import "Note.h"

@interface NoteTableCell : UITableViewCell

@property (nonatomic, weak, nullable) Note *note;
@property (nonatomic, weak, nullable) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak, nullable) IBOutlet UILabel *contentLabel;
@property (nonatomic, weak, nullable) IBOutlet UILabel *dateLabel;

- (void) setCellContentsForIndexPath:(nonnull NSIndexPath *)indexPath;

@end

#endif
