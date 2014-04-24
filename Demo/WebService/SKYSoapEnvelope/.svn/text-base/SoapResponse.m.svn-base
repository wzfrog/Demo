//
//  SoapResponse.m
//  SrtIOSFramework
//
//  Created by  on 12-5-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SoapResponse.h"
#import "SoapEventBasedParser.h"

@implementation SoapResponse
@synthesize object = _object;

- (id)init
{
    self = [super init];
    if(self)
    {

    }
    
    return self;
}


- (void)parseWithData:(NSData *)data
{
    if (!data)
    {
        return;
    }
        
    SoapEventBasedParser *parser = [[SoapEventBasedParser alloc] initWithData:data];
    
    if(!parser)
    {
        [self release];
        return;
    }
    
    _object = nil;
    
    _body = [[NSString alloc] initWithData: data encoding:NSUTF8StringEncoding];
    
    _object = [[parser parse] retain];
    
    _isFault = [parser isFault];
    
    [parser release];

}

#pragma mark -

- (BOOL)isFault
{
    return _isFault;
}

- (NSNumber *)faultCode
{
    if (_isFault)
    {
        return [_object objectForKey: @"faultCode"];
    }
    
    return nil;
}

- (NSString *)faultString
{
    if (_isFault)
    {
        return [_object objectForKey: @"faultString"];
    }
    
    return nil;
}


#pragma mark -

- (NSString *)body
{
    return _body;
}

- (id)object
{
    return _object;
}

#pragma mark -

- (void)dealloc
{
    [_body release];
    [_object release];
    
    [super dealloc];
}

@end
