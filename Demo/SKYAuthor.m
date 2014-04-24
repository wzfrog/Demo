//
//  SKYAuthor.m
//  Demo
//
//  Created by Wangzhao on 25/6/13.
//  Copyright (c) 2013 George. All rights reserved.
//

#import "SKYAuthor.h"

@implementation SKYAuthor


- (void)getAuthorizationCode
{
    if(!_request)
    {
//        NSString *clientId =[NSString stringWithFormat:@"?client_id=%@",APPKEY];
//        NSString *callBackUrl = [NSString stringWithFormat:@"&redirect_uri=%@",CallBackURL];
//        NSString *responseType = @"&response_type=code";
//        //NSString *scope = @"&scope=douban_basic_common";
//        
//        NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"%@%@%@%@",AuthorizeURL,clientId,callBackUrl,responseType]];
//        _request = [[ASIHTTPRequest alloc] initWithURL:url];
//        
//        _request = [ASIHTTPRequest requestWithURL:url];
//        [_request setDelegate:self];
//        [_request setRequestMethod:@"GET"];
//        [_request startAsynchronous];
        
        NSString *str = @"https://api.douban.com/v2/movie/subject/1764796/comments";
        NSURL *url = [NSURL URLWithString:str];
        _request = [[ASIFormDataRequest alloc] initWithURL:url];
        [_request setDelegate:self];
        [_request setRequestMethod:@"POST"];
        [_request buildRequestHeaders];
        [_request addRequestHeader:@"Authorization" value:@"Bearer ed5174e030c7f56ac7f45ea09257e03e"];
        [_request startAsynchronous];
    }
}


#pragma mark - ASIHttpRequestDelegate
- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSLog(@"%@",request.responseString);
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    
}

@end
