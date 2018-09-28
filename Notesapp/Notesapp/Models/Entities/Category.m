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

- (BOOL) isEqual:(id)other {
    if (other == self) {
        return YES;
    } else if (!other || ![other isKindOfClass:[self class]]) {
        return NO;
    } else {
        return [self isEqualToCategory:other];
    }
}

- (BOOL) isEqualToCategory:(Category *)other {
    return  [self identifier] == [other identifier];
}

@end
