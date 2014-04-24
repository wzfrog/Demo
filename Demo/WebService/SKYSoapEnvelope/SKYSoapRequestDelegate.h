//
//  SoapRequestDelegate.h
//  SkyIOSDemo
//
//  Created by George on 8/5/13.
//  Copyright (c) 2013 Zoro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SoapSerialize.h"

@protocol SKYSoapRequestDelegate

- (void)soapRequestFinished:(NSArray *)response withSoapRequestService:(enum RequestService)service withSoapRequestTag:(NSInteger)tag;

- (void)soapRequestFailed:(NSString *)error withSoapRequestService:(enum RequestService)service withSoapRequestTag:(NSInteger)tag;

@end

