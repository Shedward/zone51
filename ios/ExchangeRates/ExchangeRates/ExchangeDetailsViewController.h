//
//  ExchangeDetailsViewController.h
//  ExchangeRates
//
//  Created by vmaltsev on 24.09.14.
//  Copyright © 2014 vmaltsev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CurrencyExchangeRateResponseMo.h"

@interface ExchangeDetailsViewController : UIViewController

@property (strong) CurrencyExchangeRateResponseMo *currencyExchangeRates;

@end
