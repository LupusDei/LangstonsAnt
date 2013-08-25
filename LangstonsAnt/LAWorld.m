//
//  LAWorld.m
//  LangstonsAnt
//
//  Created by Justin Martin on 8/24/13.
//  Copyright (c) 2013 JMM. All rights reserved.
//

#import "LAWorld.h"


#define WhiteSquare 0
#define BlackSquare 1


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
                [row addObject:[NSNumber numberWithInt:WhiteSquare]];
            }
        }
    }
    return self;
}

-(BOOL) isWhiteSquareAtX:(int)x Y:(int)y {
    NSNumber *square = [[self.squares objectAtIndex:x] objectAtIndex:y];
    return [square integerValue] == WhiteSquare;
}

-(BOOL) isBlackSquareAtX:(int)x Y:(int)y {
    NSNumber *square = [[self.squares objectAtIndex:x] objectAtIndex:y];
    return [square integerValue] == BlackSquare;
}

-(void) setBlackSquareAtX:(int)x Y:(int)y {
    [[self.squares objectAtIndex:x] setObject:[NSNumber numberWithInt:BlackSquare] atIndex:y];
    [self.display updateSquareAtX:x Y:y toColor:[UIColor blackColor]];
}

-(void) setWhiteSquareAtX:(int)x Y:(int)y {
    [[self.squares objectAtIndex:x] setObject:[NSNumber numberWithInt:WhiteSquare] atIndex:y];
    [self.display updateSquareAtX:x Y:y toColor:[UIColor whiteColor]];
}

@end
