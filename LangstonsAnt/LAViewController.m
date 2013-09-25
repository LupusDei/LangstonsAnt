//
//  LAViewController.m
//  LangstonsAnt
//
//  Created by Justin Martin on 8/24/13.
//  Copyright (c) 2013 JMM. All rights reserved.
//

#import "LAViewController.h"
#import <QuartzCore/QuartzCore.h>

#define StepSlow 200000

@interface LAViewController ()
@property (strong, nonatomic) LAWorld *world;
@property (strong, nonatomic) LAAnt *ant;
@property BOOL isRunning;
@property NSInteger stepCount;
@property (strong, nonatomic) CADisplayLink *runDisplayLink;
@property NSTimer *runTimer;
@property uint stepInterval;
@end

@implementation LAViewController
dispatch_queue_t runQueue;
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self resetGameWithSize:50];
    runQueue = dispatch_queue_create("runQueue", nil);
    self.stepInterval = StepSlow/self.stepIntervalSlider.value;
}
- (IBAction)stepIntervalChanged:(id)sender {
    int i = ceilf(self.stepIntervalSlider.value);
    i ++;
    self.stepInterval = StepSlow/i;
}

- (IBAction)resetButtonPressed:(id)sender {
    NSInteger size = self.gridSizeTextField.text.integerValue;
    if (size > 200) {
        size = 200;
    }
    [self resetGameWithSize:size];
    [self.gridSizeTextField resignFirstResponder];
}

- (IBAction)stepPressed:(id)sender {
    [self stepAnt];
}

- (IBAction)runButtonPressed:(id)sender {
    if (self.isRunning) {
        self.isRunning = NO;
        [self.runButton setTitle:@"Run" forState:UIControlStateNormal];
    }
    else {
        self.isRunning = YES;
        dispatch_async(runQueue, ^{
            while (self.isRunning) {
               [self stepAnt];
                usleep(self.stepInterval);
            }
        });
        [self.runButton setTitle:@"Stop" forState:UIControlStateNormal];
    }
}

-(void) displayNewStepCount {
    [self.stepCountLabel setText:[NSString stringWithFormat:@"Step Count: %d", self.stepCount]];
}

-(void) stepAnt {
    [self.ant step];
}

-(void) resetGameWithSize:(NSInteger)size {
    [self createAntInWorldWithSize:size];
    [self resetGridWithSize:self.world.size];
    self.stepCount = 0;
    [self displayNewStepCount];
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
            [square setBackgroundColor:[UIColor greenColor]];
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
    self.gridContainer.layer.borderWidth = 0.25;
    self.gridContainer.layer.borderColor = [UIColor blackColor].CGColor;
    [self.view addSubview:self.gridContainer];
}

-(void) createAntInWorldWithSize:(NSInteger)size {
    self.world = [[LAWorld alloc] initWithSize:size];
    self.world.display = self;
    self.ant = [LAAnt antWithWorld:self.world];
}

-(void)updateColor:(UIColor*)color atSquare:(CGPoint)point {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIView *square = [[self.gridViews objectAtIndex:point.x] objectAtIndex:point.y];
        square.backgroundColor = color;
        self.stepCount ++;
        [self displayNewStepCount];
    });
}

#pragma mark World Display Delegate Method
-(void) setSquareOfWorld:(LAWorld *)world toBlackAtPoint:(CGPoint)point {
    [self updateColor:[UIColor blackColor] atSquare:point];
}

-(void) setSquareOfWorld:(LAWorld *)world toWhiteAtPoint:(CGPoint)point {
    [self updateColor:[UIColor whiteColor] atSquare:point];
}


@end

































