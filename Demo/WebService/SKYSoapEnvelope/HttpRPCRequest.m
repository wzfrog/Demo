//
//  HttpRequest.m
//  USee
//
//  Created by George on 28/5/13.
//  Copyright (c) 2013 sky. All rights reserved.
//

#import "HttpRPCRequest.h"
#import "NSStringAdditions.h"

@implementation HttpRPCRequest
@synthesize requestTag = _requestTag;

- (id)initWithURL:(NSURL *)URL
{
    self = [super init];
    
    if(self)
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
    }
    
    
    return self;
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

//soap请求
- (ASIHTTPRequest *)httpRequest
{
    [_request setRequestMethod:@"POST"];
    
    [_request setDefaultResponseEncoding:NSUTF8StringEncoding];
    
    [_request setUseCookiePersistence:YES];
    
    [_request setShouldWaitToInflateCompressedResponses:NO];
    
    [_request setAllowCompressedResponse:YES];
    
    _request.tag = [_requestTag intValue];
    
    [_request setUserInfo:[NSDictionary dictionaryWithObject:_identifity forKey:@"identifity"]];
    
    return _request;
}

#pragma mark -

- (void)dealloc
{
    [_identifity release];
    [_request release];
    [_requestTag release];
    [super dealloc];
}

@end
