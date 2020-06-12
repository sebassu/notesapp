#ifndef Note_h
#define Note_h

#import "NoteCategory.h"

@interface Note : NSObject

@property (nonatomic, strong, nonnull) NSUUID *identifier;
@property (nonatomic, strong, nonnull) NSString *title;
@property (nonatomic, strong, nonnull) NSString *content;
@property (nonatomic, strong, nonnull) NSDate *createdDate;
@property (nonatomic, strong, nonnull) NoteCategory *category;

+ (nonnull instancetype) withId:(nonnull NSUUID *)identifier withTitle:(nonnull NSString *)title
            withContent:(nonnull NSString *)content withCreatedDate:(nonnull NSDate *) createdDate withCategory:(nonnull NoteCategory *)category;

- (nonnull id) initWithId:(nonnull NSUUID *) identifier title:(nonnull NSString *)title
          content:(nonnull NSString *)content createdDate:(nonnull NSDate *) createdDate category:(nonnull NoteCategory *)category;

@end

#endif
