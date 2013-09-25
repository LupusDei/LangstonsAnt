//
//  LAWorldTests.m
//  LangstonsAnt
//
//  Created by Justin Martin on 8/24/13.
//  Copyright (c) 2013 JMM. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LAWorld.h"

@interface LAWorldTests : XCTestCase <LAWorldDisplay> {
    LAWorld *world;
    BOOL toggledSquareToBlack;
    BOOL toggledSquareToWhite;
    int xOfToggledSquare;
    int yOfToggledSquare;
    BOOL isBlack;
}
@end

@implementation LAWorldTests

#pragma LAWorldDisplay methods
-(void) setPointOfToggledSquare:(CGPoint)point {
    xOfToggledSquare    = point.x;
    yOfToggledSquare    = point.y;
}

-(void) setSquareOfWorld:(LAWorld *)world toBlackAtPoint:(CGPoint)point {
    [self setPointOfToggledSquare:point];
    toggledSquareToBlack  = YES;
}
-(void) setSquareOfWorld:(LAWorld *)world toWhiteAtPoint:(CGPoint)point {
    toggledSquareToWhite  = YES;
    [self setPointOfToggledSquare:point];
}

- (void)setUp {
    [super setUp];
    world = [[LAWorld alloc] initWithSize:30];
}

- (void)tearDown {
    world = nil;
    [super tearDown];
}

-(void) testTheWorldHasASize {
    XCTAssertEqual(30,world.size, @"The world has a size");
}

-(void) testTheWorldCannotHaveASizeLessThanOne {
    XCTAssertThrowsSpecificNamed([[LAWorld alloc] initWithSize:0], NSException, NSInvalidArgumentException,@"it can't have a negative size");
}

- (void) testTheWorldDefaultsTheSqauresToWhite {
    BOOL value = [world valueForPoint:CGPointMake(0, 0)];
    XCTAssertEqual(LAWhite,value, @"The default value for all squares on the grid is false");
}

- (void) testTheWorldCanHaveBlackSquares {
    [world setSquareAtPoint:CGPointMake(0, 9) toValue:LABlack];
    XCTAssertEqual(LABlack,[world valueForPoint:CGPointMake(0, 9)], @"the value for square 0, 9 should be black after it is set to be black");
    XCTAssertEqual(LAWhite,[world valueForPoint:CGPointMake(0, 0)], @"the value for square 0, 0 should be black after it is set to be black");
}

-(void) testItDoesntHaveSquaresOutsideItsBounds {
    XCTAssertThrowsSpecificNamed([world valueForPoint:CGPointMake(0, 35)], NSException, NSInvalidArgumentException, @"it should not have a value outside the y axis");
    XCTAssertThrowsSpecificNamed([world valueForPoint:CGPointMake(35, 0)], NSException, NSInvalidArgumentException, @"it should not have a value outside the x axis");
}

- (void) testAWorldWithHalfBlackAndHalfWhiteSquares {
    LAWorld *smallWorld = [[LAWorld alloc] initWithSize:2];
    [smallWorld setSquareAtPoint:CGPointMake(0, 1) toValue:LABlack];
    [smallWorld setSquareAtPoint:CGPointMake(1, 0) toValue:LABlack];
    XCTAssertEqual(LAWhite,[smallWorld valueForPoint:CGPointMake(0, 0)], @"0,0 is white");
    XCTAssertEqual(LABlack,[smallWorld valueForPoint:CGPointMake(0, 1)], @"0,0 is black");
    XCTAssertEqual(LABlack,[smallWorld valueForPoint:CGPointMake(1, 0)], @"0,0 is black");
    XCTAssertEqual(LAWhite,[smallWorld valueForPoint:CGPointMake(1, 1)], @"0,0 is white");
}

-(void) testItCanToggleTheColorOfASquare {
    [world toggleSquare:CGPointMake(0, 0)];
    
    BOOL value = [world valueForPoint:CGPointMake(0, 0)];
    XCTAssertEqual(LABlack, value, @"The color was defaulted white, now it is black");
}

- (void) testThatTheWorldHasADelegate {
    world.display = self;
    XCTAssertNotNil(world.display, @"The world has a delegate");
}

- (void) testThatTheWorldDisplayReceivesDataWhenSquareChangesColor {
    world.display = self;
    [world toggleSquare:CGPointMake(12, 13)];
    
    XCTAssertTrue(toggledSquareToBlack, @"the delegate should have recieved a message");
    XCTAssertEqual(12,xOfToggledSquare, @"it toggled the correct square");
    XCTAssertEqual(13,yOfToggledSquare, @"it toggled the correct square");
}

- (void) testWorldDisplayReceivesColorValue {
    world.display = self;
    [world toggleSquare:CGPointMake(12, 13)];
    XCTAssertTrue(toggledSquareToBlack, @"it will color the square black");
    [world toggleSquare:CGPointMake(12, 13)];
    XCTAssertTrue(toggledSquareToWhite, @"it will color the square white");
}


@end























































