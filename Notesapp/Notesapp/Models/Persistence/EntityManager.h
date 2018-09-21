//
//  EntityManager.h
//  Notesapp
//
//  Created by Sebastian Uriarte on 9/17/18.
//  Copyright © 2018 OrangeLoops. All rights reserved.
//

#ifndef EntityManager_h
#define EntityManager_h

#import "Note.h"
#import "Category.h"

@interface EntityManager : NSObject

@property (readonly) NSMutableArray<Note *> *notes;
@property (readonly) NSMutableArray<Category *> *categories;

+ (instancetype) instance;

- (void) addNote:(Note*)toAdd;
- (void) addCategory:(Category*)toAdd;
- (Category*) getCategoryForId:(NSInteger)identifier;
- (NSArray *) getNotesForCategoryId:(NSInteger)categoryId;
- (void) removeAllObjects;

@end

#endif
