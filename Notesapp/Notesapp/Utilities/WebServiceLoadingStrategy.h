//
//  NotesLoader+FromWebService.h
//  Notesapp
//
//  Created by Sebastián Uriarte Güimil on 9/20/18.
//  Copyright © 2018 OrangeLoops. All rights reserved.
//

#import "LoadingStrategy.h"

@interface WebServiceLoadingStrategy : NSObject <LoadingStrategy>

- (void) LoadEntities:(NSArray<Note *> *)notes categories:(NSArray<Category *> *)categories onSuccess:(void(^)(void))success onError:(void(^)(void))error;

@end
