//
//  JSONFileReader.m
//  Notesapp
//
//  Created by Sebastian Uriarte on 9/17/18.
//  Copyright © 2018 OrangeLoops. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONFileReader.h"
#import "Category.h"

@implementation JSONFileReader

+ (void)loadEntitiesFromJSONFile {
    NSError *error;
    id data = [self attemptToGetJSONFromFile:&error];
    [self createEntitiesFromFullData:data];
}

+ (void)createEntitiesFromFullData:(id)fullData {
    NSDictionary *results = fullData;
    [self addCategoriesFromData:[results objectForKey:@"categories"]];
}

+ (void)addNotesFromData:(id)data {
    NSArray *notes = data;
    for (int i=0; i<[data count]; i++) {
        NSDictionary *noteData = [notes objectAtIndex:i];
        [self createNoteFromData:noteData];
    }
}

+ (void)createNoteFromData:(NSDictionary *)categoryData {
    NSUUID *identifier = [[NSUUID alloc]initWithUUIDString:[categoryData objectForKey:@"id"]];
    NSString *title = [categoryData objectForKey:@"title"];
    NSString *content = [categoryData objectForKey:@"content"];
    NSInteger dateSeconds = [[categoryData objectForKey:@"createdDate"] integerValue];
    NSDate *createdDate = [NSDate dateWithTimeIntervalSince1970:dateSeconds];
    //TODO: Get category from id and create and add note to somewhare
}

+ (void)addCategoriesFromData:(id)data {
    NSArray *categories = data;
    for (int i=0; i<[data count]; i++) {
        NSDictionary *categoryData = [categories objectAtIndex:i];
        [self createCategoryFromData:categoryData];
    }
}

+ (void)createCategoryFromData:(NSDictionary *)categoryData {
    NSInteger identifier = [[categoryData objectForKey:@"id"] integerValue];
    NSString *title = [categoryData objectForKey:@"title"];
    NSInteger dateSeconds = [[categoryData objectForKey:@"createdDate"] integerValue];
    NSDate *createdDate = [NSDate dateWithTimeIntervalSince1970:dateSeconds];
    Category *toAdd = [Category withId:identifier withTitle:title withCreatedDate:createdDate];
}

+ (id)attemptToGetJSONFromFile:(NSError **)error {
    NSString* path  = [[NSBundle mainBundle] pathForResource:@"notes" ofType:@"json"];
    NSInputStream* jsonStream = [NSInputStream inputStreamWithFileAtPath:path];
    [jsonStream open];
    return [NSJSONSerialization JSONObjectWithStream:jsonStream options:0 error:error];
}
@end
