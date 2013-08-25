//
//  LAWorldTests.m
//  LangstonsAnt
//
//  Created by Justin Martin on 8/24/13.
//  Copyright (c) 2013 JMM. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LAWorld.h"
@interface LAWorldTests : XCTestCase <LAWorldDisplay>
@property (nonatomic, strong) LAWorld *world;
@property UIColor *worldDisplayCalledWithColor;
@property NSInteger worldDisplayCalledAtX;
@property NSInteger worldDisplayCalledAtY;
@end

@implementation LAWorldTests

-(void) updateSquareAtX:(int)x Y:(int)y toColor:(UIColor *)color {
    self.worldDisplayCalledWithColor = color;
    self.worldDisplayCalledAtX = x;
    self.worldDisplayCalledAtY = y;
}

- (void)setUp
{
    self.world = [LAWorld worldWithSize:10];
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

-(void) testItCanBeCreatedWithASize {
    XCTAssertTrue(self.world.size == 10, @"it should have the correct size");
}

-(void) testItHasManySquares {
    XCTAssertTrue([self.world.squares count] == 10, @"the count should have as many arrays as there are rows in the world");
    XCTAssertTrue([[self.world.squares lastObject] count] == 10, @"each row should have as many arrays as there are collumns in the world");
}

-(void) testTheSquaresShouldStartAsWhite {
    XCTAssertTrue([self.world isWhiteSquareAtX:0 Y:0], @"sqaures start out white");
}

-(void) testASquareCanBeBlack {
    [self.world setBlackSquareAtX:0 Y:0];
    XCTAssertTrue([self.world isBlackSquareAtX:0 Y:0], @"squares can be black");
    XCTAssertFalse([self.world isWhiteSquareAtX:0 Y:0], @"black squares are not white");
}

-(void) testASquareCanBeSetBackToWhite {
    [self.world setBlackSquareAtX:0 Y:0];
    [self.world setWhiteSquareAtX:0 Y:0];
    XCTAssertTrue([self.world isWhiteSquareAtX:0 Y:0], @"it should be white when it is set to white");
}

-(void) testSettingASquareToBlackInformsAWorldDisplay {
    self.world.display = self;
    [self.world setBlackSquareAtX:3 Y:7];
    XCTAssertEqual(self.worldDisplayCalledWithColor, [UIColor blackColor], @"it tells a display to color a square black");
    XCTAssertTrue(self.worldDisplayCalledAtX == 3, @"with the correct x");
    XCTAssertTrue(self.worldDisplayCalledAtY == 7, @"with the correct y");
}

-(void) testSettingASquareToWhiteInformsAWorldDisplay {
    self.world.display = self;
    [self.world setWhiteSquareAtX:4 Y:2];
    XCTAssertEqual(self.worldDisplayCalledWithColor, [UIColor whiteColor], @"it tells a display to color a square black");
    XCTAssertTrue(self.worldDisplayCalledAtX == 4, @"with the correct x");
    XCTAssertTrue(self.worldDisplayCalledAtY == 2, @"with the correct y");
}

@end
