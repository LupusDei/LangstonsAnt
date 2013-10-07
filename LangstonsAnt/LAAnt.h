//
//  LAAnt.h
//  LangstonsAnt
//
//  Created by Justin Martin on 8/24/13.
//  Copyright (c) 2013 JMM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LAWorld.h"


@interface LAAnt : NSObject
@property char direction;

+(LAAnt *) newAntAtX:(int)x andY:(int)y;
+(LAAnt *) antWithWorld:(LAWorld *)world;

-(NSDictionary *) step:(NSDictionary *)world;

-(NSArray *) location;

@end
