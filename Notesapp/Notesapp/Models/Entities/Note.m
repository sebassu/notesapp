#import "Note.h"

@implementation Note

+ (instancetype) withId:(NSUUID *)identifier withTitle:(NSString *)title
            withContent:(NSString *)content withCreatedDate:(NSDate *) createdDate withCategory:(NoteCategory *)category {
    return [[self alloc] initWithId:identifier title:title
                            content:content createdDate:createdDate category:category];
}

- (id) initWithId:(NSUUID *) identifier title:(NSString *)title
          content:(NSString *)content createdDate:(NSDate *) createdDate category:(NoteCategory *)category {
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
