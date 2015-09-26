//
//  ExchangeRatesResponseMo.m
//  ExchangeRates
//
//  Created by vmaltsev on 23.09.14.
//  Copyright © 2014 vmaltsev. All rights reserved.
//

#import "ExchangeRatesResponseMo.h"
#import "CurrencyExchangeRateResponseMo.h"
#import "NSDictionary+Helpers.h"

@implementation ExchangeRatesResponseMo

- (ExchangeRatesResponseMo*)initWithJSONObject:(NSDictionary *)json {
    if (self = [super init]) {
        
        if (json == nil) {
            return nil;
        }
        
        _serverDate = [json dateValueForKey:@"serverDate"];
        
        NSDictionary* ratesJSON = [json objectOrNilForKey:@"rates"];
        NSArray* ratesListJSON = [ratesJSON objectOrNilForKey:@"list"];
        
        if (ratesListJSON != nil) {
            NSMutableArray *rates = [[NSMutableArray alloc] initWithCapacity:ratesListJSON.count];
            
            for (NSDictionary *currencyExchangeJSON in ratesListJSON) {
                if (currencyExchangeJSON != nil) {
                    CurrencyExchangeRateResponseMo *currencyExchange = [[CurrencyExchangeRateResponseMo alloc] initWithJSONObject:currencyExchangeJSON];
                    
                    [rates addObject:currencyExchange];
                }
            }
            
            _rates = rates;
        }
    }
    
    return self;
}

@end
