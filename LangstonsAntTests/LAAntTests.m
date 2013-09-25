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
    XCTAssertEqual((CGFloat)M_PI_2, ant.radialDirection, @"its direction is north");
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
    
    XCTAssertEqual(CGPointMake(15, 16), ant.position, @"it takes one step to the right");
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

- (void) testTheAntCanTakeSixSteps {
    [self takeSteps:6];

    XCTAssertEqual(CGPointMake(16, 14), ant.position, @"The ant should take on step up");
    XCTAssertEqual(LABlack, [ant.world valueForPoint:CGPointMake(16, 15)], @"the previous square is now white");
}

- (void) testTheAntCannotLeaveTheWorldWithoutWrappingToTheOppositeSide {
    [ant setPosition:CGPointMake(0, 0)];
    [ant step];
    XCTAssertEqual(CGPointMake(world.size-1, 0), [ant position], @"The ants position should be 29,0");

    [ant setDirection:LASouth];
    [ant step];
    XCTAssertEqual(CGPointMake(0, 0), [ant position], @"The ant's position should no be 0,0");
}

- (void) testTheAntWillWrapVerticallyWhenAtTheTop {
    [ant setPosition:CGPointMake(15, 0)];
    [ant setDirection:LAEast];
    [ant step];
    XCTAssertEqual(CGPointMake(15, 29), [ant position], @"The ant started facing east, turned left to face north, and wrapped around the world ending at the bottom of the grid");
    
    [ant setDirection:LAWest];
    [ant step];
    XCTAssertEqual(CGPointMake(15, 0), [ant position], @"The ant's position should no be 15, 0");

}

- (void) testAntCanMoveInAllDirectionsFromZeroZeroAnDirectionIsEast {
    [ant setPosition:CGPointMake(0, 0)];
    [ant setDirection:LAEast];
    [ant step];
    XCTAssertEqual(CGPointMake(0, 29), ant.position, @"The ant should be in the bottom left");
}

- (void) testAntCanMoveInAllDirectionsFromZeroZeroAnDirectionWest {
    [ant setPosition:CGPointMake(0, 0)];
    [ant setDirection:LANorth];
    [ant step];
    XCTAssertEqual(CGPointMake(29, 0), ant.position, @"The ant should be in square 1,0");
}

- (void) testWorldIsReturningCorrectModuloForNegativeOne {
    int modVal = [ant calculateModWithNegativeValue:-1 andModNumber:30];
    XCTAssertEqual(29, modVal, @"The value for -1 should be corrected to 29");
}
- (void) testWorldIsReturningCorrectModuloForThirty {
    int modVal = [ant calculateModWithNegativeValue:30 andModNumber:30];
    XCTAssertEqual(0, modVal, @"The value for 30 should be corrected to 0");
}

@end
























































