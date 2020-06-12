//
//  NotesLoader.h
//  Notesapp
//
//  Created by Sebastián Uriarte Güimil on 9/21/18.
//  Copyright © 2018 OrangeLoops. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Note.h"
#import "NoteCategory.h"

NS_ASSUME_NONNULL_BEGIN

@protocol LoadingStrategy

- (void) LoadEntities:(NSArray<Note *> *)notes categories:(NSArray<NoteCategory *> *)categories onSuccess:(void(^)(void))success onError:(void(^)(void))error;

@end

NS_ASSUME_NONNULL_END
