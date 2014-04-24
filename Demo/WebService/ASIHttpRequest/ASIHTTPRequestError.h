//
//  ASIHTTPRequestError.h
//  SrtIOSFramework
//
//  Created by  on 12-4-17.
//  Copyright (c) 2012年 Rico. All rights reserved.
//

#import <Foundation/Foundation.h>

enum ASIHTTPRequestErrorType
{
    CANCELERROR = 0,
    OTHERS = 1
};

@interface ASIHTTPRequestError : NSObject

+ (enum ASIHTTPRequestErrorType)cancelError;

@end
