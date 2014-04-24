//
//  SoapConnection.m
//  SrtIOSFramework
//
//  Created by  on 12-5-8.
//  Copyright (c) 2012年 Rico. All rights reserved.
//

#import "SoapConnection.h"
#import "SoapRequestManager.h"
#import "SoapResponse.h"

@implementation SoapConnection
@synthesize response = _response;

- (id)initWithXMLRPCRequest:(SoapRPCRequest *)request delegate: (id<SoapConnectDelegate>)delegate manager: (SoapRequestManager *)manager
{
    self = [super init];
    if (self)
    {
        requestTag = 1;
        _manager = [manager retain];
        _soapRequest = [request retain];
        _data = [[NSMutableData alloc] init];
        
        _response = [[SoapResponse alloc] init];

        _delegate = [delegate retain];
        
        _asirequest = [_soapRequest soapRequest];
        
        [_asirequest setDelegate:self];

        NSTimeInterval interval = 10;
        
        [_asirequest setTimeOutSeconds:interval];
        
        [_manager addOperator:_asirequest];
        
        if (_asirequest)
        {
            ZNLog(@"The connection, %@, has been established!", [_soapRequest identifity]);
        }
        else
        {
            ZNLog(@"The connection, %@, could not be established!", [_soapRequest identifity]);
            
            [self release];
            
            return nil;
        }
    }
    
    return self;
}


- (id)initWithHttpRPCRequest: (HttpRPCRequest *)request delegate: (id<SoapConnectDelegate>)delegate manager: (SoapRequestManager *)manager
{
    self = [super init];
    if (self)
    {
        requestTag = 2;
        _manager = [manager retain];
        _httpRequest = [request retain];
        _data = [[NSMutableData alloc] init];
        
        _response = [[SoapResponse alloc] init];
        
        _delegate = [delegate retain];
        
        _asirequest = [_httpRequest httpRequest];
        
        [_asirequest setDelegate:self];
        
        NSTimeInterval interval = 10;
        
        [_asirequest setTimeOutSeconds:interval];
        
        [_manager addOperator:_asirequest];
        
        if (_asirequest)
        {
            ZNLog(@"The connection, %@, has been established!", [_httpRequest identifity]);
        }
        else
        {
            ZNLog(@"The connection, %@, could not be established!", [_httpRequest identifity]);
            
            [self release];
            
            return nil;
        }
    }
    
    return self;
}


- (NSString *)soapIdentifier
{
    return [_soapRequest identifity];
}

- (NSString *)httpIdentifier
{
    return [_httpRequest identifity];
}

- (id<SoapConnectDelegate>)delegate
{
    return _delegate;
}

-(void)cancel
{
    if (_asirequest)
    {
        [_asirequest cancel];
    }
}

-(void)dealloc
{
    [_delegate release];
    [_manager release];
    [_soapRequest release];
    [_httpRequest release];
    [_data release];
    [_response release];
    _asirequest = nil;
    
    [super dealloc];
}

#pragma mark - ASIHTTPRequestDelegate Method
- (void)request:(ASIHTTPRequest *)request didReceiveData:(NSData *)data
{
    ZNLog(@"SoapConnection: receiverdata");
    
    [_data appendData:data];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    ZNLog(@"SoapConnection: failed");
    
    if (_delegate)
    {
        [_delegate request:request didFailWithError: request.error];
    }
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    ZNLog(@"SoapConnection: finished");
    
    if (_data && [_data length] > 0)
    {
        switch (requestTag)
        {
            case 1:
                
                [_response parseWithData: _data];
                
                if (_delegate )
                {
                    [_delegate request:request didReceiveResponse:_response.object];
                }
                
                break;
                
            case 2:
            {
                id object = [[NSString alloc] initWithData:_data encoding:NSUTF8StringEncoding];
                
                if (_delegate )
                {
                    [_delegate request:request didReceiveResponse:object];
                }
            }
                break;
                
            default:
                break;
        }
        
    }
    
    else
    {
        ZNLog(@"SoapConnection: recieve data is empty!");
    }
    
}

- (void)request:(ASIHTTPRequest *)request didReceiveResponseHeaders:(NSDictionary *)responseHeaders
{
    ZNLog(@"SoapConnection: receive header");
    
    int statusCode = [request responseStatusCode];
    
    if (statusCode >= 400)
    {
        NSError *error = [NSError errorWithDomain: @"HTTP" code: statusCode userInfo: nil];
        
        if (_delegate)
        {
            [_delegate request:request didFailWithError: error];
        }
    }
    
    [_data setLength:0];
}

@end
