//
//  JSONFileReader.m
//  Notesapp
//
//  Created by Sebastian Uriarte on 9/17/18.
//  Copyright © 2018 OrangeLoops. All rights reserved.
//

#import "JSONParser.h"
#import "FileLoadingStrategy.h"

@implementation FileLoadingStrategy

- (void)LoadEntities:(nonnull NSArray<Note *> *)notes categories:(nonnull NSArray<NoteCategory *> *)categories onSuccess:(nonnull void (^)(void))success onError:(nonnull void (^)(void))error {
    NSError *parsingError;
    id data = attemptToGetJSONFromFile(&parsingError);
    if (error == nil) {
        [JSONParser createEntitiesFrom:data notes:notes categories:categories];
    }
}

static id attemptToGetJSONFromFile(NSError ** error) {
    NSString *path  = [[NSBundle mainBundle] pathForResource:@"notes" ofType:@"json"];
    NSInputStream *jsonStream = [NSInputStream inputStreamWithFileAtPath:path];
    [jsonStream open];
    return [NSJSONSerialization JSONObjectWithStream:jsonStream options:0 error:error];
}

@end
