//
//  Note.m
//  Notesapp
//
//  Created by Sebastian Uriarte on 9/17/18.
//  Copyright © 2018 OrangeLoops. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Note.h"

@implementation Note
+ (Note *)withId:(NSUUID *)identifier withTitle:(NSString *)title
     withContent:(NSString *)content withCreatedDate:(NSDate *) createdDate withCategory:(Category *)category {
    Note* result = [super init];
    if (result) {
        result.identifier = identifier;
        result.title = title;
        result.content = content;
        result.createdDate = createdDate;
        result.category = category;
    }
    return result;
}
@end
