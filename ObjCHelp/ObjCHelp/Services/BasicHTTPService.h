//
//  BasicHTTPService.h
//  ObjCHelp
//
//  Created by Radi Shikerov on 16.01.18.
//  Copyright © 2018 Radi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^onComplete)(NSDictionary * __nullable dataDict, NSString * __nullable errMessage);

@interface BasicHTTPService : NSObject

+ (id __nullable)instance;
- (void)getCars:(nullable onComplete)completionHandler;

@end
