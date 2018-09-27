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

@property (nonatomic, strong, nonnull) NSUUID *identifier;
@property (nonatomic, strong, nonnull) NSString *title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong, nonnull) NSDate *createdDate;
@property (nonatomic, strong) Category *category;

+ (instancetype) withId:(NSUUID *)identifier withTitle:(NSString *)title
            withContent:(NSString *)content withCreatedDate:(NSDate *) createdDate withCategory:(Category *)category;

- (id) initWithId:(NSUUID *) identifier title:(NSString *)title
          content:(NSString *)content createdDate:(NSDate *) createdDate category:(Category *)category;

@end

#endif
