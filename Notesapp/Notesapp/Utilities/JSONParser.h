//
//  JSONParser.h
//  Notesapp
//
//  Created by Sebastián Uriarte Güimil on 9/21/18.
//  Copyright © 2018 OrangeLoops. All rights reserved.
//

#ifndef JSONParser_h
#define JSONParser_h

#import "Note.h"
#import "NoteCategory.h"

@interface JSONParser : NSObject

+ (void) createEntitiesFrom:(NSData *)data notes:(NSArray<Note *> *)notes categories:(NSArray<NoteCategory *> *)categories;

@end

#endif
