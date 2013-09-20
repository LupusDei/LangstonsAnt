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

@interface LAWorld : NSObject

@property int size;

-(id) initWithSize:(int)size;
-(BOOL) valueForPoint:(CGPoint)point;
- (void)setSquareAtPoint:(CGPoint)point toValue:(BOOL)value;
- (void)toggleSquare:(CGPoint)point;
@end
