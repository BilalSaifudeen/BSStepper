//
//  BSViewController.m
//  BSStepperDemo
//
//  Created by Bilal Saifudeen on 23/07/14.
//  Copyright (c) 2014 Bilal Saifudeen. All rights reserved.
//

#import "BSViewController.h"
#import "BSStepper.h"

@interface BSViewController ()

@end

@implementation BSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    //Create stepper programmatically
    BSStepper *stepper = [[BSStepper alloc] init];
    [stepper setTranslatesAutoresizingMaskIntoConstraints:NO];
    [stepper setRange:NSMakeRange(10, 10)];
    [stepper setValue:15];
    [stepper setStepValue:0.5];
    [stepper setFormatString:@"%.02f"];
    [stepper setTintColor:[UIColor redColor]];
    [self.view addSubview:stepper];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(stepper);

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-180-[stepper(70)]-70-|" options:0 metrics:Nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-160-[stepper(70)]-250-|" options:0 metrics:Nil views:views]];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)stepperValueChanged:(id)sender {
    NSLog(@"Stepper value changed : %f",[(BSStepper *)sender value]);
}

@end
