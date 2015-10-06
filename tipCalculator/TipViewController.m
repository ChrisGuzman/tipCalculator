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

@end

@implementation TipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Tip Calculator";
}

- (void)viewWillAppear:(BOOL)animated {
    [self updateValues];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onTap:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
    [self updateValues];
}

- (void)updateValues {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *serviceType = [defaults objectForKey:@"service"];
    NSMutableArray *tipValues = [[NSMutableArray alloc] init];
    if ([serviceType isEqualToString:@"Sit-down restaurant"]) {
        [tipValues addObject:@(0.15)];
        [tipValues addObject:@(0.20)];
        [tipValues addObject:@(0.25)];
    }
    else if ([serviceType isEqualToString:@"Buffet"]) {
        [tipValues addObject:@(0.025)];
        [tipValues addObject:@(0.05)];
        [tipValues addObject:@(0.10)];
    }
    else if ([serviceType isEqualToString:@"Takeout"]) {
        [tipValues addObject:@(0.05)];
        [tipValues addObject:@(0.10)];
        [tipValues addObject:@(0.15)];
    }
    
    float billAmount = ([self.billTextField.text floatValue]);
    
    float tipAmount = [tipValues [self.tipControl.selectedSegmentIndex] floatValue] * billAmount;
    
    float totalAmount = billAmount + tipAmount;
    
    self.tipLabel.text = [NSString stringWithFormat:@"$%0.2f", tipAmount];
    
    self.totalLabel.text = [NSString stringWithFormat:@"$%0.2f", totalAmount];
    
    
}
- (IBAction)onValueChange:(UISegmentedControl *)sender {
    [self updateValues];
}

@end
