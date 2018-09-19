//
//  ViewController.m
//  Notesapp
//
//  Created by Sebastian Uriarte on 9/17/18.
//  Copyright © 2018 OrangeLoops. All rights reserved.
//

#import "ViewController.h"
#import "EntityManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    self.textView.text = getTextToDisplay();
}

static NSString * getTextToDisplay() {
    NSMutableString* result = [[NSMutableString alloc] init];
    id notes = EntityManager.instance.notes;
    for (int i = 0; i < [notes count]; i++) {
        Note *note = [notes objectAtIndex:i];
        appendNoteData(note, result);
    }
    return result;
}

static void appendNoteData(Note *note, NSMutableString *result) {
    [result appendString:note.title];
    [result appendString:@"\n"];
    [result appendString:note.content];
    [result appendString:@"\n\n"];
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
