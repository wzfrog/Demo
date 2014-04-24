//
//  iSerialize.h
//  SrtIOSFramework
//
//  Created by  on 12-4-23.
//  Copyright (c) 2012年 Rico. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SKYSoapConfig.h"

@protocol iSerialize <NSObject>

- (NSString*)serialize;

- (void)setMethod: (NSString *)method inNameSpace:(NSString*)methodNS withParameters: (NSArray *)parameters;

- (NSString*)method;

- (NSString*)nameSpace;

@end
