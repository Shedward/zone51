//
//  ExchangeDetailsViewController.m
//  ExchangeRates
//
//  Created by vmaltsev on 24.09.14.
//  Copyright © 2014 vmaltsev. All rights reserved.
//

#import "ExchangeDetailsViewController.h"

@interface ExchangeDetailsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *buyLabel;
@property (weak, nonatomic) IBOutlet UILabel *sellLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation ExchangeDetailsViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateValues];
}

- (void) updateValues {
    self.titleLabel.text = [NSString
                            stringWithFormat:@"%@-%@",
                            self.currencyExchangeRates.sourceCurrency,
                            self.currencyExchangeRates.targetCurrency];
    
    self.buyLabel.text = [NSString
                          stringWithFormat:@"%.2f",
                          [self.currencyExchangeRates.exchangeRate doubleValue]];
    
    self.sellLabel.text = [NSString
                           stringWithFormat:@"%.2f",
                           [self.currencyExchangeRates.reversalExchangeRate doubleValue]];
    
    if (self.currencyExchangeRates != nil) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    
        self.dateLabel.text = [dateFormatter stringFromDate:self.currencyExchangeRates.validFrom];
    } else {
        self.dateLabel.text = nil;
    }
}

@end
