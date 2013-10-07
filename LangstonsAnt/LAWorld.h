//
//  LAWorld.h
//  LangstonsAnt
//
//  Created by Justin Martin on 8/24/13.
//  Copyright (c) 2013 JMM. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WorldListener <NSObject>

-(void) updateSquareAtX:(int)x Y:(int)y to:(BOOL)white;

@end

@interface LAWorld : NSObject
@property (nonatomic, strong) id<WorldListener> worldListener;

@property (nonatomic) int size;


+(LAWorld *) newWorldWithSize:(int) size andListener:(id <WorldListener>) listener;
-(BOOL) isSquareWhiteAtX: (int) x andY: (int) y;
-(BOOL) isSquareBlackAtX: (int) x andY: (int) y;
-(void) toggleSquareAtX: (int) x andY: (int) y;
-(void) paintBlack;

@end
