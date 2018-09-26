//
//  Category.m
//  Notesapp
//
//  Created by Sebastian Uriarte on 9/17/18.
//  Copyright © 2018 OrangeLoops. All rights reserved.
//

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

- (BOOL)isEqual:(id)other {
    if (other == self) {
        return YES;
    } else if (!other || ![other isKindOfClass:[self class]]) {
        return NO;
    } else {
        return [self isEqualToCategory:other];
    }
}

- (BOOL)isEqualToCategory:(Category *)other {
    if (self == other) {
        return YES;
    } else if ([self identifier] != [other identifier]) {
        return NO;
    } else {
        return YES;
    }
}

@end
