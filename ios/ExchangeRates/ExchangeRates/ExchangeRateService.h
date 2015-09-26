//
//  ExchangeRateService.h
//  ExchangeRates
//
//  Created by vmaltsev on 22.09.14.
//  Copyright © 2014 vmaltsev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ExchangeRatesResponseMo.h"

typedef void(^exchangeRatesResponseHandler)(ExchangeRatesResponseMo*, NSURLResponse*, NSError*);

@interface ExchangeRateService : NSObject

+ (void) getBasicExchangeRatesFromTable:(NSString*)table count:(int)count completionHandler:(exchangeRatesResponseHandler)handler;

@end
