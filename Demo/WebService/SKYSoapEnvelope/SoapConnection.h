//
//  SoapConnection.h
//  SrtIOSFramework
//
//  Created by  on 12-5-8.
//  Copyright (c) 2012年 Rico. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SoapRPCRequest.h"
#import "HttpRPCRequest.h"
#import "SoapConnectDelegate.h"

@class SoapRequestManager;
@class SoapResponse;

@interface SoapConnection : NSObject<ASIHTTPRequestDelegate>
{
    SoapRPCRequest *_soapRequest;
    HttpRPCRequest *_httpRequest;
    NSMutableData *_data;
    
    NSInteger requestTag;
    
    @public
    id<SoapConnectDelegate> _delegate;
    
    SoapRequestManager *_manager;
    
    ASIHTTPRequest *_asirequest;
}

@property(nonatomic,strong)SoapResponse *response;


- (id)initWithXMLRPCRequest:(SoapRPCRequest *)request delegate: (id<SoapConnectDelegate>)delegate manager:(SoapRequestManager *)manager;

- (id)initWithHttpRPCRequest:(HttpRPCRequest *)request delegate: (id<SoapConnectDelegate>)delegate manager:(SoapRequestManager *)manager;


- (NSString *)soapIdentifier;

- (NSString *)httpIdentifier;

- (id<SoapConnectDelegate>)delegate;

- (void)cancel;


@end
