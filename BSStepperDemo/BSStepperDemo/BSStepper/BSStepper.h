//
//  BSStepper.h
//  BSStepperDemo
//
//  Created by Bilal Saifudeen on 23/07/14.
//  Copyright (c) 2014 Bilal Saifudeen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSStepper : UIControl

/**
 *  The lowest possible value of the stepper. Default value is 0.
 *  MnimumValue should not be greater than maximumValue.
 */
@property(nonatomic, assign) double minimumValue;

/**
 *  The highest possible value of the stepper. Default value is 100.
 *  MaximumValue should not be lesser than minimumValue.
 */
@property(nonatomic, assign) double maximumValue;

/**
 *  The value of the stepper, which lies in between minimumValue and maximumValue.
 *  Default value is 1.
 */
@property(nonatomic, assign) double value;

/**
 *  The value that is used to increment or decrement the stepperValue. 
 *  Default value is 1. Always should be greater than 0.
 */
@property(nonatomic, assign) double stepValue;


/**
 *  The possible value range from which minimumValue and maximumValue can be derived.
 *  Default value is (0,100). Example: If you set range as (1, 9), minimumValue will be 1 and maximumValue will be 10.
 */
@property(nonatomic) NSRange range;

/**
 *  The format string used to format the value when displayed in label. It must be a non-nil value.
 *  It will be used with NSString's stringWithFormat: method.
 *  Its default value is '.0f', which can be used for diplaying integers
 */
@property(nonatomic, copy) NSString *formatString;
@end
