//
//  JSONParser.m
//  ObjCHelp
//
//  Created by Radi Shikerov on 17.01.18.
//  Copyright © 2018 Radi. All rights reserved.
//

#import "JSONParser.h"

#import "Car.h"

@implementation JSONParser

+ (NSMutableArray<Car *> *)getCars:(NSArray *)carsData {
    NSMutableArray<Car *> *cars = [NSMutableArray new];
    for (NSDictionary * carData in carsData) {
        NSString * model = [carData objectForKey:@"model"];
        NSNumber * year = [NSNumber numberWithInt: [[carData objectForKey:@"year"] intValue]];
        NSString * fuel = [carData objectForKey:@"fuel"];
        
        [cars addObject:[Car carWithModel:model year:year fuel:fuel]];
    }
    
    return cars;
}

@end
