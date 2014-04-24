//
//  SkyImageUploader.h
//  USee
//
//  Created by George on 9/6/13.
//  Copyright (c) 2013 sky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"

@protocol SKYImageUploaderDelegate

//图像上传成功
- (void)uploadFinished:(NSString *)imageUrl;

//图像上传失败
- (void)uploadFailed:(NSString *)error;

@end

@interface SKYImageUploader : NSObject<ASIHTTPRequestDelegate>

@property(nonatomic,retain) NSString *m_imagePath;   //图像路径
@property(nonatomic,retain) NSString *m_imageName;   //图像名称
@property(nonatomic,retain) id<SKYImageUploaderDelegate> delegate;

//开始上传
- (void)startUpload;

//取消上传
- (void)cancelUpload;

@end
