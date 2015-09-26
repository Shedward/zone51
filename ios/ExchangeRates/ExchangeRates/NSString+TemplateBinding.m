//
//  NSString+TemplateBinding.m
//  ExchangeRates
//
//  Created by vmaltsev on 23.09.14.
//  Copyright © 2014 vmaltsev. All rights reserved.
//

#import "NSString+TemplateBinding.h"

@implementation NSString (TemplateBinding)

- (NSString*) stringByEvaluatingTemplateWithData:(NSDictionary *)data {
    NSString *tempString = [self mutableCopy];
    
    for (NSString *key in data) {
        NSString *val  = [NSString stringWithFormat: @"%@", data[key]];
        NSString *valPlaceholder = [NSString stringWithFormat:@"${%@}", key];
        
        tempString = [tempString stringByReplacingOccurrencesOfString:valPlaceholder withString:val];
    }
    
    return tempString;
}

@end
