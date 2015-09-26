//
//  NSDictionary.m
//  ExchangeRates
//
//  Created by vmaltsev on 24.09.14.
//  Copyright © 2014 vmaltsev. All rights reserved.
//

#import "NSDictionary+Helpers.h"

@implementation NSDictionary (Helpers)

- (NSDate*) dateValueForKey:(NSString*) key {
    
    NSDictionary *dateObject = [self objectOrNilForKey:key];
    NSNumber *timestamp = [dateObject objectOrNilForKey:@"time"];
    
    if (timestamp == nil) {
        return nil;
    }
    
    // java.sql.timestamp is milliseconds
    return [NSDate dateWithTimeIntervalSince1970:[timestamp longLongValue] / 1000];
}

- (id) objectOrNilForKey:(NSString*) key {
    id value = [self valueForKey:key];
    return value != [NSNull null] ? value : nil;
}

@end
