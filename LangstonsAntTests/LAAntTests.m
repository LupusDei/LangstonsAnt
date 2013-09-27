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
#import "LABlackWorld.h"

@interface LAAntTests : XCTestCase {
    LAWorld *world;
    LAAnt *ant;
    LAWorld *worldBlack;
    LAAnt *antBlack;

}
@end

@implementation LAAntTests
- (void)setUp {
    [super setUp];
    world = [[LAWorld alloc] initWithSize:10];
    ant = [LAAnt antWithWorld:world];
    
    worldBlack = [[LABlackWorld alloc] initWithSize:10];
    antBlack = [LAAnt antWithWorld:worldBlack];
}

-(void) takeSteps:(int)numberOfSteps forAnt:(LAAnt *) theAnt {
    for (int i = 0; i < numberOfSteps; i++) {
        [theAnt step];
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
    
    XCTAssertEqual(CGPointMake(4, 5),ant.position, @"it takes one step to the left");
    XCTAssertEqual(LABlack, [ant.world valueForPoint:CGPointMake(5, 5)], @"the previous square is now black");
}

-(void) testTheAntCanTakeTwoSteps {
    [self takeSteps:2 forAnt:ant];

    XCTAssertEqual(CGPointMake(4, 6),ant.position, @"it takes one step down");
    XCTAssertEqual(LABlack, [ant.world valueForPoint:CGPointMake(4, 5)], @"the previous square is now black");
}

-(void) testTheAntCanTakeThreeSteps {
    [self takeSteps:3 forAnt:ant];
    
    XCTAssertEqual(CGPointMake(5, 6), ant.position, @"it takes one step to the right");
    XCTAssertEqual(LABlack, [ant.world valueForPoint:CGPointMake(4, 6)], @"the previous square is now black");
}

-(void) testTheAntCanTakeFourSteps {
    [self takeSteps:4 forAnt:ant];
    XCTAssertEqual(LABlack, [ant.world valueForPoint:[ant position]], @"The square should be black");
    XCTAssertEqual(CGPointMake(5, 5), ant.position, @"it takes one step to the right");
    XCTAssertEqual(LABlack, [ant.world valueForPoint:CGPointMake(5, 6)], @"the previous square is now black");
}

-(void) testTheAntCanTakeFiveSteps {
    [self takeSteps:5 forAnt:ant];
    XCTAssertEqual(CGPointMake(6, 5),ant.position, @"it takes one step to the right");
    XCTAssertEqual(LAWhite, [ant.world valueForPoint:CGPointMake(5, 5)], @"the previous square is now white");
}

- (void) testTheAntCanTakeSixSteps {
    [self takeSteps:6 forAnt:ant];
    XCTAssertEqual(CGPointMake(6, 4), ant.position, @"The ant should take on step up");
    XCTAssertEqual(LABlack, [ant.world valueForPoint:CGPointMake(6, 5)], @"the previous square is now white");
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
    [ant setPosition:CGPointMake(9, 0)];
    [ant setDirection:LAEast];
    [ant step];
    XCTAssertEqual(CGPointMake(9, 9), [ant position], @"The ant started facing east, turned left to face north, and wrapped around the world ending at the bottom of the grid");
    
    [ant setDirection:LAWest];
    [ant step];
    XCTAssertEqual(CGPointMake(9, 0), [ant position], @"The ant's position should no be 15, 0");
}

- (void) testAntCanMoveInAllDirectionsFromZeroZeroAnDirectionIsEast {
    [ant setPosition:CGPointMake(0, 0)];
    [ant setDirection:LAEast];
    [ant step];
    XCTAssertEqual(CGPointMake(0, 9), ant.position, @"The ant should be in the bottom left");
}

- (void) testAntCanMoveInAllDirectionsFromZeroZeroAnDirectionWest {
    [ant setPosition:CGPointMake(0, 0)];
    [ant setDirection:LANorth];
    [ant step];
    XCTAssertEqual(CGPointMake(9, 0), ant.position, @"The ant should be in square 1,0");
}

- (void) testWorldIsReturningCorrectModuloForNegativeOne {
    int modVal = [ant calculateModWithNegativeValue:-1 andModNumber:30];
    XCTAssertEqual(29, modVal, @"The value for -1 should be corrected to 29");
}

- (void) testWorldIsReturningCorrectModuloForThirty {
    int modVal = [ant calculateModWithNegativeValue:30 andModNumber:30];
    XCTAssertEqual(0, modVal, @"The value for 30 should be corrected to 0");
}


-(void) testTheAntCanTakeOneStepOnBlackWorld {
    [antBlack step];
    
    XCTAssertEqual(CGPointMake(6, 5),antBlack.position, @"it takes one step to the right");
    XCTAssertEqual(LAWhite, [antBlack.world valueForPoint:CGPointMake(5, 5)], @"the previous square is now black");
}

-(void) testTheAntCanTakeTwoStepsOnBlackWorld {
    [self takeSteps:2 forAnt:antBlack];
    
    XCTAssertEqual(CGPointMake(6, 6),antBlack.position, @"it takes one step down");
    XCTAssertEqual(LAWhite, [antBlack.world valueForPoint:CGPointMake(6, 5)], @"the previous square is now black");
}

-(void) testTheAntCanTakeThreeStepsOnBlackWorld {
    [self takeSteps:3 forAnt:antBlack];
    
    XCTAssertEqual(CGPointMake(5, 6),antBlack.position, @"it takes one step left");
    XCTAssertEqual(LAWhite, [antBlack.world valueForPoint:CGPointMake(6, 6)], @"the previous square is now black");
}

-(void) testTheAntCanTakeFourStepsOnBlackWorld {
    [self takeSteps:4 forAnt:antBlack];
    
    XCTAssertEqual(CGPointMake(5, 5),antBlack.position, @"it takes one step up");
    XCTAssertEqual(LAWhite, [antBlack.world valueForPoint:CGPointMake(5, 6)], @"the previous square is now black");
}

-(void) testTheAntCanTakeFiveStepsOnBlackWorld {
    [self takeSteps:5 forAnt:antBlack];
    
    XCTAssertEqual(CGPointMake(4, 5),antBlack.position, @"it takes one step left");
    XCTAssertEqual(LABlack, [antBlack.world valueForPoint:CGPointMake(5, 5)], @"the previous square is now black");
}

-(void) testTheAntCanTakeSixStepsOnBlackWorld {
    [self takeSteps:6 forAnt:antBlack];
    
    XCTAssertEqual(CGPointMake(4, 4),antBlack.position, @"it takes one step up");
    XCTAssertEqual(LAWhite, [antBlack.world valueForPoint:CGPointMake(4, 5)], @"the previous square is now black");
}

- (void) testAngleIsResetToLessThanOrEqualTo2PI {
    CGFloat degrees = 360 + 90;
    CGFloat degreesInRads = degrees * (M_PI/180);
    CGFloat correctedAngle = [antBlack correctAngleWhenGreaterThan2PI:degreesInRads];
    CGFloat correctedAngleInDegrees = correctedAngle  * (180/M_PI);
    XCTAssertEqual(89.f, correctedAngleInDegrees, @"The correct angle should just be M_PI");
}



@end
























































