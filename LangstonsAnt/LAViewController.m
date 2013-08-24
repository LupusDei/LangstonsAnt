//
//  LAViewController.m
//  LangstonsAnt
//
//  Created by Justin Martin on 8/24/13.
//  Copyright (c) 2013 JMM. All rights reserved.
//

#import "LAViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface LAViewController ()

@end

@implementation LAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self resetGridWithSize:40];
}
- (IBAction)resetButtonPressed:(id)sender {
    NSInteger size = self.gridSizeTextField.text.integerValue;
    [self resetGridWithSize:size];
    [self.gridSizeTextField resignFirstResponder];
}

-(void) resetGridWithSize:(NSInteger)gridSize {
    [self createGridContainer];
    float squareSize = self.gridContainer.frame.size.width / gridSize;
    self.gridViews = [NSMutableArray arrayWithCapacity:gridSize];
    for (int x = 0; x < gridSize; x++) {
        NSMutableArray *row = [NSMutableArray arrayWithCapacity:gridSize];
        [self.gridViews addObject:row];
        for (int y = 0; y < gridSize; y++) {
            UIView *square = [[UIView alloc] initWithFrame:CGRectMake(x *squareSize, y *squareSize, squareSize, squareSize)];
            square.layer.borderColor = [UIColor blackColor].CGColor;
            square.layer.borderWidth = 0.25;
            [self.gridContainer addSubview:square];
            [row addObject:square];
        }
    }
}

-(void) createGridContainer {
    if (self.gridContainer) {
        [self.gridContainer removeFromSuperview];
        self.gridContainer = nil;
    }
    
    self.gridContainer = [[UIView alloc] initWithFrame:CGRectMake(10, 134, 300, 300)];
    self.gridContainer.layer.borderWidth = 0.5;
    self.gridContainer.layer.borderColor = [UIColor blackColor].CGColor;
    [self.view addSubview:self.gridContainer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
