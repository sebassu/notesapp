//
//  EntityManager.m
//  Notesapp
//
//  Created by Sebastian Uriarte on 9/17/18.
//  Copyright © 2018 OrangeLoops. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EntityManager.h"

@implementation EntityManager

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
        _notes = [[NSMutableArray alloc] init];
        _categories = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void) addNote:(Note *)toAdd {
    [self.notes addObject:toAdd];
}

- (void) addCategory:(Category*)toAdd {
    [self.categories addObject:toAdd];
}

- (Category*) getCategoryForId:(NSInteger)identifier {
    for (int i = 0; i < [self.categories count]; i++) {
        Category *item = [self.categories objectAtIndex:i];
        if(item.identifier == identifier) {
            return item;
        }
    }
    return nil;
}

@end
