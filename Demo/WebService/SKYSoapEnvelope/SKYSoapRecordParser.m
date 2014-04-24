    //
//  SoapRecord.m
//  SkyIOSDemo
//
//  Created by George on 12/5/13.
//  Copyright (c) 2013 Zoro. All rights reserved.
//

#import "SKYSoapRecordParser.h"
#import "JSONKit.h"
#import "SKYSoapRecord.h"

static SKYSoapRecordParser *sharedInstance = nil;

@implementation SKYSoapRecordParser

- (id)init
{
    self = [super init];
    if(self){}
    
    return self;
}


#pragma mark - Singleton Method

+ (SKYSoapRecordParser *)sharedRecordParser
{
    @synchronized(self)
    {
        if (!sharedInstance)
        {
            sharedInstance = [[self alloc] init];
        }
    }
    
    return sharedInstance;
}

+ (id)allocWithZone: (NSZone *)zone
{
    @synchronized(self)
    {
        NSAssert(sharedInstance == nil, @"SoapRequestManager is singleton, please call sharedManager");
        
        if (!sharedInstance)
        {
            sharedInstance = [super allocWithZone: zone];
            
            return sharedInstance;
        }
        
    }
    
    return nil;
}

//按照soap类型解析结果
- (NSMutableArray *)recordParser:(id)object withSoapType:(enum RequestService)type
{
    //解析字典时的key值
    NSString *dicKey = nil;
    
    switch (type)
    {
        //EPG频道分类
        case SoapEPGChannelCat:
            dicKey = @"child";
            break;
            
        //EPG频道列表
        case SoapEPGChannelList:
            dicKey = @"result";
            break;
            
        //EPG节目列表
        case SoapEPGProgramList:
            dicKey = @"result";
            break;
            
        //EPG节目详情
        case SoapEPGProgramDetail:
            dicKey = @"";
            break;
            
        //EPG节目相关
        case SoapEPGRelations:
            dicKey = @"media";
            break;
            
        //影片分类
        case SoapMediaCat:
            dicKey = @"child";
            break;
            
        //影片列表
        case SoapMediaList:
            dicKey = @"result";
            break;
        
        //影片详情
        case SoapMediaDetail:
            dicKey = @"";
            break;
            
        //影片相关
        case SoapMediaRelations:
            dicKey = @"media";
            break;
       
        //广告位
        case SoapAdInfo:
            dicKey = @"";
            break;
          
        //TOP榜单列表
        case SoapTopList:
            dicKey = @"result";
            break;
            
        //TOP榜单KEY集合
        case SoapTopKeys:
            dicKey = @"";
            break;
            
        //用户注册
        case HttpUserRegister:
            dicKey = @"";
            break;
            
        //用户登陆
        case HttpUserLogin:
            dicKey = @"";
            break;
            
        //获取用户信息
        case HttpGetUserInfo:
            dicKey = @"";
            break;
        
        default:
            break;
            
    }

    
    //解析完后需要返回的数组
    NSMutableArray *recordArray = [NSMutableArray array];
    
    NSString *result = object;
    
//    if(type == HttpUpdateUserInfo)
//    {
//        NSLog(@"--------%@",result);
//    }
    
    NSMutableArray *arr = [NSMutableArray array];
    
    if(type == HttpUserRegister || type == HttpUserLogin || type == HttpUpdateUserInfo)
    {
        [arr addObject:result];
        return arr;
    }
    
    //返回结果为单一数据时
    if(dicKey.length == 0)
    {
        arr = [result objectFromJSONString];
        
        if(type == HttpGetUserInfo)
        {
            //NSLog(@"------%@",arr);
        }
    }
    //返回数组
    else
    {
        NSDictionary *dic = [result objectFromJSONString];
        
        if(type == SoapEPGProgramDetail)
        {
            //NSLog(@"=========%@",dic);
        }
        
        arr = [dic objectForKey:dicKey];
    }
    
    
    NSDictionary *dict = [NSDictionary dictionary];

    //遍历数组
    for(int i = 0; i < arr.count; i++)
    {
        dict = arr[i];
        
        SKYSoapRecord *appRecord = [[SKYSoapRecord alloc] initWithDic:dict withType:type];
        [recordArray addObject:appRecord];
    }
    
    dicKey = nil;
    
    
    return recordArray;

}

@end
