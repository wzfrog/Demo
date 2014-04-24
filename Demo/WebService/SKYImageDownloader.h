//
//  SkyImageDownloader.h
//  SkyIOSDemo
//
//  Created by George on 21/5/13.
//  Copyright (c) 2013 Zoro. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SKYImageDownloaderDelegate

/**图片下载成功回调函数
 * indexPath为对象索引，用以取对应记录的图片
 **/
- (void)downloadFinished:(NSInteger)index;

//图片下载失败
- (void)downloadFailed:(NSString *)error;

@end

@class SKYSoapRecord;
@interface SKYImageDownloader : NSObject

@property(nonatomic, retain) SKYSoapRecord  *m_soapRecord;       //结果对象
@property(nonatomic, assign) NSInteger m_index;               //对象索引
@property(nonatomic, assign) id<SKYImageDownloaderDelegate> delegate;


//开始下载图片
- (void)startDownload;

//取消下载
- (void)cancelDownload;

@end
