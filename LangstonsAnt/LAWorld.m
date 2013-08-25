//
//  LAWorld.m
//  LangstonsAnt
//
//  Created by Justin Martin on 8/24/13.
//  Copyright (c) 2013 JMM. All rights reserved.
//

#import "LAWorld.h"

@implementation LAWorld

+(LAWorld *) worldWithSize:(NSInteger)size {
    LAWorld *world = [[LAWorld alloc] initWithSize:size];
    return world;
}

-(id) initWithSize:(NSInteger)size {
    self = [super init];
    if (self) {
        self.size = size;
        self.squares = [NSMutableArray arrayWithCapacity:size];
        for (int x = 0; x < size; x++) {
            NSMutableArray *row = [NSMutableArray arrayWithCapacity:size];
            [self.squares addObject:row];
            for (int y = 0; y < size; y++) {
                [row addObject:[NSNumber numberWithInt:0]];
            }
        }
    }
    return self;
}

@end
