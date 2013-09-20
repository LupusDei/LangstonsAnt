//
//  LAWorld.m
//  LangstonsAnt
//
//  Created by Justin Martin on 8/24/13.
//  Copyright (c) 2013 JMM. All rights reserved.
//

#import "LAWorld.h"

@interface LAWorld () {
    NSMutableArray *squares;
}

@end


@implementation LAWorld
@synthesize size = _size;

-(id) initWithSize:(int)size {
    self = [super init];
    if (self) {
        self.size = size;

        NSMutableArray *rows = [[NSMutableArray alloc] init];
        for (int i = 0; i < size; i++) {
            NSMutableArray *col = [[NSMutableArray alloc] init];
            for (int j = 0; j < size; j++) {
                [col addObject:[NSNumber numberWithBool:LAWhite]];
            }
            [rows addObject:col];
        }
        squares = rows;
    }
    return self;
}

-(void) setSize:(int)size {
    if ([self isValidSize:size]) {
        _size = size;
    }
    else {
        [[[NSException alloc] initWithName:NSInvalidArgumentException
                                    reason:@"The world's size can't have a negative value"
                                  userInfo:nil] raise];
    }
}

-(int) size {
    return _size;
}

-(BOOL) isValidSize:(int)size {
    return (size > 0);
}

-(BOOL) valueForPoint:(CGPoint)point {
    if (point.x > _size || point.y > _size) {
        [[[NSException alloc] initWithName:NSInvalidArgumentException
                                    reason:@"The square is outside the grids boundaries"
                                  userInfo:nil] raise];
    }
    NSMutableArray *row = [squares objectAtIndex:point.x];
    NSNumber *square = [row objectAtIndex:point.y];
    return square.boolValue;
}

- (void)setSquareAtPoint:(CGPoint)point toValue:(BOOL)value {
    NSMutableArray *row = [squares objectAtIndex:point.x];
    [row replaceObjectAtIndex:point.y withObject:[NSNumber numberWithBool:value]];
}

- (void)toggleSquare:(CGPoint)point {
    [self setSquareAtPoint:point toValue:![self valueForPoint:point]];
}


@end
