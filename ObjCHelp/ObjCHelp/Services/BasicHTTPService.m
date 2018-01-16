//
//  BasicHTTPService.m
//  ObjCHelp
//
//  Created by Radi Shikerov on 16.01.18.
//  Copyright © 2018 Radi. All rights reserved.
//

#import "BasicHTTPService.h"

@implementation BasicHTTPService

static NSString * UrlBase = @"http://localhost:3003";
static NSString * UrlCars = @"/cars";

// Singelton
+ (id)instance {
    static BasicHTTPService * sharedInstance = nil;
    @synchronized(self) {
        if (sharedInstance == nil) {
            sharedInstance = [self new];
        }
    }
    
    return sharedInstance;
}

- (void)getCars {
    NSURL * carsUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", UrlBase, UrlCars]];
    NSURLSession * session = [NSURLSession sharedSession];
    
    [[session dataTaskWithURL:carsUrl
            completionHandler:^(NSData * _Nullable data,
                                NSURLResponse * _Nullable response,
                                NSError * _Nullable error) {
                if (data != nil) {
                    NSError * parseError;
                    NSDictionary * jsonCars = [NSJSONSerialization JSONObjectWithData:data
                                                                              options:0
                                                                                error:&parseError];
                    if (parseError == nil) {
                        NSLog(@"Cars fetched : %@", jsonCars.debugDescription);
                    }
                    else {
                        NSLog(@"Parse error : %@", parseError.debugDescription);
                    }
                }
                else
                {
                    NSLog(@"Request error : %@", error.debugDescription);
                }
            }] resume];
}
@end
