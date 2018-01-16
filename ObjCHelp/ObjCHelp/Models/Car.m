//
//  Car.m
//  ObjCHelp
//
//  Created by Radi Shikerov on 17.01.18.
//  Copyright © 2018 Radi. All rights reserved.
//

#import "Car.h"

@interface Car() {
    NSString * model;
    NSNumber * year;
    NSString * fuel;
}

@end

@implementation Car

+ (id)carWithModel:(NSString *)carModel year:(NSNumber *)carYear fuel:(NSString *)carFuel {
    return [[Car alloc] initWithModel:carModel year:carYear fuel:carFuel];
}

- (id)initWithModel:(NSString *)carModel year:(NSNumber *)carYear fuel:(NSString *)carFuel {
    self = [super init];
    if (self != nil) {
        model = carModel;
        year = carYear;
        fuel = carFuel;
    }
    
    return self;
}

@end
