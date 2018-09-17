//
//  Note.h
//  Notesapp
//
//  Created by Sebastian Uriarte on 9/17/18.
//  Copyright © 2018 OrangeLoops. All rights reserved.
//

#ifndef Note_h
#define Note_h

#import "Category.h"

@interface Note : NSObject

@property NSUUID *identifier;
@property NSString *title;
@property NSString *content;
@property NSDate *createdDate;
@property Category *category;

+ (Note *)withId:(NSUUID *)identifier withTitle:(NSString *)title
     withContent:(NSString *)content withCreatedDate:(NSDate *) createdDate withCategory:(Category *)category;

@end

#endif
