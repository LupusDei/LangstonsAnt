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
@property LADirection direction;

+ (LAAnt *)antWithWorld:(LAWorld *)world;

-(CGPoint) position;
- (void)step;
- (BOOL)isBlackSquare;

@end
