//
//  CurrencyExchangeRateResponseMo.h
//  ExchangeRates
//
//  Created by vmaltsev on 23.09.14.
//  Copyright © 2014 vmaltsev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CurrencyExchangeRateResponseMo : NSObject

- (CurrencyExchangeRateResponseMo*)initWithJSONObject:(NSDictionary*)json;

@property (strong, readonly) NSString *sourceCurrency;

@property (strong, readonly) NSString *targetCurrency;

@property (strong, readonly) NSDecimalNumber *exchangeRate;

@property (strong, readonly) NSDecimalNumber *reversalExchangeRate;

@property (strong, readonly) NSDate *validFrom;

@property (strong, readonly) NSDate *validTo;

@property (strong, readonly) NSString *exchangeType;

@end
