//
//  LAWorld.h
//  LangstonsAnt
//
//  Created by Justin Martin on 8/24/13.
//  Copyright (c) 2013 JMM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LAWorld : NSObject
@property NSInteger size;
@property (nonatomic, strong) NSMutableArray *squares;



+(LAWorld *) worldWithSize:(NSInteger)size;
-(id) initWithSize:(NSInteger)size;

@end
