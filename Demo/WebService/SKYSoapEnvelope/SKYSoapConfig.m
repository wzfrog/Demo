//
//  SoapConfig.m
//  SrtIOSFramework
//
//  Created by  on 12-4-17.
//  Copyright (c) 2012年 Rico. All rights reserved.
//

#import "SKYSoapConfig.h"

@implementation SKYSoapConfig

//runMode
+ (enum SoapConfigMode)getCurrentRunMode
{
    NSString *path = [SKYSoapConfig getConfigFilePath];
    
    NSDictionary* configDic = [NSDictionary dictionaryWithContentsOfFile:path];
    
    NSNumber* runMode = (NSNumber*)[configDic valueForKey:@"runmode"];
    
    enum SoapConfigMode mode = DEBUGMODE;
    
    switch ([runMode intValue])
    {
        case 0:
            break;
            
        case 1:
            mode = RELEASEMODE;
            break;
            
        default:
            break;
    }
    
    return mode;
}

//加载配置文件路径
+ (NSString *)getConfigFilePath
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"SKYSoapConfig" ofType:@"plist"];
    
    return plistPath;
}


+ (NSString *)getServerEntry
{
    NSString *path = [SKYSoapConfig getConfigFilePath];
    
    NSDictionary* configDic = [NSDictionary dictionaryWithContentsOfFile:path];
    NSString* entry = (NSString*)[configDic valueForKey:@"serverentry"];
    
    NSLog(@"%@",entry);
    
    return entry;
}

+ (NSString *)getResourceNameSpace
{
    NSString *path = [SKYSoapConfig getConfigFilePath];
    
    NSDictionary *configDic = [NSDictionary dictionaryWithContentsOfFile:path];
    NSString *namespace = (NSString*)[configDic valueForKey:@"resourcenamespace"];
    
    return namespace;
}

+ (NSString *)getAdNameSpace
{
    NSString *path = [SKYSoapConfig getConfigFilePath];
    
    NSDictionary* configDic = [NSDictionary dictionaryWithContentsOfFile:path];
    NSString* namespace = (NSString*)[configDic valueForKey:@"adnamespace"];
    return namespace;
}

+ (NSString *)getUserNameSpace
{
    NSString *path = [SKYSoapConfig getConfigFilePath];
    
    NSDictionary* configDic = [NSDictionary dictionaryWithContentsOfFile:path];
    NSString* namespace = (NSString*)[configDic valueForKey:@"usernamespace"];
    return namespace;
}

+ (NSString *)getFileUploadPath
{
    NSString *path = [SKYSoapConfig getConfigFilePath];
    
    NSDictionary* configDic = [NSDictionary dictionaryWithContentsOfFile:path];
    NSString* namespace = (NSString*)[configDic valueForKey:@"fileuploadpath"];
    return namespace;
}

//获取分类ID
+ (NSString *)getCategoryId:(enum RequestService)service
{
    NSString *c_id = nil;
    
    switch (service)
    {
        //EPG频道分类
        case SoapEPGChannelCat:
            c_id = SOAP_EPG_CH_ID;
            break;
        
        //EPG频道列表
        case SoapEPGChannelList:
            c_id = SOAP_EPG_CH_ID;
            break;
            
        //EPG节目列表
        case SoapEPGProgramList:
            c_id = SOAP_EPG_PG_ID;
            break;
            
        //EPG节目详情
        case SoapEPGProgramDetail:
            c_id = SOAP_EPG_PG_ID;
            break;
            
        //EPG相关资源
        case SoapEPGRelations:
            c_id = SOAP_EPG_PG_ID;
            break;
        
        //影片分类
        case SoapMediaCat:
            c_id = SOAP_MOVIE_ID;
            break;
            
        //影片列表
        case SoapMediaList:
            c_id = SOAP_MOVIE_ID;
            break;
        
        //影片详情
        case SoapMediaDetail:
            c_id = SOAP_MOVIE_ID;
            break;
            
        //影片相关
        case SoapMediaRelations:
            c_id = SOAP_MOVIE_ID;
            break;
            
        //广告位
        case SoapAdInfo:
            c_id = @"";
            break;
            
        //推荐TOP榜单列表
        case SoapTopList:
            c_id = SOAP_MOVIE_ID;
            break;
            
        //TOP榜单KEY集合
        case SoapTopKeys:
            c_id = SOAP_MOVIE_ID;
            break;
            
        default:
            break;
    }
    
    return c_id;
}

@end
