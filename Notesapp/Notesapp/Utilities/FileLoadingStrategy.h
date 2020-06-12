//
//  JSONFileReader.h
//  Notesapp
//
//  Created by Sebastian Uriarte on 9/17/18.
//  Copyright © 2018 OrangeLoops. All rights reserved.
//

#ifndef JSONFileReader_h
#define JSONFileReader_h

#import "LoadingStrategy.h"

@interface FileLoadingStrategy : NSObject <LoadingStrategy>

- (void) LoadEntities:(NSArray<Note *> *)notes categories:(NSArray<NoteCategory *> *)categories onSuccess:(void(^)(void))success onError:(void(^)(void))error;

@end

#endif
