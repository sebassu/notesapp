#ifndef Category_h
#define Category_h

#import <Foundation/Foundation.h>

@interface Category : NSObject

@property (nonatomic, assign) NSInteger identifier;
@property (nonatomic, strong, nonnull) NSString *title;
@property (nonatomic, strong, nonnull) NSDate *createdDate;

+ (nonnull Category *) withId:(NSInteger)identifier withTitle:(nonnull NSString *)title withCreatedDate:(nonnull NSDate *) createdDate;

- (nonnull id) initWithId:(NSInteger) identifier title:(nonnull NSString *)title createdDate:(nonnull NSDate *) createdDate;
- (BOOL) isEqual:(nullable id)object;

@end

#endif
