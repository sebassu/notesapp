//
//  NotesLoader+FromWebService.m
//  Notesapp
//
//  Created by Sebastián Uriarte Güimil on 9/20/18.
//  Copyright © 2018 OrangeLoops. All rights reserved.
//

#import "NotesLoader+FromWebService.h"

@implementation NotesLoader (FromWebService)

+ (BOOL)loadEntitiesFromWebService {
    NSString *dataUrl = @"https://s3.amazonaws.com/kezmo.assets/sandbox/notes.json";
    NSURL *url = [NSURL URLWithString:dataUrl];
    NSURLSessionDataTask *downloadTask =
    [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        [self processNoteData:data];
    }];
    [downloadTask resume];
    return YES;
}

+ (void) processNoteData:(NSData *)requestData {
    NSError *error;
    id notesData = [NSJSONSerialization JSONObjectWithData:requestData options:0 error:&error];
    [self createEntitiesFromFullData:notesData];
}

@end
