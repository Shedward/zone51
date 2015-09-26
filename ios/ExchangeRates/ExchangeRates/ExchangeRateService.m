//
//  ExchangeRateService.m
//  ExchangeRates
//
//  Created by vmaltsev on 22.09.14.
//  Copyright © 2014 vmaltsev. All rights reserved.
//

#import "ExchangeRateService.h"
#import "NSString+TemplateBinding.h"

NSString* const kServiceUrl = @"https://online.bcs.ru/bcsmbs/remoting/ExchangeRateService";

NSString* const kRequestTemplate =
@"{\"arguments\":[{\n"
"	\"count\":${count},\n"
"	\"exchangeRateTable\":\"${exchangeRateTable}\",\n"
"	\"javaClass\":\"cz.bsc.g6.components.exchangerate.json.services.api.mo.GetBasicExchangeRatesRequestMo\"\n"
"}],\n"
"\"javaClass\":\"org.springframework.remoting.support.RemoteInvocation\",\n"
"\"attributes\":null,\n"
"\"methodName\":\"getBasicExchangeRates\",\n"
"\"parameterTypes\":[\"cz.bsc.g6.components.exchangerate.json.services.api.mo.GetBasicExchangeRatesRequestMo\"]}";

@implementation ExchangeRateService
+ (void) getBasicExchangeRatesFromTable:(NSString *)table count:(int)count completionHandler:(exchangeRatesResponseHandler)handler {
    
    NSURL *url = [NSURL URLWithString:kServiceUrl];
    
    NSString *requestBody = [kRequestTemplate
                             stringByEvaluatingTemplateWithData: @{
                                        @"count": [NSNumber numberWithInt:count],
                                        @"exchangeRateTable": table
                                        }];
    
    NSLog(@"Send:%@", requestBody);
    
  
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[requestBody dataUsingEncoding:NSUTF8StringEncoding]];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *  data, NSURLResponse *response, NSError *error)
    {
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"Received %@", str);
        
        ExchangeRatesResponseMo *exchangeRates = nil;
        
        if (error == nil && data != nil) {
            id jsonObj = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            
            if (error == nil && jsonObj != nil) {
                if ([jsonObj isKindOfClass:[NSDictionary class]]) {
                    exchangeRates = [[ExchangeRatesResponseMo alloc] initWithJSONObject:jsonObj];
                } else {
                    NSDictionary *userInfo = @{
                                               NSLocalizedDescriptionKey: NSLocalizedString(@"Wrong response", nil),
                                               NSLocalizedFailureReasonErrorKey: NSLocalizedString(@"Server responded with a JSON array instead of dictionary", nil)
                                               };
                    
                    error = [NSError errorWithDomain:@"com.acme.ExchangeRates" code:-1 userInfo:userInfo];
                }
            }
        }

        handler(exchangeRates, response, error);
    }];
    
    [postDataTask resume];
}

@end
