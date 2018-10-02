#ifndef EntityManager_h
#define EntityManager_h

#import "Note.h"
#import "Category.h"

@interface EntityManager : NSObject

@property (nonatomic, strong, readonly, nonnull) NSArray<Note *> *notes;
@property (nonatomic, strong, readonly, nonnull) NSArray<Category *> *categories;

+ (nonnull instancetype) instance;

- (void) loadEntities:(void(^_Nonnull)(void))success onError:(void(^_Nonnull)(void))error;

- (void) addNote:(nonnull Note *)toAdd;
- (void) addCategory:(nonnull Category *)toAdd;
- (nullable Category *) getCategoryForId:(NSInteger)identifier;
- (nullable NSArray<Note *> *) getNotesForCategoryId:(NSInteger)categoryId;
- (void) removeAllObjects;

@end

#endif
