//
//  HttpRequest.h
//  USee
//
//  Created by George on 28/5/13.
//  Copyright (c) 2013 sky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

@interface HttpRPCRequest : NSObject
{
    ASIHTTPRequest *_request;
    NSString *_identifity;
}

@property (nonatomic, retain) NSString *requestTag;

- (id)initWithURL:(NSURL *)URL;

- (void)setURL:(NSURL *)URL;

- (NSURL *)URL;

- (NSString *)identifity;

- (ASIHTTPRequest *)httpRequest;

@end
