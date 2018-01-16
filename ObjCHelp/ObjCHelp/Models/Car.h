//
//  Car.h
//  ObjCHelp
//
//  Created by Radi Shikerov on 17.01.18.
//  Copyright © 2018 Radi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Car : NSObject

+ (id)carWithModel:(NSString *)carModel year:(NSNumber *)carYear fuel:(NSString *)carFuel;

- (id)initWithModel:(NSString *)carModel year:(NSNumber *)carYear fuel:(NSString *)carFuel;

@end
