//
//  JSONParser.m
//  Notesapp
//
//  Created by Sebastián Uriarte Güimil on 9/21/18.
//  Copyright © 2018 OrangeLoops. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONParser.h"

@implementation JSONParser

+ (void) createEntitiesFrom:(id)data notes:(NSMutableArray<Note *> *)notes categories:(NSMutableArray<NoteCategory *> *)categories  {
    NSDictionary *results = data;
    addCategoriesFromData([results objectForKey:@"categories"], categories);
    addNotesFromData([results objectForKey:@"notes"], categories, notes);
}

static void addCategoriesFromData(id data, NSMutableArray<NoteCategory *> *categories) {
    NSArray *categoriesToAdd = data;
    for (int i=0; i<[data count]; i++) {
        NSDictionary *categoryData = [categoriesToAdd objectAtIndex:i];
        createCategoryFromData(categoryData, categories);
    }
}

static void createCategoryFromData(NSDictionary *categoryData, NSMutableArray<NoteCategory *> *categories) {
    NSInteger identifier = [[categoryData objectForKey:@"id"] integerValue];
    NSString *title = [categoryData objectForKey:@"title"];
    NSDate *createdDate = getDateFromData(categoryData);
    NoteCategory *toAdd = [NoteCategory withId:identifier withTitle:title withCreatedDate:createdDate];
    [categories addObject:toAdd];
}

static void addNotesFromData(id data, NSMutableArray<NoteCategory *> *categories, NSMutableArray<Note *> *notes) {
    NSArray *notesToAdd = data;
    for (int i=0; i<[data count]; i++) {
        NSDictionary *noteData = [notesToAdd objectAtIndex:i];
        createNoteFromData(noteData, categories, notes);
    }
}

static void createNoteFromData(NSDictionary *noteData, NSMutableArray<NoteCategory *> *categories, NSMutableArray<Note *> *notes) {
    NSUUID *identifier = [[NSUUID alloc] initWithUUIDString:[noteData objectForKey:@"id"]];
    NSString *title = [noteData objectForKey:@"title"];
    NSString *content = [noteData objectForKey:@"content"];
    NSDate *createdDate = getDateFromData(noteData);
    NoteCategory * category = getCategoryFromData(noteData, categories);
    Note *toAdd = [Note withId:identifier withTitle:title withContent:content
               withCreatedDate:createdDate withCategory:category];
    [notes addObject:toAdd];
}

static NoteCategory * getCategoryFromData(NSDictionary *noteData, NSMutableArray<NoteCategory *> *categories) {
    NSInteger categoryId = [[noteData objectForKey:@"categoryId"] integerValue];
    NoteCategory *category = getCategoryForId(categoryId, categories);
    return category;
}

static NoteCategory * getCategoryForId(NSInteger identifier, NSMutableArray<NoteCategory *> *categories) {
    for (int i = 0; i < [categories count]; i++) {
        NoteCategory *item = [categories objectAtIndex:i];
        if (item.identifier == identifier) {
            return item;
        }
    }
    return nil;
}

static NSDate * getDateFromData(NSDictionary *data) {
    NSInteger dateSeconds = [[data objectForKey:@"createdDate"] integerValue];
    NSDate *createdDate = [NSDate dateWithTimeIntervalSince1970:dateSeconds];
    return createdDate;
}

@end
