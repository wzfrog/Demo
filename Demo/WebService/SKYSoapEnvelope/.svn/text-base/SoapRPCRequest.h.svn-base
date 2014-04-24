//
//  SoapRPCRequest.h
//  SrtIOSFramework
//
//  Created by  on 12-5-7.
//  Copyright (c) 2012年 Rico. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "iSerialize.h"

@interface SoapRPCRequest : NSObject
{
    ASIHTTPRequest *_request;
    NSString *_identifity;
}


@property (nonatomic, assign) id<iSerialize>soapSerialize;
@property (nonatomic, retain) NSString *requestTag;

- (id)initWithURL: (NSURL *)URL andSoapSerialize:(id<iSerialize>)serialize;

- (void)setURL:(NSURL *)URL;

- (NSURL *)URL;

- (NSString *)method;

- (NSString *)identifity;

- (ASIHTTPRequest *)soapRequest;

@end
