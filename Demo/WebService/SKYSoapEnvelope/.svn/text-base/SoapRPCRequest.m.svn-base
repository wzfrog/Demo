//
//  SoapRPCRequest.m
//  SrtIOSFramework
//
//  Created by  on 12-5-7.
//  Copyright (c) 2012年 Rico. All rights reserved.
//

#import "SoapRPCRequest.h"
#import "SoapSerialize.h"
#import "NSStringAdditions.h"

@implementation SoapRPCRequest

@synthesize soapSerialize = _soapSerialize;
@synthesize requestTag = _requestTag;

- (id)initWithURL:(NSURL *)URL andSoapSerialize:(id<iSerialize>)serialize
{
    self = [super init];
    if (self)
    {
        if (URL)
        {
            _request = [[ASIHTTPRequest alloc] initWithURL:URL];
        }
        else
        {
            _request = [[ASIHTTPRequest alloc] init];
        }
        
        _identifity = [[NSString stringByGeneratingUUID] retain];

        self.soapSerialize = serialize;
    }
    
    return self;
}

- (id)initWithURL:(NSURL *)URL
{
    return [self initWithURL:URL andSoapSerialize:[[[SoapSerialize alloc] init] autorelease] ];
}

#pragma mark -

- (void)setURL:(NSURL *)URL
{
    [_request setURL:URL];
}

- (NSURL *)URL
{
    return [_request url];
}

- (NSString *)identifity
{
    return _identifity;
}

#pragma mark - ASIHttpRequest 

- (ASIHTTPRequest *)soapRequest
{
    NSString *serializeString = [_soapSerialize serialize];
    
    [_request setRequestHeaders:[NSMutableDictionary dictionaryWithObjects:
                                 [NSArray arrayWithObjects:@"text/xml;charset=utf-8",
                                    [NSString stringWithFormat:@"%@/%@",[_soapSerialize nameSpace],[_soapSerialize method]],
                                    [NSString stringWithFormat:@"%d",[serializeString length]], nil]
                                 forKeys:[NSArray arrayWithObjects:@"Content-Type", @"SOAPAction",@"Content-Length",nil]]];
    
    [_request setRequestMethod:@"POST"];
    
    [_request appendPostData:[NSMutableData dataWithData:[serializeString dataUsingEncoding:NSUTF8StringEncoding]]];
    
    [_request setDefaultResponseEncoding:NSUTF8StringEncoding];
    
    [_request setShouldWaitToInflateCompressedResponses:NO];
    
    [_request setAllowCompressedResponse:YES];
    
    _request.tag = [_requestTag intValue];
    
    [_request setUserInfo:[NSDictionary dictionaryWithObject:_identifity forKey:@"identifity"]];
    
    return _request;
}

- (NSString*)method
{
    return [_soapSerialize method];
}

#pragma mark -

- (void)dealloc
{
    [_identifity release];
    [_request release];
    [_requestTag release];
    self.soapSerialize = nil;
    [super dealloc];
}

@end
