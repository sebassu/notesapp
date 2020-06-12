#ifndef EntityManager_h
#define EntityManager_h

#import "Note.h"
#import "NoteCategory.h"

@interface EntityManager : NSObject

@property (nonatomic, strong, readonly, nonnull) NSArray<Note *> *notes;
@property (nonatomic, strong, readonly, nonnull) NSArray<NoteCategory *> *categories;

+ (nonnull instancetype) instance;

- (void) loadEntities:(void(^_Nonnull)(void))success onError:(void(^_Nonnull)(void))error;

- (void) addNote:(nonnull Note *)toAdd;
- (void) addCategory:(nonnull NoteCategory *)toAdd;
- (nullable NoteCategory *) getCategoryForId:(NSInteger)identifier;
- (nullable NSArray<Note *> *) getNotesForCategoryId:(NSInteger)categoryId;
- (void) removeAllObjects;

@end

#endif
