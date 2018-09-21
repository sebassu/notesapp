//
//  JSONFileReader.m
//  Notesapp
//
//  Created by Sebastian Uriarte on 9/17/18.
//  Copyright © 2018 OrangeLoops. All rights reserved.
//

#import "Category.h"
#import "EntityManager.h"
#import "NotesLoader+FromFile.h"

@implementation NotesLoader (FromFile)

+ (BOOL) loadEntitiesFromJSONFile {
    NSError *error;
    id data = attemptToGetJSONFromFile(&error);
    if (error == nil) {
        [self createEntitiesFromFullData:data];
        return YES;
    } else {
        return NO;
    }
}

static id attemptToGetJSONFromFile(NSError ** error) {
    NSString *path  = [[NSBundle mainBundle] pathForResource:@"notes" ofType:@"json"];
    NSInputStream *jsonStream = [NSInputStream inputStreamWithFileAtPath:path];
    [jsonStream open];
    return [NSJSONSerialization JSONObjectWithStream:jsonStream options:0 error:error];
}

@end
