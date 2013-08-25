//
//  LAWorld.h
//  LangstonsAnt
//
//  Created by Justin Martin on 8/24/13.
//  Copyright (c) 2013 JMM. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LAWorldDisplay <NSObject>

-(void) updateSquareAtX:(int)x Y:(int)y toColor:(UIColor *)color;

@end

@interface LAWorld : NSObject
@property NSInteger size;
@property (nonatomic, strong) NSMutableArray *squares;
@property (nonatomic, strong) id <LAWorldDisplay> display;


+(LAWorld *) worldWithSize:(NSInteger)size;

-(id) initWithSize:(NSInteger)size;

-(BOOL) isWhiteSquareAtX:(int)x Y:(int)y;
-(BOOL) isBlackSquareAtX:(int)x Y:(int)y;

-(void) setBlackSquareAtX:(int)x Y:(int)y;
-(void) setWhiteSquareAtX:(int)x Y:(int)y;

@end
