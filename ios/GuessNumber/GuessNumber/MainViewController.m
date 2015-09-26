//
//  MainViewController.m
//  GuessNumber
//
//  Created by vmaltsev on 21.09.14.
//  Copyright © 2014 vmaltsev. All rights reserved.
//

#import "MainViewController.h"
#import "QuizViewController.h"

@interface MainViewController ()

@property (weak, nonatomic) IBOutlet UITextField *minValueInput;
@property (weak, nonatomic) IBOutlet UITextField *maxValueInput;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UILabel *errorMessageLabel;

@property int minValue;
@property int maxValue;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [self updateValues];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:@"showQuizSegue"]) {
        QuizViewController *controller = segue.destinationViewController;
        controller.minValue = self.minValue;
        controller.maxValue = self.maxValue;
    }
    
}

- (IBAction) updateValues {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    
    NSNumber *min = [formatter numberFromString:self.minValueInput.text];
    NSNumber *max = [formatter numberFromString:self.maxValueInput.text];
    
    if (min == nil || max == nil) {
        [self showError:NSLocalizedString(@"Input valid numbers", nil)];
        return;
    }
    
    if (min.integerValue >= max.integerValue) {
        [self showError:NSLocalizedString(@"Maximal should be bigger than minimal", nil)];
        return;
    }
    
    self.minValue = min.integerValue;
    self.maxValue = max.integerValue;
    [self clearError];
}

- (void) showError:(NSString *)msg {
    self.errorMessageLabel.hidden = false;
    self.doneButton.enabled = false;
    self.errorMessageLabel.text = msg;
}

- (void) clearError {
    self.errorMessageLabel.hidden = true;
    self.doneButton.enabled = true;
}

@end
