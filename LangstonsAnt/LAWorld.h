//
//  LAWorld.h
//  LangstonsAnt
//
//  Created by Justin Martin on 8/24/13.
//  Copyright (c) 2013 JMM. All rights reserved.
//

#import <Foundation/Foundation.h>

#define LAWhite NO
#define LABlack YES

@class LAWorld;
@protocol LAWorldDisplay
-(void) setSquareOfWorld:(LAWorld *)world toBlackAtPoint:(CGPoint)point;
-(void) setSquareOfWorld:(LAWorld *)world toWhiteAtPoint:(CGPoint)point;
@end

@interface LAWorld : NSObject
@property (nonatomic, weak) id<LAWorldDisplay> display;

@property int size;

-(id) initWithSize:(int)size;
-(BOOL) valueForPoint:(CGPoint)point;
- (void)setSquareAtPoint:(CGPoint)point toValue:(BOOL)value;
- (void)toggleSquare:(CGPoint)point;
@end
