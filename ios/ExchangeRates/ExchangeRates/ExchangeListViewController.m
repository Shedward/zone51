//
//  ViewController.m
//  ExchangeRates
//
//  Created by vmaltsev on 22.09.14.
//  Copyright © 2014 vmaltsev. All rights reserved.
//

#import "ExchangeListViewController.h"
#import "ExchangeRateService.h"
#import "CurrencyExchangeRateResponseMo.h"
#import "ExchangeDetailsViewController.h"


@interface ExchangeListViewController ()

@property (strong) NSArray *currencyExchangeRates;

@end

@implementation ExchangeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [ExchangeRateService getBasicExchangeRatesFromTable:@"BCSCR"
                                                  count:4
                                      completionHandler:^(ExchangeRatesResponseMo *exchanges, NSURLResponse *resp, NSError *err)
    {
        if (err != nil || exchanges == nil) {
            NSLog(@"Failed getBasicExchangeRates: %@", err);
            NSLog(@"Failed response: %@", resp);
            
            return;
        }
        
        self.currencyExchangeRates = exchanges.rates;
        [self.tableView reloadData];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.currencyExchangeRates count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellReuseIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuseIdentifier];
    }
    
    CurrencyExchangeRateResponseMo *currencyExchangeRates = [self.currencyExchangeRates objectAtIndexedSubscript:indexPath.row];
    
    cell.textLabel.text = [NSString
                           stringWithFormat:@"%@-%@",
                           currencyExchangeRates.sourceCurrency,
                           currencyExchangeRates.targetCurrency];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CurrencyExchangeRateResponseMo *currencyExchangeRates = [self.currencyExchangeRates objectAtIndexedSubscript:indexPath.row];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ExchangeDetailsViewController *detailsController = [sb instantiateViewControllerWithIdentifier:@"exchangeDetails"];
    
    detailsController.currencyExchangeRates = currencyExchangeRates;
    
    [self.navigationController pushViewController:detailsController animated:YES];
}

@end