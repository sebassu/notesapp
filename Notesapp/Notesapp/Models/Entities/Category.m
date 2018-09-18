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
+ (Category *)withId:(NSInteger)identifier withTitle:(NSString *)title withCreatedDate:(NSDate *) createdDate {
    Category* result = [super init];
    if (result) {
        result.identifier = identifier;
        result.title = title;
        result.createdDate = createdDate;
    }
    return result;
}
@end
