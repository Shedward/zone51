//
//  NSDictionary.h
//  ExchangeRates
//
//  Created by vmaltsev on 24.09.14.
//  Copyright © 2014 vmaltsev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Helpers)

// Unwrap java.sql.timestamp JSON wrapper
- (NSDate*) dateValueForKey:(NSString*) key;

// Return object for key, if object is NSNull return nil instead.
- (id) objectOrNilForKey:(NSString*) key;

@end
