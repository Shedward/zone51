//
//  NSString+TemplateBinding.h
//  ExchangeRates
//
//  Created by vmaltsev on 23.09.14.
//  Copyright © 2014 vmaltsev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (TemplateBinding)

// Return string with ${placeholders} replaced by values from data by key.
- (NSString *)stringByEvaluatingTemplateWithData:(NSDictionary*)data;

@end
