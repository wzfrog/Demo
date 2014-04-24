//
//  SoapCommunication.h
//  SkyIOSDemo
//
//  Created by George on 2/5/13.
//  Copyright (c) 2013 Zoro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SKYSoapRecord.h"
#import "SKYSoapRequestDelegate.h"


@interface SKYSoapRequest : NSObject
{
    id<SKYSoapRequestDelegate> delegate;
    
    enum RequestService m_soapService;       //soap请求类型
    
    NSString *m_soapTag; 

    NSArray *m_soapParams;                  //soap请求参数列表，用来存放调用方法所需要的参数
    
    NSMutableDictionary *m_userDict;        //用户数据字典
    
}

@property(nonatomic, assign) id<SKYSoapRequestDelegate> delegate;
@property(nonatomic, assign) enum RequestService m_soapService;
@property(nonatomic, retain) NSString *m_soapTag;
@property(nonatomic, retain) NSArray *m_soapParams;
@property(nonatomic, retain) NSMutableDictionary *m_userDict;


/**调用SoapReust步骤
 * 1.初始化SoapRequest
 * 2.设置请求类别
 * 3.设置请求标识
 * 4.设置请求所需参数
 * 5.设置委托
 * 6.开始
 **/

- (void)soapRequestStart;

@end
