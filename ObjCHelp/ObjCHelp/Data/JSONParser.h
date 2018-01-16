//
//  JSONParser.h
//  ObjCHelp
//
//  Created by Radi Shikerov on 17.01.18.
//  Copyright © 2018 Radi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Car;

@interface JSONParser : NSObject

+ (NSMutableArray<Car *> *)getCars:(NSArray *)carsData;

@end
