//
//  BSStepper.m
//  BSStepperDemo
//
//  Created by Bilal Saifudeen on 23/07/14.
//  Copyright (c) 2014 Bilal Saifudeen. All rights reserved.
//

#import "BSStepper.h"

@interface BSStepper (){
    UIButton    *upButton;      //Increment button(+)
    UIButton    *downButton;    //Decrement button(-)
    UILabel     *valueLabel;    //Displays stepper value
}
@end

@implementation BSStepper

- (id)init{
    self = [super init];
    if (self) {
        [self setDefaults];
        [self setupUI];
        [self updateUI];
    }
    return self;
}

- (void)awakeFromNib{
    [self setDefaults];
    [self setupUI];
    [self updateUI];
}

/**
 *  Sets all default values
 */
- (void)setDefaults{
    self.formatString = @"%.0f";
    
    self.value = 1;
    self.range = NSMakeRange(0, 100);
    self.stepValue = 1;
    

}

/**
 *  Creates all sub components like buttons, labels
 */
- (void)setupUI{
    
    [self setTintColor:[UIColor blackColor]];
    
    [self.layer setCornerRadius:7.0f];
    [self.layer setMasksToBounds:YES];
    [self.layer setBorderWidth:2.0f];
    [self.layer setBorderColor:self.tintColor.CGColor];
    [self setBackgroundColor:[UIColor clearColor]];
    
    //Create UI components
    upButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [upButton setTitle:@"+" forState:UIControlStateNormal];
    [upButton.titleLabel setFont:[UIFont boldSystemFontOfSize:24.0f]];
    [upButton setBackgroundColor:self.tintColor];
    [upButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [upButton addTarget:self action:@selector(upPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:upButton];
    
    downButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [downButton setTitle:@"-" forState:UIControlStateNormal];
    [downButton.titleLabel setFont:[UIFont boldSystemFontOfSize:24.0f]];
    [downButton setBackgroundColor:self.tintColor];
    [downButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [downButton addTarget:self action:@selector(downPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:downButton];
    
    valueLabel = [[UILabel alloc] init];
    [valueLabel setText:Nil];
    [valueLabel setFont:[UIFont boldSystemFontOfSize:20.0f]];
    [valueLabel setAdjustsFontSizeToFitWidth:YES];
    [valueLabel setBackgroundColor:[UIColor clearColor]];
    [valueLabel setTextColor:[UIColor blackColor]];
    [valueLabel setTextAlignment:NSTextAlignmentCenter];
    [valueLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:valueLabel];

    //Setup AutoLayout stuff
    NSDictionary *views = NSDictionaryOfVariableBindings(upButton,downButton,valueLabel);
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[upButton]|" options:0 metrics:Nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[valueLabel]|" options:0 metrics:Nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[downButton]|" options:0 metrics:Nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[upButton(==valueLabel)][valueLabel][downButton(==valueLabel)]|" options:0 metrics:Nil views:views]];

}

- (void)updateUI{
    NSParameterAssert(_formatString);
    [valueLabel setText:[NSString stringWithFormat:self.formatString,self.value]];
}

#pragma mark - Accessor methods
- (void)setMinimumValue:(double)minimumValue{
    _minimumValue = minimumValue;
    
    //If new minimumValue is greater than maximumValue, both will be set to the new value.
    if (_minimumValue > _maximumValue) {
        _maximumValue = _minimumValue;
    }
    
    
    //If value is already lesser than new minimumValue, value is set to minimumValue
    if (_value < _minimumValue) {
        self.value = _minimumValue;
    }
}

- (void)setMaximumValue:(double)maximumValue{
    _maximumValue = maximumValue;
    
    //If new maximumValue is lesser than minimumValue, both will be set to the new value.
    if (_maximumValue < _minimumValue) {
        _minimumValue = _maximumValue;
    }
    
    //If value is already greater than new maximumValue, value is set to maximumValue
    if (_value > _maximumValue) {
        self.value = _maximumValue;
    }
}

- (void)setValue:(double)value{
    _value = value;
    
    //Update user interface
    [self updateUI];
}

- (void)setStepValue:(double)stepValue{
    _stepValue = stepValue;
}

- (void)setRange:(NSRange)range{
    [self setMinimumValue:range.location];
    [self setMaximumValue:range.location + range.length];
}

- (NSRange)range{
    return NSMakeRange(_minimumValue, _maximumValue - _minimumValue);
}

- (void)setFormatString:(NSString *)formatString{
    NSAssert(formatString, @"Format string cannot be Nil, provide a valid string. Ex: '.0f'");
   
    _formatString = [formatString copy];
    
    [self updateUI];
}

#pragma mark - Accessor methods(Overrided)

- (void)setTintColor:(UIColor *)tintColor{
    [super setTintColor:tintColor];
    [self.layer setBorderColor:self.tintColor.CGColor];
    [upButton setBackgroundColor:self.tintColor];
    [downButton setBackgroundColor:self.tintColor];
}

#pragma mark - UI Events

- (void)upPressed:(id)sender{
    if ((self.value + self.stepValue) <= self.maximumValue) {
        self.value += self.stepValue;
    }else{
        self.value = self.maximumValue;
    }
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void)downPressed:(id)sender{
    if ((self.value - self.stepValue) >= self.minimumValue) {
        self.value -= self.stepValue;
    }else{
        self.value = self.minimumValue;
    }
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

@end
