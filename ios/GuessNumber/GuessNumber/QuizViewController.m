//
//  ViewController.m
//  GuessNumber
//
//  Created by vmaltsev on 20.09.14.
//  Copyright © 2014 vmaltsev. All rights reserved.
//

#import "QuizViewController.h"

@interface QuizViewController ()

@property (weak, nonatomic) IBOutlet UILabel *questionLabel;

@property int minPossible;
@property int maxPossible;
@property int currentGuess;

@end

@implementation QuizViewController


-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.minPossible = self.minValue;
    self.maxPossible = self.maxValue;
    
    [self makeGuess];
}

- (void) makeGuess {
    
    if (self.minPossible == self.maxPossible) {
        [self showAnswer:self.minPossible];
        return;
    }
    
    self.currentGuess = (int)floor((self.minPossible + self.maxPossible) / 2.0);
    NSString *question = nil;
    
    if ((self.maxPossible - self.minPossible) == 1) {
        // If left two numbers, show more user frendly message.
        question = [NSString localizedStringWithFormat: NSLocalizedString(@"It's %d?", nil), self.maxPossible];
    } else {
        question = [NSString localizedStringWithFormat: NSLocalizedString(@"This number is bigger than %d?", nil), self.currentGuess];
    }
    
    [self.questionLabel setText:question];
}

- (IBAction)answerIsBigger:(id)sender {
    self.minPossible = self.currentGuess + 1;
    [self makeGuess];
}

- (IBAction)answerIsSmallerOrEqual:(id)sender {
    self.maxPossible = self.currentGuess;
    [self makeGuess];
}

- (void) showAnswer:(int)ans {
    
    NSString  *msg = [NSString localizedStringWithFormat:NSLocalizedString(@"You guessed %d", nil), ans];
    
    UIAlertController *alert = [UIAlertController
                                alertControllerWithTitle: NSLocalizedString(@"Answer is found!", nil)
                                message: msg
                                preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle: NSLocalizedString(@"Ok", nil)
                               style: UIAlertActionStyleDefault
                               handler: ^(UIAlertAction *action) {
                                   [self startAgain:nil];
                               }];
    
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}

-(IBAction) startAgain:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
