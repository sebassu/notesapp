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

+ (instancetype) withId:(NSUUID *)identifier withTitle:(NSString *)title
           withContent:(NSString *)content withCreatedDate:(NSDate *) createdDate withCategory:(Category *)category {
    return [[self alloc] initWithId:identifier title:title
                            content:content createdDate:createdDate category:category];
}

- (id) initWithId:(NSUUID *) identifier title:(NSString *)title
          content:(NSString *)content createdDate:(NSDate *) createdDate category:(Category *)category {
    if (self = [super init]) {
        self.identifier = identifier;
        self.title = title;
        self.content = content;
        self.createdDate = createdDate;
        self.category = category;
    }
    return self;
}

@end
