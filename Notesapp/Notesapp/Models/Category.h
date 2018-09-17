//
//  Category.h
//  Notesapp
//
//  Created by Sebastian Uriarte on 9/17/18.
//  Copyright © 2018 OrangeLoops. All rights reserved.
//

#ifndef Category_h
#define Category_h

@interface Category : NSObject

@property NSInteger identifier;
@property NSString *title;
@property NSDate *createdDate;

+ (Category *)withId:(NSInteger)identifier withTitle:(NSString *)title withCreatedDate:(NSDate *) createdDate;

@end

#endif
