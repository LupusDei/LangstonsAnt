//
//  LAWorldTests.m
//  LangstonsAnt
//
//  Created by Justin Martin on 8/24/13.
//  Copyright (c) 2013 JMM. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LAWorld.h"
@interface LAWorldTests : XCTestCase
@property (nonatomic, strong) LAWorld *world;
@end

@implementation LAWorldTests

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

-(void) testItCanBeCreatedWithASize {
    self.world = [LAWorld worldWithSize:10];
    
    XCTAssertTrue(self.world.size == 10, @"it should have the correct size");
}

-(void) testItHasManySquares {
    self.world = [LAWorld worldWithSize:2];
    
    XCTAssertTrue([self.world.squares count] == 2, @"the count should have as many arrays as there are rows in the world");
    XCTAssertTrue([[self.world.squares lastObject] count] == 2, @"each row should have as many arrays as there are collumns in the world");
}




@end
