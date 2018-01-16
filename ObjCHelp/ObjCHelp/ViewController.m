//
//  ViewController.m
//  ObjCHelp
//
//  Created by Radi Shikerov on 16.01.18.
//  Copyright © 2018 Radi. All rights reserved.
//

#import "ViewController.h"

#import "BasicHTTPService.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)onGetCars:(id)sender {
    BasicHTTPService * basicService = [BasicHTTPService instance];
    [basicService getCars:^(NSDictionary * _Nullable dataDict, NSString * _Nullable errMessage) {
        if (dataDict) {
            NSLog(@"Results : %@", dataDict.debugDescription);
        }
        else if (errMessage) {
            NSLog(@"Error : %@", errMessage);
        }
    }];
}

@end
