//
//  SoapConnectDelegate.h
//  SrtIOSFramework
//
//  Created by  on 12-5-7.
//  Copyright (c) 2012年 Rico. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SoapConnection, SoapRPCRequest, SoapResponse,ASIHTTPRequest;

@protocol SoapConnectDelegate <NSObject>

@required
- (void)request:(ASIHTTPRequest *)request didReceiveResponse: (SoapResponse *)response;

@optional
- (void)request:(ASIHTTPRequest *)request didSendBodyData: (float)percent;

@required
- (void)request:(ASIHTTPRequest *)request didFailWithError: (NSError *)error;


@end
