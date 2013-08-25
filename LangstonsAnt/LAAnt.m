//
//  LAAnt.m
//  LangstonsAnt
//
//  Created by Justin Martin on 8/24/13.
//  Copyright (c) 2013 JMM. All rights reserved.
//

#import "LAAnt.h"

/*    RULES
 The ant starts out facing North
 At a white square, turn 90° left, flip the color of the square, move forward one unit
 At a black square, turn 90° right, flip the color of the square, move forward one unit
 
*/

typedef void (^LADirectionStep)();

@interface LAAnt()
@property (strong, nonatomic) NSArray *steps;
@end

@implementation LAAnt

-(id) init {
    self = [super init];
    if (self) {
        [self setInstructionsForDirections];
    }
    return self;
}

+(LAAnt *) antInWorld:(LAWorld *)world {
    LAAnt *ant = [[LAAnt alloc] init];
    ant.world = world;
    ant.x = world.size / 2;
    ant.y = world.size / 2;
    ant.direction = laNORTH;
    return ant;
}

-(void) setInstructionsForDirections {
    LADirectionStep west = ^{self.x--;};
    LADirectionStep south = ^{self.y++;};
    LADirectionStep east = ^{self.x++;};
    LADirectionStep north = ^{self.y--;};
    self.steps = @[north,east,south,west];
}

-(void) step {
    if ([self.world isWhiteSquareAtX:self.x Y:self.y]) {
        [self.world setBlackSquareAtX:self.x Y:self.y];
        self.direction = (self.direction - 1) % 4;
    }
    else {
        [self.world setWhiteSquareAtX:self.x Y:self.y];
        self.direction = (self.direction + 1) % 4;
    }
    
    ((LADirectionStep) [self.steps objectAtIndex:self.direction])();
    [self warpHorizontally];
    [self warpVertically];
}

-(void) warpHorizontally {
    self.x = self.x % self.world.size;
    if (self.x < 0) self.x += self.world.size;
}

-(void) warpVertically {
    self.y = self.y % self.world.size;
    if (self.y < 0) self.y += self.world.size;
}

@end
