//
//  LAViewController.h
//  LangstonsAnt
//
//  Created by Justin Martin on 8/24/13.
//  Copyright (c) 2013 JMM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LAAnt.h"

@interface LAViewController : UIViewController <WorldListener>
@property (nonatomic, strong) NSMutableArray *gridViews;
@property (strong, nonatomic) UIView *gridContainer;
@property (weak, nonatomic) IBOutlet UILabel *stepCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;
@property (weak, nonatomic) IBOutlet UIButton *runButton;
@property (weak, nonatomic) IBOutlet UITextField *gridSizeTextField;
@property (weak, nonatomic) IBOutlet UISlider *stepIntervalSlider;

-(void) resetGridWithSize:(int)size;

@end

