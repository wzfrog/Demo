//
//  SkyImageUploader.m
//  USee
//
//  Created by George on 9/6/13.
//  Copyright (c) 2013 sky. All rights reserved.
//

#import "SKYImageUploader.h"
#import "SKYSoapConfig.h"

@interface  SKYImageUploader()
{
    ASIFormDataRequest *_request;
}

@end

@implementation SKYImageUploader
@synthesize delegate;
@synthesize m_imageName = _m_imageName;
@synthesize m_imagePath = _m_imagePath;

- (void)startUpload
{
    NSString *uploadPath = [SKYSoapConfig getFileUploadPath];
    
    NSURL *url = [NSURL URLWithString:uploadPath];
    
    if(!_request)
    {
        _request = [[ASIFormDataRequest alloc] initWithURL:url];
    }
    
    NSData *imageData = [NSData dataWithContentsOfFile:_m_imagePath];
    
    
    [_request setURL:url];
    [_request setDelegate:self];
    [_request setTimeOutSeconds:15];
    [_request setRequestMethod:@"POST"];
    [_request setFile:_m_imagePath forKey:@"pic"];
    [_request addData:imageData withFileName:_m_imageName andContentType:@"image/jpeg" forKey:@"photos"];
    [_request startAsynchronous];
    
}

- (void)cancelUpload
{
    [_request cancel];
    NSString *str = @"图像上传取消";
    [self.delegate uploadFailed:str];
}

#pragma mark - ASIFormDataRequest Method
- (void)requestFinished:(ASIFormDataRequest *)request
{
    NSString *imageUrl = [request responseString];
    imageUrl = [NSString stringWithFormat:@"http://%@",imageUrl];
    [self.delegate uploadFinished:imageUrl];
}

- (void)requestFailed:(ASIFormDataRequest *)request
{
    [request cancel];
    NSString *error = @"图像上传失败，请重新上传!";
    [self.delegate uploadFailed:error];
}

- (void)dealloc
{
    [super dealloc];
    [_m_imagePath release];
    [_m_imageName release];
}

@end
