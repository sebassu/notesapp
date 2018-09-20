//
//  JSONFileReader.h
//  Notesapp
//
//  Created by Sebastian Uriarte on 9/17/18.
//  Copyright © 2018 OrangeLoops. All rights reserved.
//

#ifndef JSONFileReader_h
#define JSONFileReader_h

#import "NotesLoader.h"

@interface NotesLoader (FromFile)

+ (BOOL)loadEntitiesFromJSONFile;

@end

#endif
