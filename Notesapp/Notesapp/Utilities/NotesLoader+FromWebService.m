//
//  NotesLoader+FromWebService.m
//  Notesapp
//
//  Created by Sebastián Uriarte Güimil on 9/20/18.
//  Copyright © 2018 OrangeLoops. All rights reserved.
//

#import "NotesLoader+FromWebService.h"

@implementation NotesLoader (FromWebService)

+ (BOOL)loadEntitiesFromWebService:(void(^)(void))success onError:(void(^)(void))error {
    NSString *dataUrl = @"https://s3.amazonaws.com/kezmo.assets/sandbox/notes.json";
    NSURL *url = [NSURL URLWithString:dataUrl];
    NSURLSessionDataTask *downloadTask =
    [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *requestError) {
        if(requestError == nil){
            [self processNoteData:data onSuccess:success onError:error];
        }else{
            error();
        }
    }];
    [downloadTask resume];
    return YES;
}

+ (void) processNoteData:(NSData *)requestData onSuccess:(void(^)(void))success onError:(void(^)(void))error{
    NSError *parsingError;
    id notesData = [NSJSONSerialization JSONObjectWithData:requestData options:0 error:&parsingError];
    if(parsingError == nil) {
        [self createEntitiesFromFullData:notesData];
        success();
    }else{
        error();
    }
}

@end
