//
//  Category.m
//  Notesapp
//
//  Created by Sebastian Uriarte on 9/17/18.
//  Copyright © 2018 OrangeLoops. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Category.h"

@implementation Category

+ (Category *) withId:(NSInteger)identifier withTitle:(NSString *)title withCreatedDate:(NSDate *) createdDate {
    return [[self alloc] initWithId:identifier title:title createdDate:createdDate];
}

- (id) initWithId:(NSInteger) identifier title:(NSString *)title createdDate:(NSDate *) createdDate {
    if(self = [super init]) {
        self.identifier = identifier;
        self.title = title;
        self.createdDate = createdDate;
    }
    return self;
}

@end
