//
//  NotesLoader.m
//  Notesapp
//
//  Created by Sebastián Uriarte Güimil on 9/20/18.
//  Copyright © 2018 OrangeLoops. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NotesLoader.h"
#import "EntityManager.h"

@implementation NotesLoader

+ (void) createEntitiesFromFullData:(id)fullData {
    NSDictionary *results = fullData;
    addCategoriesFromData([results objectForKey:@"categories"]);
    addNotesFromData([results objectForKey:@"notes"]);
}

static void addCategoriesFromData(id data) {
    NSArray *categories = data;
    for (int i=0; i<[data count]; i++) {
        NSDictionary *categoryData = [categories objectAtIndex:i];
        createCategoryFromData(categoryData);
    }
}

static void createCategoryFromData(NSDictionary *categoryData) {
    NSInteger identifier = [[categoryData objectForKey:@"id"] integerValue];
    NSString *title = [categoryData objectForKey:@"title"];
    NSDate *createdDate = getDateFromData(categoryData);
    Category *toAdd = [Category withId:identifier withTitle:title withCreatedDate:createdDate];
    [[EntityManager instance] addCategory:toAdd];
}

static void addNotesFromData(id data) {
    NSArray *notes = data;
    for (int i=0; i<[data count]; i++) {
        NSDictionary *noteData = [notes objectAtIndex:i];
        createNoteFromData(noteData);
    }
}

static void createNoteFromData(NSDictionary *noteData) {
    NSUUID *identifier = [[NSUUID alloc] initWithUUIDString:[noteData objectForKey:@"id"]];
    NSString *title = [noteData objectForKey:@"title"];
    NSString *content = [noteData objectForKey:@"content"];
    NSDate *createdDate = getDateFromData(noteData);
    Category * category = getCategoryFromData(noteData);
    Note *toAdd = [Note withId:identifier withTitle:title withContent:content
               withCreatedDate:createdDate withCategory:category];
    [[EntityManager instance] addNote:toAdd];
}

static Category * getCategoryFromData(NSDictionary *noteData) {
    NSInteger categoryId = [[noteData objectForKey:@"categoryId"] integerValue];
    Category *category = [[EntityManager instance] getCategoryForId:categoryId];
    return category;
}

static NSDate * getDateFromData(NSDictionary *data) {
    NSInteger dateSeconds = [[data objectForKey:@"createdDate"] integerValue];
    NSDate *createdDate = [NSDate dateWithTimeIntervalSince1970:dateSeconds];
    return createdDate;
}

@end
