//
//  LAWorld.m
//  LangstonsAnt
//
//  Created by Justin Martin on 8/24/13.
//  Copyright (c) 2013 JMM. All rights reserved.
//

#import "LAWorld.h"

@implementation LAWorld

bool **squares;

+(LAWorld *) newWorldWithSize:(int) size andListener: (id <WorldListener>)listener
{
    LAWorld *world =  [[LAWorld alloc] init];
    world.size = size;
    world.worldListener = listener;
    squares = malloc(size * sizeof(bool*));
    for(int i = 0; i < size; i++)
    {
        squares[i] = malloc(size * sizeof(bool));
        for(int j = 0; j < size; j++) {
            squares[i][j] = true;
        }
    }
    return world;
}

-(BOOL) isSquareWhiteAtX: (int) x andY: (int) y {
    return squares[x][y];
}
-(BOOL) isSquareBlackAtX: (int) x andY: (int) y {
    return !squares[x][y];
}

-(void) toggleSquareAtX: (int) x andY: (int) y {
    bool value = !squares[x][y];
    squares[x][y] = value;
    [self.worldListener updateSquareAtX:x Y:y to:value];
}

-(void) paintBlack {
    for (int i = 0; i < self.size; i++) {
        for(int j = 0; j < self.size; j++) {
            squares[i][j] = false;
        }
    }
}

@end
