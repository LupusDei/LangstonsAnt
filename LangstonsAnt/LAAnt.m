//
//  LAAnt.m
//  LangstonsAnt
//
//  Created by Justin Martin on 8/24/13.
//  Copyright (c) 2013 JMM. All rights reserved.
//

#import "LAAnt.h"

/*    RULES
 The ant starts in the center, facing North
 At a white square, turn 90° left, flip the color of the square, move forward one unit
 At a black square, turn 90° right, flip the color of the square, move forward one unit
 
*/

@interface LAAnt()
@property NSInteger x;
@property NSInteger y;
@property double radialDirection;
@end

@implementation LAAnt

+ (LAAnt *)antWithWorld:(LAWorld *)world {
    LAAnt *ant = [[LAAnt alloc] init];
    if (!world) {
        [[[NSException alloc] initWithName:NSInvalidArgumentException
                                    reason:@"The ant must have a world"
                                  userInfo:nil] raise];
    }
    ant.world = world;
    ant.x = ant.world.size * .5;
    ant.y = ant.world.size * .5;
    ant.radialDirection = M_PI_2;
    return ant;
}

-(CGPoint) position {
    return CGPointMake(self.x, self.y);
}

- (void)step {
    CGPoint lastPos = self.position;
    self.radialDirection += M_PI_2 * [self directionVectorFromSquareColor];
    self.x = self.x + cos(self.radialDirection);
    self.y = self.y - sin(self.radialDirection);
    [self.world toggleSquare:lastPos];
}

- (BOOL)isBlackSquare {
    return [self.world valueForPoint:[self position]];
}

-(int) directionVectorFromSquareColor {
    return [self isBlackSquare] ? -1 : 1;
}

@end













































