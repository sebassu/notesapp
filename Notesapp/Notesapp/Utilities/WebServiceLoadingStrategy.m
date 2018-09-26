//
//  NotesLoader+FromWebService.m
//  Notesapp
//
//  Created by Sebastián Uriarte Güimil on 9/20/18.
//  Copyright © 2018 OrangeLoops. All rights reserved.
//

#import "WebServiceLoadingStrategy.h"
#import "JSONParser.h"

@implementation WebServiceLoadingStrategy

- (void)LoadEntities:(nonnull NSArray<Note *> *)notes categories:(nonnull NSArray<Category *> *)categories onSuccess:(nonnull void (^)(void))success onError:(nonnull void (^)(void))error {
    NSString *dataUrl = @"https://s3.amazonaws.com/kezmo.assets/sandbox/notes.json";
    NSURL *url = [NSURL URLWithString:dataUrl];
    NSURLSessionDataTask *downloadTask =
    [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *requestError) {
        if(requestError == nil){
            [self processNoteData:data notes:notes categories:categories onSuccess:success onError:error];
        }else{
            [self runOnMainThread:error];
        }
    }];
    [downloadTask resume];
}

- (void) processNoteData:(NSData *)requestData notes:(nonnull NSArray<Note *> *)notes categories:(nonnull NSArray<Category *> *)categories onSuccess:(void(^)(void))success onError:(void(^)(void))error {
    NSError *parsingError;
    id data = [NSJSONSerialization JSONObjectWithData:requestData options:0 error:&parsingError];
    if(parsingError == nil) {
        [JSONParser createEntitiesFrom:data notes:notes categories:categories];
        [self runOnMainThread:success];
    }else{
        [self runOnMainThread:error];
    }
}

- (void)runOnMainThread:(void (^)(void))action {
    dispatch_async(dispatch_get_main_queue(), ^{
        action();
    });
}

@end
