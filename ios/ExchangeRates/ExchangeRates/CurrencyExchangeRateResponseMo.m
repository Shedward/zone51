//
//  CurrencyExchangeRateResponseMo.m
//  ExchangeRates
//
//  Created by vmaltsev on 23.09.14.
//  Copyright © 2014 vmaltsev. All rights reserved.
//

#import "CurrencyExchangeRateResponseMo.h"
#import "NSDictionary+Helpers.h"

@implementation CurrencyExchangeRateResponseMo

- (CurrencyExchangeRateResponseMo*) initWithJSONObject:(NSDictionary *)json {
    
    if (self = [super init]) {
        
        if (json == nil) {
            return nil;
        }
        
        _sourceCurrency = [json objectOrNilForKey:@"refCurrency"];
        _targetCurrency = [json objectOrNilForKey:@"currency"];
        _exchangeRate = [json objectOrNilForKey:@"buyRate"];
        _reversalExchangeRate = [json objectOrNilForKey:@"sellRate"];
        _exchangeType = [json objectOrNilForKey:@"exchangeType"];
        _validFrom = [json dateValueForKey: @"date"];
        _validTo = [json dateValueForKey: @"validTo"];
    }
    
    return self;
}

@end
