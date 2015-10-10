//
//  ViewController.m
//  tipCalculator
//
//  Created by Chris Guzman on 10/4/15.
//  Copyright © 2015 Chris Guzman. All rights reserved.
//

#import "TipViewController.h"

@interface TipViewController ()
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
    self.billTextField.delegate = self;
    [self.billTextField setBorderStyle:UITextBorderStyleNone];

}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSString *expression = @"^[0-9]*((\\.|,)[0-9]{0,2})?$";
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression options:NSRegularExpressionCaseInsensitive error:&error];
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:newString options:0 range:NSMakeRange(0, [newString length])];
    return numberOfMatches != 0;
}


- (void)viewWillAppear:(BOOL)animated {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    NSString *serviceType = [defaults objectForKey:@"service"];
    double amount = [defaults doubleForKey:@"bill"];
    NSInteger control = [defaults integerForKey:@"segmentIndex"];
    if (serviceType != nil) {
        self.serviceLabel.text = [NSString stringWithFormat:@"Rate your %@ service", serviceType];
    }
    else {
        self.serviceLabel.text = @"Rate your service";
    }

    self.tipControl.selectedSegmentIndex = control;
    if (amount > 0) {
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
        [formatter setLocale:[NSLocale currentLocale]];
        [formatter setCurrencySymbol: @""];
        NSNumber *nsAmount = @(amount);
        NSString *localizedAmount = [formatter stringFromNumber:nsAmount];
        
        [self.billTextField setText:[NSString stringWithFormat:@"%@", localizedAmount]];
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
- (IBAction)onPress:(id)sender {
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
    else if ([serviceType isEqualToString:@"Delivery"]) {
        [tipValues addObject:@(0.10)];
        [self.tipControl setTitle:@"10%" forSegmentAtIndex:0];
        [tipValues addObject:@(0.15)];
        [self.tipControl setTitle:@"15%" forSegmentAtIndex:1];
        [tipValues addObject:@(0.20)];
        [self.tipControl setTitle:@"20%" forSegmentAtIndex:2];
    }
    else if ([serviceType isEqualToString:@"Takeout"]) {
        [tipValues addObject:@(0.05)];
        [self.tipControl setTitle:@"5%" forSegmentAtIndex:0];
        [tipValues addObject:@(0.10)];
        [self.tipControl setTitle:@"10%" forSegmentAtIndex:1];
        [tipValues addObject:@(0.15)];
        [self.tipControl setTitle:@"15%" forSegmentAtIndex:2];
    }
    else if ([serviceType isEqualToString:@"Buffet"]) {
        [tipValues addObject:@(0.03)];
        [self.tipControl setTitle:@"3%" forSegmentAtIndex:0];
        [tipValues addObject:@(0.05)];
        [self.tipControl setTitle:@"5%" forSegmentAtIndex:1];
        [tipValues addObject:@(0.10)];
        [self.tipControl setTitle:@"10%" forSegmentAtIndex:2];
    }
    else {
        [tipValues addObject:@(0.15)];
        [self.tipControl setTitle:@"15%" forSegmentAtIndex:0];
        [tipValues addObject:@(0.20)];
        [self.tipControl setTitle:@"20%" forSegmentAtIndex:1];
        [tipValues addObject:@(0.25)];
        [self.tipControl setTitle:@"25%" forSegmentAtIndex:2];
    }
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [formatter setLocale:[NSLocale currentLocale]];
    
    NSNumber *number = [[NSNumberFormatter new] numberFromString: self.billTextField.text];
    double billAmount = [number doubleValue];
    
    [defaults setDouble:billAmount forKey:@"bill"];
    [defaults setInteger:self.tipControl.selectedSegmentIndex forKey:@"segmentIndex"];
    [defaults synchronize];
    
    double tipAmount = [tipValues [self.tipControl.selectedSegmentIndex] doubleValue] * billAmount;
    double totalAmount = billAmount + tipAmount;
    
    NSNumber *nsTotalAmount = @(totalAmount);
    NSNumber *nsTipAmount = @(tipAmount);
    
    NSString *localizedTotalAmount = [formatter stringFromNumber:nsTotalAmount];
    NSString *localizedTipAmount = [formatter stringFromNumber:nsTipAmount];
    
    [UIView transitionWithView:self.tipLabel
                      duration:.5f
                       options:UIViewAnimationOptionTransitionFlipFromBottom
                    animations:^{
                        
    self.tipLabel.text = [NSString stringWithFormat:@"%@", localizedTipAmount];
                    } completion:nil];

    [UIView transitionWithView:self.totalLabel
                      duration:.5f
                       options:UIViewAnimationOptionTransitionFlipFromBottom
                    animations:^{
                        
    self.totalLabel.text = [NSString stringWithFormat:@"%@", localizedTotalAmount];
                    } completion:nil];

}

- (IBAction)onEdit:(id)sender {
    [self updateValues];
}


- (IBAction)onTextFieldUpdate:(id)sender {
    [self updateValues];
}

@end
