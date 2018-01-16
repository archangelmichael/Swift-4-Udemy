//
//  ViewController.m
//  ObjCHelp
//
//  Created by Radi Shikerov on 16.01.18.
//  Copyright © 2018 Radi. All rights reserved.
//

#import "ViewController.h"

#import "BasicHTTPService.h"
#import "JSONParser.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

// Get JSON Dict with cars
- (IBAction)onGetJSONCars:(id)sender {
    BasicHTTPService * basicService = [BasicHTTPService instance];
    [basicService getCarsDict:^(NSDictionary * _Nullable dataDict,
                                NSString * _Nullable errMessage) {
        if (dataDict) {
            NSLog(@"Results : %@", dataDict.debugDescription);
            [self updateUI];
        }
        else if (errMessage) {
            NSLog(@"Error : %@", errMessage);
        }
    }];
}

// Get Array with Car objects
- (IBAction)onGetCars:(id)sender {
    BasicHTTPService * basicService = [BasicHTTPService instance];

    [basicService getCars:^(NSMutableArray<Car *> * _Nullable cars,
                            NSString * _Nullable errMessage) {
        if(cars) {
            NSLog(@"Results : %@", cars.debugDescription);
            [self updateUI];
        }
        else {
            NSLog(@"Error : %@", errMessage);
        }
    }];
}

- (void)updateUI {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"Updated UI on main thread");
    });
}

@end
