//
//  LABlackWorld.m
//  LangstonsAnt
//
//  Created by hatebyte on 9/27/13.
//  Copyright (c) 2013 JMM. All rights reserved.
//

#import "LABlackWorld.h"

@implementation LABlackWorld

-(id) initWithSize:(int)size {
    self = [super init];
    if (self) {
        self.size = size;
        NSMutableArray *rows = [[NSMutableArray alloc] init];
        for (int i = 0; i < size; i++) {
            NSMutableArray *col = [[NSMutableArray alloc] init];
            for (int j = 0; j < size; j++) {
                [col addObject:[NSNumber numberWithBool:LABlack]];
            }
            [rows addObject:col];
        }
        squares = rows;
    }
    return self;
}

@end
