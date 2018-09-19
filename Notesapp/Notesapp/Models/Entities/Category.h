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

@property (nonatomic, assign) NSInteger identifier;
@property (nonatomic, strong, nonnull) NSString *title;
@property (nonatomic, strong, nonnull) NSDate *createdDate;

+ (Category *) withId:(NSInteger)identifier withTitle:(NSString *)title withCreatedDate:(NSDate *) createdDate;

- (id) initWithId:(NSInteger) identifier title:(NSString *)title createdDate:(NSDate *) createdDate;
- (BOOL) isEqual:(id)object;

@end

#endif
