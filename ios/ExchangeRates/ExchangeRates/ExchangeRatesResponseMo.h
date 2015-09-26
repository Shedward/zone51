//
//  ExchangeRatesResponseMo.h
//  ExchangeRates
//
//  Created by vmaltsev on 23.09.14.
//  Copyright © 2014 vmaltsev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExchangeRatesResponseMo : NSObject

- (ExchangeRatesResponseMo*)initWithJSONObject:(NSDictionary*)json;

@property (strong, readonly) NSDate *serverDate;

@property (strong, readonly) NSArray *rates;

@end
