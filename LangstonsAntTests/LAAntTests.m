//
//  LAAntTests.m
//  LangstonsAnt
//
//  Created by Justin Martin on 8/24/13.
//  Copyright (c) 2013 JMM. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LAAnt.h"

@interface LAAntTests : XCTestCase
@property (strong, nonatomic) LAWorld *world;
@property (strong, nonatomic) LAAnt *ant;
@end

@implementation LAAntTests

- (void)setUp
{
    [super setUp];
    self.world = [LAWorld worldWithSize:10];
    self.ant = [LAAnt antInWorld:self.world];
}

-(void) takeSteps:(int)times {
    for (int i = 0; i < times; i++) {
        [self.ant step];
    }
}


#pragma mark RULES
-(void) testAnAntCanBeCreatedInAWorld {
    XCTAssertEqual(self.ant.world,self.world, @"the ant should be in the world");
}

-(void) testTheAntShouldStartInTheCenter {
    XCTAssertTrue(self.ant.x == 5, @"it starts in the middle row");
    XCTAssertTrue(self.ant.y == 5, @"it starts in the middle collumn");
}

-(void) testTheAntStartsFacingNorth {
    XCTAssertTrue(self.ant.direction == laNORTH, @"it faces north at the start");
}

-(void) testTheAntTakesOneStep {
    [self.ant step];
    
    XCTAssertTrue(self.ant.x == 4, @"since the first square is white, it turns left and takes a step West");
    XCTAssertTrue(self.ant.y == 5, @"it stays in the same row");
    XCTAssertTrue([self.world isBlackSquareAtX:5 Y:5], @"the last square the ant was in should now be black");
}

-(void) testTheAntTakesTwoSteps {
    [self takeSteps:2];
    
    XCTAssertTrue(self.ant.x == 4, @"another left turn keeps it in the same collumn");
    XCTAssertTrue(self.ant.y == 6, @"now it is going South, so the row increments");
    XCTAssertTrue([self.world isBlackSquareAtX:4 Y:5], @"the last square the ant was in should now be black");
}

-(void) testTheAntTakesThreeSteps {
    [self takeSteps:3];
    
    XCTAssertTrue(self.ant.x == 5, @"another left turn keeps means it is going East");
    XCTAssertTrue(self.ant.y == 6, @"so it stays in the same row");
    XCTAssertTrue([self.world isBlackSquareAtX:4 Y:6], @"the last square the ant was in should now be black");
}

-(void) testTheAntTakesFourSteps {
    [self takeSteps:4];
    
    XCTAssertTrue(self.ant.x == 5, @"now we are back facing North, where we started");
    XCTAssertTrue(self.ant.y == 5, @"in the same row");
    XCTAssertTrue([self.world isBlackSquareAtX:5 Y:6], @"the last square the ant was in should now be black");
}

-(void) testTheAntTakesFiveSteps {
    [self takeSteps:5];
    
    XCTAssertTrue(self.ant.x == 6, @"since the start square is now black, we will turn right and go East");
    XCTAssertTrue(self.ant.y == 5, @"in the same row");
    XCTAssertTrue([self.world isWhiteSquareAtX:5 Y:5], @"since the square was black, it should now be white");
}

#pragma mark Warp to the otherside of the World

-(void) testTheAntCanWarpEastAroundTheWorld{
    self.ant.x = 9;
    self.ant.y = 5;
    self.ant.direction = laSOUTH;
    
    [self.ant step];
    
    XCTAssertTrue(self.ant.x == 0, @"the ant will warp horizontally to the otherside of the world");
    XCTAssertTrue(self.ant.y == 5, @"which doesn't affact its vertical position");
}

-(void) testTheAntCanWarpNorthAroundTheWorld{
    self.ant.x = 5;
    self.ant.y = 0;
    self.ant.direction = laEAST;
    
    [self.ant step];
    
    XCTAssertTrue(self.ant.x == 5, @"the ant will warp North which doesn't affect the horizontal position");
    XCTAssertTrue(self.ant.y == 9, @"but it warps vertically around the world");
}

-(void) testTheAntCanWarpWestAroundTheWorld{
    self.ant.x = 0;
    self.ant.y = 5;
    self.ant.direction = laNORTH;
    
    [self.ant step];
    
    XCTAssertTrue(self.ant.x == 9, @"the ant will warp West around the world");
    XCTAssertTrue(self.ant.y == 5, @"which doesn't affect its vertical postion");
}

-(void) testTheAntCanWarpSouthAroundTheWorld{
    self.ant.x = 5;
    self.ant.y = 9;
    self.ant.direction = laWEST;
    
    [self.ant step];
    
    XCTAssertTrue(self.ant.x == 5, @"the ant will warp South which doesn't affect the horizontal position");
    XCTAssertTrue(self.ant.y == 0, @"but it warps vertically around the world");
}
@end
