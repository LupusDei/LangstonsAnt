//
//  LAAntTests.m
//  LangstonsAnt
//
//  Created by Justin Martin on 8/24/13.
//  Copyright (c) 2013 JMM. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LAAnt.h"


/*    RULES
 The ant starts out facing North
 At a white square, turn 90° left, flip the color of the square, move forward one unit
 At a black square, turn 90° right, flip the color of the square, move forward one unit
 
 */

@interface LAAntTests : XCTestCase

@end

@implementation LAAntTests {
    LAWorld *world;
    LAAnt *ant;
}

-(void) setUp {
    world = [LAWorld newWorldWithSize:10 andListener:nil];
    ant = [LAAnt antWithWorld:world];
}

-(void) takeSteps:(int)steps {
    for (int i = 0; i < steps; i++) {
        [ant step:nil];
    }
}

- (void) testBeginsInTheCenter {
    XCTAssertEqualObjects((@[@5,@5]), ant.location);
    XCTAssertEqualObjects((@[@10,@10]),
                          [LAAnt antWithWorld:[LAWorld newWorldWithSize: 20 andListener:nil]].location);
    
}

- (void) testFirstStep {
    [ant step: (Nil)];
    XCTAssertEqualObjects((@[@4,@5]),ant.location);
}

- (void) testSecondStep {
    [self takeSteps:2];
    XCTAssertEqualObjects((@[@4,@6]),ant.location);
}

- (void) testThirdStep {
    [self takeSteps:3];
    XCTAssertEqualObjects((@[@5,@6]),ant.location);
}

- (void) testFourthStep {
    [self takeSteps:4];
    XCTAssertEqualObjects((@[@5,@5]),ant.location);
}

- (void) testFifthStep {
    [self takeSteps:5];
    XCTAssertEqualObjects((@[@6,@5]),ant.location);
}

- (void) testFirstStepOnBlack {
    [world paintBlack];
    [ant step: (Nil)];
    XCTAssertEqualObjects((@[@6,@5]),ant.location);
}

- (void) testSecondStepOnBlack {
    [world paintBlack];
    [self takeSteps:2];
    XCTAssertEqualObjects((@[@6,@6]),ant.location);
}

- (void) testThirdStepOnBlack {
    [world paintBlack];
    [self takeSteps:3];
    XCTAssertEqualObjects((@[@5,@6]),ant.location);
}

- (void) testFourthStepOnBlack {
    [world paintBlack];
    [self takeSteps:4];
    XCTAssertEqualObjects((@[@5,@5]),ant.location);
}

- (void) testFifthStepOnBlack {
    [world paintBlack];
    [self takeSteps:5];
    XCTAssertEqualObjects((@[@4,@5]),ant.location);
}
@end
