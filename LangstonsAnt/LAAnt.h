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
    laNORTH = 0,
    laEAST = 1,
    laSOUTH = 2,
    laWEST = 3
} laDIRECTION;

@interface LAAnt : NSObject

@property (nonatomic, strong) LAWorld *world;
@property int x;
@property int y;
@property laDIRECTION direction;


+(LAAnt *) antInWorld:(LAWorld *)world;

-(void) step;

@end
