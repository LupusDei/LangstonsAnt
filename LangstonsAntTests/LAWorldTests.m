//
//  LAWorldTests.m
//  LangstonsAnt
//
//  Created by Justin Martin on 8/24/13.
//  Copyright (c) 2013 JMM. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LAWorld.h"
@interface LAWorldTests : XCTestCase <WorldListener>
@end

@implementation LAWorldTests {
    LAWorld *world;
    BOOL changedColorToBlack;
}

-(void) updateSquareAtX:(int)x Y:(int)y to:(BOOL)white  {
    changedColorToBlack = !white;
}

-(void) setUp {
    world = [LAWorld newWorldWithSize:10 andListener: self];
}


- (void) testTheWorldCanBeCreatedWithASize {
    XCTAssertEqual(10, world.size);
}

- (void) testAllSquareAreWhite{
    XCTAssertTrue([world isSquareWhiteAtX:5 andY:5]);
    XCTAssertFalse([world isSquareBlackAtX:5 andY:5]);
}

- (void) testASquareCanBeBlack {
    [world toggleSquareAtX:5 andY:5];
    
    XCTAssertTrue([world isSquareBlackAtX:5 andY:5]);
}

- (void) testASquareCanBeNotWhite {
    [world toggleSquareAtX:5 andY:5];
    
    XCTAssertFalse([world isSquareWhiteAtX:5 andY:5]);
}

- (void) testDoubleToggle {
    XCTAssertTrue([world isSquareWhiteAtX:5 andY:5]);
    [world toggleSquareAtX:5 andY:5];
    
    XCTAssertFalse([world isSquareWhiteAtX:5 andY:5]);
    [world toggleSquareAtX:5 andY:5];
    
    XCTAssertTrue([world isSquareWhiteAtX:5 andY:5]);
}

- (void) testItCanPaintTheWorldBlack {
    [world paintBlack];
    
    XCTAssertTrue([world isSquareBlackAtX:5 andY:5]);
    XCTAssertTrue([world isSquareBlackAtX:0 andY:0]);
}

- (void) testInformsTheWorldListenerThatASquareHasChangedColors {
    [world toggleSquareAtX:5 andY:5];
    
    XCTAssertTrue(changedColorToBlack);
}

@end
