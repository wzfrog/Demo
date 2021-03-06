//
//  SoapResponse.h
//  SrtIOSFramework
//
//  Created by  on 12-5-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SKYSoapConfig.h"


@interface SoapResponse : NSObject
{
    NSString * _body;
    BOOL _isFault;
}

@property(nonatomic,strong) id object;



- (void)parseWithData: (NSData *)data;

- (BOOL)isFault;

- (NSNumber *)faultCode;

- (NSString *)faultString;

- (NSString *)body;

@end

