//
//  ViewController.m
//  tipCalculator
//
//  Created by Chris Guzman on 10/4/15.
//  Copyright © 2015 Chris Guzman. All rights reserved.
//

#import "TipViewController.h"

@interface TipViewController ()
@property (weak, nonatomic) IBOutlet UILabel *tipAmount;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *serviceLabel;

@end

@implementation TipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Tip Calculator";
}

- (void)viewWillAppear:(BOOL)animated {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    NSString *serviceType = [defaults objectForKey:@"service"];
    float amount = [defaults floatForKey:@"bill"];
    NSInteger control = [defaults integerForKey:@"segmentIndex"];
    if (serviceType != nil) {
        self.serviceLabel.text = [NSString stringWithFormat:@"Rate your %@ service", serviceType];
    }
    else {
        self.serviceLabel.text = @"Rate your service";
    }

    self.tipControl.selectedSegmentIndex = control;
    if (amount > 0) {
            [self.billTextField setText:[NSString stringWithFormat:@"%.2f", amount]];
    }
    [self updateValues];
}

- (void)viewDidAppear:(BOOL)animated {
    [self.billTextField becomeFirstResponder];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onTap:(UITapGestureRecognizer *)sender {
    [self updateValues];
}

- (void)updateValues {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *serviceType = [defaults objectForKey:@"service"];
    NSMutableArray *tipValues = [[NSMutableArray alloc] init];
    if ([serviceType isEqualToString:@"Dine in"]) {
        [tipValues addObject:@(0.15)];
        [self.tipControl setTitle:@"15%" forSegmentAtIndex:0];
        [tipValues addObject:@(0.20)];
        [self.tipControl setTitle:@"20%" forSegmentAtIndex:1];
        [tipValues addObject:@(0.25)];
        [self.tipControl setTitle:@"25%" forSegmentAtIndex:2];
    }
    else if ([serviceType isEqualToString:@"Buffet"]) {
        [tipValues addObject:@(0.03)];
        [self.tipControl setTitle:@"03%" forSegmentAtIndex:0];
        [tipValues addObject:@(0.05)];
        [self.tipControl setTitle:@"05%" forSegmentAtIndex:1];
        [tipValues addObject:@(0.10)];
        [self.tipControl setTitle:@"10%" forSegmentAtIndex:2];
    }
    else if ([serviceType isEqualToString:@"Takeout"]) {
        [tipValues addObject:@(0.05)];
        [self.tipControl setTitle:@"05%" forSegmentAtIndex:0];
        [tipValues addObject:@(0.10)];
        [self.tipControl setTitle:@"10%" forSegmentAtIndex:1];
        [tipValues addObject:@(0.15)];
        [self.tipControl setTitle:@"15%" forSegmentAtIndex:2];
    }
    else {
        [tipValues addObject:@(0.15)];
        [self.tipControl setTitle:@"15%" forSegmentAtIndex:0];
        [tipValues addObject:@(0.20)];
        [self.tipControl setTitle:@"20%" forSegmentAtIndex:1];
        [tipValues addObject:@(0.25)];
        [self.tipControl setTitle:@"25%" forSegmentAtIndex:2];
    }
    
    float billAmount = ([self.billTextField.text floatValue]);
    
    [defaults setFloat:(billAmount) forKey:@"bill"];
    [defaults setInteger:self.tipControl.selectedSegmentIndex forKey:@"segmentIndex"];
    [defaults synchronize];
    
    float tipAmount = [tipValues [self.tipControl.selectedSegmentIndex] floatValue] * billAmount;
    
    float totalAmount = billAmount + tipAmount;
    
    self.tipLabel.text = [NSString stringWithFormat:@"$%0.2f", tipAmount];
    
    self.totalLabel.text = [NSString stringWithFormat:@"$%0.2f", totalAmount];
    
    
}
- (IBAction)onValueChange:(UISegmentedControl *)sender {
    [self updateValues];
}


@end
