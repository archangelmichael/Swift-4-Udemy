//
//  BasicHTTPService.m
//  ObjCHelp
//
//  Created by Radi Shikerov on 16.01.18.
//  Copyright © 2018 Radi. All rights reserved.
//

#import "BasicHTTPService.h"

#import "JSONParser.h"

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

- (void)getCarsDict:(onComplete)completionHandler {
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
                        completionHandler(jsonCars, nil);
                    }
                    else {
                        completionHandler(nil, parseError.debugDescription);
                    }
                }
                else
                {
                    completionHandler(nil, error.debugDescription);
                }
            }] resume];
}

- (void)getCars:(nullable onGetCarsComplete)completionHandler {
    NSURL * carsUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", UrlBase, UrlCars]];
    NSURLSession * session = [NSURLSession sharedSession];
    
    [[session dataTaskWithURL:carsUrl
            completionHandler:^(NSData * _Nullable data,
                                NSURLResponse * _Nullable response,
                                NSError * _Nullable error) {
                if (data != nil) {
                    NSError * parseError;
                    NSArray * jsonCars = [NSJSONSerialization JSONObjectWithData:data
                                                                         options:0
                                                                           error:&parseError];
                    if (parseError == nil) {
                        NSMutableArray<Car *> *cars = [JSONParser getCars:jsonCars];
                        completionHandler(cars, nil);
                    }
                    else {
                        completionHandler(nil, parseError.debugDescription);
                    }
                }
                else
                {
                    completionHandler(nil, error.debugDescription);
                }
            }] resume];
}
@end
