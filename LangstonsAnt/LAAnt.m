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


@interface LAAnt()
@property (nonatomic, strong) LAWorld *world;
@end

@implementation LAAnt
int x;
int y;

+(LAAnt *) newAntAtX:(int)newX andY:(int)newY {
    LAAnt *ant = [[LAAnt alloc] init];
    ant.direction = 'n';
    x = newX;
    y = newY;
    return ant;
}

+(LAAnt *) antWithWorld:(LAWorld *)world {
    LAAnt *ant = [[LAAnt alloc] init];
    ant.world = world;
    ant.direction =  'n';
    x = world.size/2;
    y = world.size /2;
    return ant;
}

-(NSDictionary *) step:(NSDictionary *)world {
    bool onWhite = [self.world isSquareWhiteAtX:x andY:y];
    [self.world toggleSquareAtX:x andY:y];
    
    if(self.direction == 'n')
    {
        self.direction = onWhite ? 'w' : 'e';
        x += onWhite ? -1 : 1;
    }
    else if(self.direction == 'w')
    {
        y += onWhite ? 1 : -1;
        self.direction = onWhite ? 's' : 'n';
    }
    else if(self.direction == 's')
    {
        x += onWhite ? 1 : -1;
        self.direction = onWhite ? 'e' : 'w';
    }
    else
    {
        y += onWhite ? -1 : 1;
        self.direction = onWhite ? 'n' : 's';
    }
    return nil;
}

-(NSArray *) location {
    return @[[NSNumber numberWithInt:x], [NSNumber numberWithInt:y]];
}


@end
