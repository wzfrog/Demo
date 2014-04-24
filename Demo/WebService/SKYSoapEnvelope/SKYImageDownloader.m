//
//  SkyImageDownloader.m
//  SkyIOSDemo
//
//  Created by George on 21/5/13.
//  Copyright (c) 2013 Zoro. All rights reserved.
//

#import "SkyImageDownloader.h"
#import "SKYSoapRecord.h"

@interface SKYImageDownloader()
{
    NSMutableData   *activeDownload;    //图片数据
    NSURLConnection *imageConnection;   //图片链接
}

@end

@implementation SKYImageDownloader


@synthesize delegate;
@synthesize m_soapRecord = _m_soapRecord;
@synthesize m_index = _m_index;


//开始下载
- (void)startDownload
{
    activeDownload = [[NSMutableData alloc] init];
   
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_m_soapRecord.m_imageURL]] delegate:self];
    imageConnection = conn;
    [conn release];
}


//取消下载
- (void)cancelDownload
{
    [imageConnection cancel];
    imageConnection = nil;
    activeDownload = nil;
}

//请求成功
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    //ZNLog(@"recieve image data!");
    [activeDownload appendData:data];

}

//请求失败
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSString *string = @"recieve image data failed!";
    [self.delegate downloadFailed:string];
    activeDownload = nil;
    imageConnection = nil;
}

//设置appIcon
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    UIImage *image = [[UIImage alloc] initWithData:activeDownload];
    
    NSData *imageData = UIImageJPEGRepresentation(image,1.0);
    
    UIImage *finalImage = [[UIImage alloc] initWithData:imageData];
    
    _m_soapRecord.m_image = finalImage;
    
    activeDownload = nil;
    
    [image release];
    
    [finalImage release];
    
    imageConnection = nil;
    
    [delegate downloadFinished:_m_index];
    
}

- (void)dealloc
{
    [_m_soapRecord release];
    
    [activeDownload release];
    
    [imageConnection cancel];
    [imageConnection release];
    
    [super dealloc];
}

@end
