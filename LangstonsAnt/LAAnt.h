//
//  LAAnt.h
//  LangstonsAnt
//
//  Created by Justin Martin on 8/24/13.
//  Copyright (c) 2013 JMM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LAWorld.h"

typedef enum {
    LANorth,
    LAWest,
    LASouth,
    LAEast
} LADirection;


@interface LAAnt : NSObject
@property (nonatomic, strong) LAWorld *world;
@property (nonatomic, assign) CGFloat radialDirection;

+ (LAAnt *)antWithWorld:(LAWorld *)world;

- (CGPoint)position;
- (void)setPosition:(CGPoint)point;
- (void)setDirection:(LADirection)direction;
- (void)step;
- (BOOL)isBlackSquare;
- (int)calculateModWithNegativeValue:(int)value andModNumber:(int)modNum;
- (CGFloat)correctAngleWhenGreaterThan2PI:(CGFloat)angle;

@end
