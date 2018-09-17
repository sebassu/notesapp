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

@property (readonly) NSMutableArray *notes;
@property (readonly) NSMutableArray *categories;
//TODO Singleton? SQLite?

+ (void)addNote:(Note*)toAdd;
+ (void)addCategory:(Category*)toAdd;

@end

#endif
