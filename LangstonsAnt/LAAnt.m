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
@end

@implementation LAAnt

+ (CGFloat)radiansForDirection:(LADirection)direction {
    CGFloat radians;
    switch (direction) {
        case LANorth:
            radians = M_PI_2;
            break;
        case LAEast:
            radians = 0;
            break;
        case LASouth:
            radians = M_PI_2 * -1;
            break;
        case LAWest:
            radians = M_PI;
            break;
    }
    return radians;
}

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
    ant.radialDirection = (CGFloat)M_PI_2;
    return ant;
}

-(CGPoint) position {
    return CGPointMake(self.x, self.y);
}

-(void) setPosition:(CGPoint)point {
    self.x = point.x;
    self.y = point.y;
}

- (void)setDirection:(LADirection)direction {
    self.radialDirection = [LAAnt radiansForDirection:direction];
}

- (void)step {
    CGPoint lastPos = self.position;
    self.radialDirection += (CGFloat)M_PI_2 * [self directionVectorFromSquareColor];
    if (self.radialDirection <= 2 * M_PI + 0.00001 || self.radialDirection >= 2 * M_PI - 0.00001 || self.radialDirection >= -2 * M_PI - 0.00001 || self.radialDirection <= -2 * M_PI + 0.00001) {
        self.radialDirection = 0;
    }
    
    self.x = self.x + cosf(self.radialDirection);
    self.y = self.y - sinf(self.radialDirection);
    [self.world toggleSquare:lastPos];
    
    self.x = [self calculateModWithNegativeValue:self.x andModNumber:self.world.size];
    self.y = [self calculateModWithNegativeValue:self.y andModNumber:self.world.size];
}

-(int) calculateModWithNegativeValue:(int)value andModNumber:(int)modNum {
    value = value % modNum;
    if (value < 0) {
        value = [self adjustModAnswerForNegativeValue:value andModNumber:modNum];
    }
    return value;
}

- (int)adjustModAnswerForNegativeValue:(int)value andModNumber:(int)modNum {
    return modNum + value;
}

- (BOOL)isBlackSquare {
    return [self.world valueForPoint:[self position]];
}

-(int) directionVectorFromSquareColor {
    return [self isBlackSquare] ? -1 : 1;
}

@end













































