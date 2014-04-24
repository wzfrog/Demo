//
//  ZNLog.h
//  SrtIOSFramework
//
//  Created by  on 12-4-21.
//  Copyright (c) 2012年 Rico. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZNLog : NSObject

+ (void)file:(char*)sourceFile function:(char*)functionName lineNumber:(int)lineNumber format:(NSString*)format,...;

#ifdef DEBUG
#define ZNLog(s,...) [ZNLog file:__FILE__ function:(char *)__FUNCTION__ lineNumber:__LINE__ format:(s),##__VA_ARGS__]
#else
#define ZNLog(s,...)
#endif

@end
