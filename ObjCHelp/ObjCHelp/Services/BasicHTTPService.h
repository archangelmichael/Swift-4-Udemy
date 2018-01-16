//
//  BasicHTTPService.h
//  ObjCHelp
//
//  Created by Radi Shikerov on 16.01.18.
//  Copyright © 2018 Radi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BasicHTTPService : NSObject

+ (id)instance;
- (void)getCars;

@end
