//
//  LAAntTests.m
//  LangstonsAnt
//
//  Created by Justin Martin on 8/24/13.
//  Copyright (c) 2013 JMM. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LAAnt.h"
#import "LAWorld.h"
@interface LAAntTests : XCTestCase {
    LAWorld *world;
    LAAnt *ant;

}
@end

@implementation LAAntTests
- (void)setUp {
    [super setUp];
    world = [[LAWorld alloc] initWithSize:30];
    ant = [LAAnt antWithWorld:world];
}

-(void) takeSteps:(int)numberOfSteps {
    for (int i = 0; i < numberOfSteps; i++) {
        [ant step];
    }
}

- (void) testAntCanBeInitedWithAWorld {
    XCTAssertEqualObjects(world, ant.world, @"the ant must be inited with a world object.");
}

-(void) testTheAntMustBeInitedWithAWorld {
    XCTAssertThrowsSpecificNamed([LAAnt antWithWorld:nil], NSException, NSInvalidArgumentException, @"The ant must have a world");
}

- (void) testAntMustStartInTheCenterOfTheWorld {
    LAWorld *world1 = [[LAWorld alloc] initWithSize:4];
    LAAnt *ant1 = [LAAnt antWithWorld:world1];
    LAWorld *world2 = [[LAWorld alloc] initWithSize:8];
    LAAnt *ant2 = [LAAnt antWithWorld:world2];
    CGPoint position1 = ant1.position;
    CGPoint position2 = ant2.position;
    
    XCTAssertEqual(CGPointMake(2, 2),position1, @"The ant must start in the center of the world");
    XCTAssertEqual(CGPointMake(4, 4),position2, @"The ant must start in the center of the world");
}

- (void) testAntMustStartInTheCenterOfWorldWithAnOddSize {
    LAWorld *world1 = [[LAWorld alloc] initWithSize:3];
    LAAnt *ant1 = [LAAnt antWithWorld:world1];
    LAWorld *world2 = [[LAWorld alloc] initWithSize:7];
    LAAnt *ant2 = [LAAnt antWithWorld:world2];
    CGPoint position1 = ant1.position;
    CGPoint position2 = ant2.position;
    
    XCTAssertEqual(CGPointMake(1, 1),position1, @"The ant must start in the center of a world with and odd size");
    XCTAssertEqual(CGPointMake(3, 3),position2, @"The ant must start in the center of a world with and odd size");
}

-(void) testTheAntStartsFacingNorth {
    XCTAssertEqual(ant.direction,LANorth, @"its direction is north");
}

-(void) testTheAntCanTakeOneStep {
    [ant step];
    
    XCTAssertEqual(CGPointMake(14, 15),ant.position, @"it takes one step to the left");
    XCTAssertEqual(LABlack, [ant.world valueForPoint:CGPointMake(15, 15)], @"the previous square is now black");
}

-(void) testTheAntCanTakeTwoSteps {
    [self takeSteps:2];

    XCTAssertEqual(CGPointMake(14, 16),ant.position, @"it takes one step down");
    XCTAssertEqual(LABlack, [ant.world valueForPoint:CGPointMake(14, 15)], @"the previous square is now black");
}

-(void) testTheAntCanTakeThreeSteps {
    [self takeSteps:3];
    
    XCTAssertEqual(CGPointMake(15, 16),ant.position, @"it takes one step to the right");
    XCTAssertEqual(LABlack, [ant.world valueForPoint:CGPointMake(14, 16)], @"the previous square is now black");
}

-(void) testTheAntCanTakeFourSteps {
    [self takeSteps:4];
    
    XCTAssertEqual(CGPointMake(15, 15),ant.position, @"it takes one step to the right");
    XCTAssertEqual(LABlack, [ant.world valueForPoint:CGPointMake(15, 16)], @"the previous square is now black");
}

-(void) testTheAntCanTakeFiveSteps {
    [self takeSteps:5];
    XCTAssertEqual(CGPointMake(16, 15),ant.position, @"it takes one step to the right");
    
    XCTAssertEqual(LAWhite, [ant.world valueForPoint:CGPointMake(15, 15)], @"the previous square is now white");
}

@end















































