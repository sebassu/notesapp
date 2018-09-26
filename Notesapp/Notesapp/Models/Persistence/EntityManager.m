//
//  EntityManager.m
//  Notesapp
//
//  Created by Sebastian Uriarte on 9/17/18.
//  Copyright © 2018 OrangeLoops. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EntityManager.h"
#import "WebServiceLoadingStrategy.h"

@interface EntityManager ()

@property (nonatomic, strong) NSMutableArray<Note *> *innerNotes;
@property (nonatomic, strong) NSMutableArray<Category *> *innerCategories;
@property (nonatomic, strong) id <LoadingStrategy> loadingStrategy;

@end

@implementation EntityManager

- (NSArray<Note *> *) notes {
    return self.innerNotes;
}

- (NSArray<Category *> *) categories {
    return self.innerCategories;
}

+ (instancetype) instance {
    static EntityManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[EntityManager alloc] init];
    });
    return instance;
}

- (id) init {
    if (self = [super init]) {
        self.innerNotes = [[NSMutableArray alloc] init];
        self.innerCategories = [[NSMutableArray alloc] init];
        self.loadingStrategy = [[WebServiceLoadingStrategy alloc] init];
    }
    return self;
}

- (void) addNote:(Note *)toAdd {
    [self.innerNotes addObject:toAdd];
}

- (void) addCategory:(Category*)toAdd {
    [self.innerCategories addObject:toAdd];
}

- (Category*) getCategoryForId:(NSInteger)identifier {
    for (int i = 0; i < [self.categories count]; i++) {
        Category *item = [self.categories objectAtIndex:i];
        if (item.identifier == identifier) {
            return item;
        }
    }
    return nil;
}

- (NSArray<Note *> *) getNotesForCategoryId:(NSInteger)categoryId {
    Category *category = [self.categories objectAtIndex:categoryId];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"category == %@", category];
    return [self.notes filteredArrayUsingPredicate:predicate];
}

- (void) removeAllObjects {
    [self.innerNotes removeAllObjects];
    [self.innerCategories removeAllObjects];
}

- (void) loadEntities:(void(^)(void))success onError:(void(^)(void))error {
    [self removeAllObjects];
    [self.loadingStrategy LoadEntities:self.innerNotes categories:self.innerCategories onSuccess:success onError:error];
}

@end
