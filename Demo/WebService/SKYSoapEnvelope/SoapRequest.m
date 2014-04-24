//
//  SoapCommunication.m
//  SkyIOSDemo
//
//  Created by George on 2/5/13.
//  Copyright (c) 2013 Zoro. All rights reserved.
//
#import "SKYSoapRequest.h"
#import "SoapRPCRequest.h"
#import "HttpRPCRequest.h"
#import "SoapRequestManager.h"
#import "SKYSoapRecordParser.h"
#import "SoapConnectDelegate.h"
#import "NSStringAdditions.h"


@interface SKYSoapRequest()<SoapConnectDelegate>
{
    SoapSerialize *serialize;
    
    SoapRPCRequest *soapRPCRequest;
    HttpRPCRequest *httpRPCRequest;
    
    NSString *categoryId;                   //顶级分类ID
    NSString *requestMethod;                //请求函数名
    NSString *entryPort;                    //服务入口
    NSString *nameSpace;                    //命名空间
    NSMutableArray  *paramsArray;           //参数列表
    
    NSMutableDictionary *serviceDic;        //服务字典
    NSMutableDictionary *requestDic;        //请求字典
    
}

@end



@implementation SKYSoapRequest

@synthesize delegate;
@synthesize m_soapService;
@synthesize m_soapParams;
@synthesize m_userDict;
@synthesize m_soapTag;


- (id)init
{
    self = [super init];
    if(self)
    {
        m_soapParams     = [[NSArray alloc] init];
        m_userDict       = [[NSMutableDictionary alloc] init];
        paramsArray      = [[NSMutableArray alloc] init];
        serviceDic       = [[NSMutableDictionary alloc] init];
        requestDic       = [[NSMutableDictionary alloc] init];
    }
    return self;
}

//依据soap请求的类型来获取对应的nameSpace和entryPort
- (void)soapRequestStart
{
    [paramsArray removeAllObjects];
    
    //根据soap类别选取对应的服务请求
    switch (m_soapService)
    {
        //频道分类
        case SoapEPGChannelCat:
            nameSpace  = [SKYSoapConfig getResourceNameSpace];
            entryPort  = [SKYSoapConfig getServerEntry];
            requestMethod = SOAP_SC_CMD;
            break;
            
        //频道列表
        case SoapEPGChannelList:
            nameSpace  = [SKYSoapConfig getResourceNameSpace];
            entryPort  = [SKYSoapConfig getServerEntry];
            requestMethod = SOAP_LS_CMD;
            break;
        
        //节目列表
        case SoapEPGProgramList:
            nameSpace  = [SKYSoapConfig getResourceNameSpace];
            entryPort  = [SKYSoapConfig getServerEntry];
            requestMethod = SOAP_LS_CMD;
            break;
            
        //节目详情
        case SoapEPGProgramDetail:
            nameSpace  = [SKYSoapConfig getResourceNameSpace];
            entryPort  = [SKYSoapConfig getServerEntry];
            requestMethod = SOAP_SS_CMD;
            break;
         
        //电视节目相关资源
        case SoapEPGRelations:
            nameSpace  = [SKYSoapConfig getResourceNameSpace];
            entryPort  = [SKYSoapConfig getServerEntry];
            requestMethod = SOAP_LR_CMD;
            break;
            
        //影片分类
        case SoapMediaCat:
            nameSpace  = [SKYSoapConfig getResourceNameSpace];
            entryPort  = [SKYSoapConfig getServerEntry];
            requestMethod = SOAP_SC_CMD;
            break;
        
        //影片列表
        case SoapMediaList:
            nameSpace  = [SKYSoapConfig getResourceNameSpace];
            entryPort  = [SKYSoapConfig getServerEntry];
            requestMethod = SOAP_LS_CMD;
            break;
        
        //影片详情
        case SoapMediaDetail:
            nameSpace  = [SKYSoapConfig getResourceNameSpace];
            entryPort  = [SKYSoapConfig getServerEntry];
            requestMethod = SOAP_SS_CMD;
            break;
            
        //电影相关资源
        case SoapMediaRelations:
            nameSpace  = [SKYSoapConfig getResourceNameSpace];
            entryPort  = [SKYSoapConfig getServerEntry];
            requestMethod = SOAP_LR_CMD;
            break;
        
        //广告位
        case SoapAdInfo:
            nameSpace  = [SKYSoapConfig getAdNameSpace];
            entryPort  = [SKYSoapConfig getServerEntry];
            requestMethod = SOAP_AD_CMD;
            break;
            
        //TOP榜单列表
        case SoapTopList:
            nameSpace  = [SKYSoapConfig getResourceNameSpace];
            entryPort  = [SKYSoapConfig getServerEntry];
            requestMethod = SOAP_TL_CMD;
            break;
            
        //TOP榜单KEY集合
        case SoapTopKeys:
            nameSpace  = [SKYSoapConfig getResourceNameSpace];
            entryPort  = [SKYSoapConfig getServerEntry];
            requestMethod = SOAP_TK_CMD;
            break;
        
        //用户注册
        case HttpUserRegister:
            nameSpace  = [SKYSoapConfig getUserNameSpace];
            requestMethod = HTTP_USER_RG_CMD;
            break;
            
        //用户登陆
        case HttpUserLogin:
            nameSpace  = [SKYSoapConfig getUserNameSpace];
            requestMethod = HTTP_USER_LG_CMD;
            break;
            
        //获取用户信息
        case HttpGetUserInfo:
            nameSpace  = [SKYSoapConfig getUserNameSpace];
            requestMethod = HTTP_USER_GET_CMD;
            break;
            
        //更新用户信息
        case HttpUpdateUserInfo:
            nameSpace  = [SKYSoapConfig getUserNameSpace];
            requestMethod = HTTP_USER_UPD_CMD;
            break;
        
        default:
            break;
    }

    
    if( (!nameSpace || !entryPort) && m_soapService < HttpUserRegister)
    {
        NSLog(@"请检查配置表中的命名空间和服务端口是否为对应正确！");

        return;
    }
    
    
    //调用soap请求
    if(m_soapService < HttpUserRegister)
    {
        //获取请求对应的分类ID
        categoryId = [SKYSoapConfig getCategoryId:m_soapService];
        
        NSArray *soapCondition = [self soapCondition:categoryId];
        
        if(soapCondition.count == 0) return;

        [paramsArray addObjectsFromArray:soapCondition];
        
        [self sendSoapRequest:m_soapTag];
        
        m_soapTag = nil;
        
    }
    
    //调用http请求
    else
    {
        NSString *httpCondition = [self httpCondition];
        
        if(httpCondition.length == 0) return;
        
        [self sendHttpRequest:httpCondition withRequestTag:m_soapTag];
        
        m_soapTag = nil;
    }
}

/**将所有参数组装成condition
 * http请求参数组成分为 nameSpace + condition
 **/
- (NSString *)httpCondition
{
    NSString *httpCondition = nil;
    
    switch (m_soapService)
    {
        //注册
        case HttpUserRegister:
        {
            if(m_userDict.count < 2)
            {
                NSString *error = @"请求失败！注册用户请求只有1个参数:\n 1.用户\n 2.用户密码\n 请确保参数的完整和正确性！！";
                [self errorWithParams:HttpUserRegister withError:error];
                return 0;
            }
            
            NSMutableString *str = [NSMutableString string];
            
            //用户名
            if([m_userDict objectForKey:USER_NICKNAME])
            {
                NSString *userId = [m_userDict objectForKey:USER_NICKNAME];
                [str appendFormat:@"a/%@",userId];
            }
            else
            {
                NSString *error = @"请求失败！用户名不能为空！";
                [self errorWithParams:HttpGetUserInfo withError:error];
                return 0;
            }
            
            //用户密码
            if([m_userDict objectForKey:USER_PASSWORD])
            {
                NSString *userPassword = [m_userDict objectForKey:USER_PASSWORD];
                [str appendFormat:@"/b/%@",userPassword];
            }
            else
            {
                NSString *error = @"请求失败！用户密码不能为空！";
                [self errorWithParams:HttpGetUserInfo withError:error];
                return 0;
            }
            
            httpCondition = [NSString stringWithFormat:@"%@/%@/%@/ws",nameSpace,requestMethod,str];
            
            [m_userDict removeAllObjects];
        }
            
            break;
            
        //用户登陆
        case HttpUserLogin:
        {
            if(m_userDict.count != 2)
            {
                NSString *error = @"请求失败！获取用户信息请求只有1个参数:\n 用户ID\n 请确保参数的完整和正确性！！";
                [self errorWithParams:HttpUserLogin withError:error];
                return 0;
            }
            
            NSMutableString *str = [NSMutableString string];
            
            //用户ID
            if([m_userDict objectForKey:USER_ID])
            {
                NSString *userId = [m_userDict objectForKey:USER_ID];
                [str appendFormat:@"a/%@",userId];
            }
            else
            {
                NSString *error = @"请求失败！用户id不能为空！";
                [self errorWithParams:HttpUserLogin withError:error];
                return 0;
            }
            
            //用户密码
            if([m_userDict objectForKey:USER_PASSWORD])
            {
                NSString *userPassword = [m_userDict objectForKey:USER_PASSWORD];
                //userPassword = [userPassword md5HexDigest];
                [str appendFormat:@"/b/%@",userPassword];
            }
            else
            {
                NSString *error = @"请求失败！用户密码不能为空！";
                [self errorWithParams:HttpUserLogin withError:error];
                return 0;
            }
            
            httpCondition = [NSString stringWithFormat:@"%@/%@/%@/ws",nameSpace,requestMethod,str];
            
            [m_userDict removeAllObjects];
            str = nil;
            
        }
            break;
            
        //获取用户信息
        case HttpGetUserInfo:
        {
            if(m_userDict.count != 1)
            {
                NSString *error = @"请求失败！获取用户信息请求只有1个参数:\n 用户ID\n 请确保参数的完整和正确性！！";
                [self errorWithParams:HttpGetUserInfo withError:error];
                return 0;
            }
            
            NSMutableString *str = [NSMutableString string];
            
            //用户ID
            if([m_userDict objectForKey:USER_ID])
            {
                NSString *userId = [m_userDict objectForKey:USER_ID];
                [str appendFormat:@"a/%@",userId];
            }
            
            //用户邮箱
            else if([m_userDict objectForKey:USER_EMAIL])
            {
                NSString *userEmail = [m_userDict objectForKey:USER_EMAIL];
                [str appendFormat:@"a/%@",userEmail];
            }
            else
            {
                NSString *error = @"请求失败！用户id火Email不能为空！";
                [self errorWithParams:HttpGetUserInfo withError:error];
                return 0;
            }
            
            httpCondition = [NSString stringWithFormat:@"%@/%@/%@/ws",nameSpace,requestMethod,str];
            
            [m_userDict removeAllObjects];
            str = nil;
        }
            break;
                
        //更新用户信息
        case HttpUpdateUserInfo:
        {
            if(m_userDict.count < 2)
            {
                NSString *error = @"请求失败！资料未更改无需更新！";
                [self errorWithParams:HttpGetUserInfo withError:error];
                return 0;
            }
            
            NSMutableString *str = [NSMutableString string];
            
            //用户ID
            if([m_userDict objectForKey:USER_ID])
            {
                NSString *userId = [m_userDict objectForKey:USER_ID];        
                [str appendFormat:@"a/%@",userId];
            }
            else
            {
                NSString *error = @"请求失败！用户id不能为空！";
                [self errorWithParams:HttpUpdateUserInfo withError:error];
                return 0;
            }
            
            //用户邮箱
            if([m_userDict objectForKey:USER_EMAIL])
            {
                NSString *userEmail = [m_userDict objectForKey:USER_EMAIL];     
                [str appendFormat:@"/b/%@",userEmail];
            }
            else
            {
                NSString *error = @"请求失败！更新请求需要保证参数完整，请传入邮箱！";
                [self errorWithParams:HttpUpdateUserInfo withError:error];
                return 0;
            }
            
            //用户密码
            if([m_userDict objectForKey:USER_PASSWORD])
            {
                NSString *userPassword = [m_userDict objectForKey:USER_PASSWORD];
                //userPassword = [userPassword md5HexDigest];
                [str appendFormat:@"/c/%@",userPassword];
            }
            else
            {
                NSString *error = @"请求失败！更新请求需要保证参数完整，请传入密码！";
                [self errorWithParams:HttpUpdateUserInfo withError:error];
                return 0;
            }
            
            //用户登陆 0为不自动，1为自动
            if([m_userDict objectForKey:USER_LOGIN])
            {
                NSString *userLogin = [m_userDict objectForKey:USER_LOGIN];  
                [str appendFormat:@"/d/%@",userLogin];
            }
            else
            {
                NSString *error = @"请求失败！更新请求需要保证参数完整，请传入登陆方式！";
                [self errorWithParams:HttpUpdateUserInfo withError:error];
                return 0;
            }
            
            //用户头像
            if([m_userDict objectForKey:USER_ICON])
            {
                NSString *userIcon = [m_userDict objectForKey:USER_ICON];
                [str appendFormat:@"/e/%@",userIcon];
            }
            else
            {
                NSString *error = @"请求失败！更新请求需要保证参数完整，请传入上传图像Url！";
                [self errorWithParams:HttpUpdateUserInfo withError:error];
                return 0;
            }
            
            //用户生日
            if([m_userDict objectForKey:USER_BIRTHDAY])
            {
                NSString *userBrithday = [m_userDict objectForKey:USER_BIRTHDAY]; 
                [str appendFormat:@"/f/%@",userBrithday];
            }
            else
            {
                NSString *error = @"请求失败！更新请求需要保证参数完整，请传入生日！";
                [self errorWithParams:HttpUpdateUserInfo withError:error];
                return 0;
            }
            
            //用户性别 0为女生 1为男
            if([m_userDict objectForKey:USER_SEX])
            {
                NSString *userSex = [m_userDict objectForKey:USER_SEX];
                [str appendFormat:@"/g/%@",userSex];
            }
            else
            {
                NSString *error = @"请求失败！更新请求需要保证参数完整，请传入性别！";
                [self errorWithParams:HttpUpdateUserInfo withError:error];
                return 0;
            }
            
            //用户真名
            if([m_userDict objectForKey:USER_TRUENAME])
            {
                 NSString *userTrueName = [m_userDict objectForKey:USER_TRUENAME];
                [str appendFormat:@"/h/%@",userTrueName];
            }
            else
            {
                NSString *error = @"请求失败！更新请求需要保证参数完整，请传入用户真名！";
                [self errorWithParams:HttpUpdateUserInfo withError:error];
                return 0;
            }
            
            //用户昵称
            if([m_userDict objectForKey:USER_NICKNAME])
            {
                NSString *userNickName = [m_userDict objectForKey:USER_NICKNAME];
                [str appendFormat:@"/i/%@",userNickName];
            }
            else
            {
                NSString *error = @"请求失败！更新请求需要保证参数完整，请传入昵称！";
                [self errorWithParams:HttpUpdateUserInfo withError:error];
                return 0;
            }
            
            //用户地址
            if([m_userDict objectForKey:USER_ADDRESS])
            {
                NSString *userAddress = [m_userDict objectForKey:USER_ADDRESS];
                [str appendFormat:@"/j/%@",userAddress];
            }
            else
            {
                NSString *error = @"请求失败！更新请求需要保证参数完整，请传入地址！";
                [self errorWithParams:HttpUpdateUserInfo withError:error];
                return 0;
            }
            
            //用户电话
            if([m_userDict objectForKey:USER_TEL])
            {
                NSString *userTel = [m_userDict objectForKey:USER_TEL];
                [str appendFormat:@"/k/%@",userTel];
            }
            else
            {
                NSString *error = @"请求失败！更新请求需要保证参数完整，请传入电话！";
                [self errorWithParams:HttpUpdateUserInfo withError:error];
                return 0;
            }
            
            httpCondition = [NSString stringWithFormat:@"%@/%@/%@/ws",nameSpace,requestMethod,str];

            [m_userDict removeAllObjects];
            str = nil;
        }
            
            break;
            
        default:
            break;
    }
    
    return httpCondition;
}

/**将所有参数组装成condition
 * soap请求参数组成分为 typeId + condition
 **/
- (NSArray *)soapCondition:(NSString *)cid
{
    NSArray *soapCondition = [NSArray array];
    
    switch (m_soapService)
    {
        //频道分类
        case SoapEPGChannelCat:
            soapCondition = @[cid];
            break;
            
        //频道列表
        case SoapEPGChannelList:
        {
            
            if(m_soapParams.count < 3)
            {
                NSString *error = @"请求失败！播放列表请求共有3个参数:\n 1.频道分类ID\n 2.页码\n 3.要取的频道数\n请确保参数的完整和正确性！";
                [self errorWithParams:SoapEPGChannelList withError:error];
                return 0;
            }

            NSString *catId    = [m_soapParams objectAtIndex:0];  //获取卫视或者央视的ID
            NSString *pageNum  = [m_soapParams objectAtIndex:1];  //页码
            NSString *pageSize = [m_soapParams objectAtIndex:2];  //数量
            
            NSString *linkStr  = [NSString stringWithFormat:@"{\"category_id\":\"%@\"}",catId];
            
            soapCondition = @[cid,linkStr,pageNum,pageSize];
        }
            break;
            
        //节目列表
        case SoapEPGProgramList:
        {
            if(m_soapParams.count < 5)
            {
                NSString *error = @"请求失败！节目列表请求共有5个参数:\n 1.频道ID\n 2.开始时间\n 3.结束时间\n 4.页码\n 5.要取节目数\n 请确保参数的完整和正确性！！";
                
                [self errorWithParams:SoapEPGProgramList withError:error];
                return 0;
            }
            
            NSString *channeId  = [m_soapParams objectAtIndex:0]; //频道ID
            NSString *startTime = [m_soapParams objectAtIndex:1]; //开始时间
            NSString *endTime   = [m_soapParams objectAtIndex:2]; //结束时间
            NSString *pageNum   = [m_soapParams objectAtIndex:3];
            NSString *pageSize  = [m_soapParams objectAtIndex:4];
            
            NSString *linkStr   = [NSString stringWithFormat:@"{\"ch_id\":\"%@\",\"begintime\":\"%@\",\"endtime\":\"%@\"}",channeId,startTime,endTime];
            
            soapCondition = @[cid,linkStr,pageNum,pageSize];
                                  
        }
            break;
            
        //节目详情
        case SoapEPGProgramDetail:
        {
            if(m_soapParams.count < 1)
            {
                NSString *error = @"请求失败！节目详情请求共有1个参数:\n 节目ID\n 请确保参数的完整和正确性！";
                [self errorWithParams:SoapEPGProgramDetail withError:error];
                return 0;
            }
            
            NSString *pgId  = [m_soapParams objectAtIndex:0]; //节目ID
            
            soapCondition = @[cid,pgId];
        }
            break;
        
        //节目相关
        case SoapEPGRelations:
        {
            if(m_soapParams.count < 1)
            {
                NSString *error = @"请求失败！节目相关请求共有1个参数:\n 节目ID\n 请确保参数的完整和正确性！";
                [self errorWithParams:SoapEPGRelations withError:error];
                return 0;
            }
            
            NSString *sourceId = [m_soapParams objectAtIndex:0];     //资源Id
            
            soapCondition = @[cid,sourceId];
        }
            break;
            
        //影片分类
        case SoapMediaCat:
            soapCondition = @[cid];
            break;
            
        //影片列表
        case SoapMediaList:
        {
            if(m_soapParams.count < 3)
            {
                NSString *error = @"请求失败！影片列表请求共有3个参数:\n 1.影片分类ID\n 2.页码\n 3.要取的频道数目\n 请确保参数的完整和正确性！";
                [self errorWithParams:SoapMediaList withError:error];
                return 0;
            }
            
            NSString *mediaId  = [m_soapParams objectAtIndex:0];  //影片分类ID
            NSString *pageNum  = [m_soapParams objectAtIndex:1];  //页码
            NSString *pageSize = [m_soapParams objectAtIndex:2];  //数量
            
            NSString *linkStr  = [NSString stringWithFormat:@"{\"categoryid\":\"%@\"}",mediaId];
            
            soapCondition = @[cid,linkStr,pageNum,pageSize];
        }
            break;
        
        //影片详情
        case SoapMediaDetail:
        {
            if(m_soapParams.count < 1)
            {
                NSString *error = @"请求失败！影片详情请求共有1个参数:\n 影片ID\n 请确保参数的完整和正确性！";
                [self errorWithParams:SoapMediaDetail withError:error];
                return 0;
            }
            
            NSString *movieId = [m_soapParams objectAtIndex:0];
            
            soapCondition = @[cid,movieId];
        }
            break;
            
        //影片相关
        case SoapMediaRelations:
        {
            if(m_soapParams.count < 1)
            {
                NSString *error = @"请求失败！电影相关请求共有1个参数:\n 电影ID\n 请确保参数的完整和正确性！";
                [self errorWithParams:SoapMediaRelations withError:error];
                return 0;
            }
            
            NSString *sourceId = [m_soapParams objectAtIndex:0];     //资源Id
            
            soapCondition = @[cid,sourceId];
        }
            
            break;
            
        //广告位
        case SoapAdInfo:
        {
            NSString *adParam = @"skymobile_index1.0";
            
            soapCondition = @[adParam];
        }
            break;
        
        //TOP榜单结合列表
        case SoapTopList:
        {
            if(m_soapParams.count < 3)
            {
                NSString *error = @"请求失败！影片详情请求共有3个参数:\n 1.榜单Key\n 2.页码\n 3.要取的数量\n 请确保参数的完整和正确性！";
                [self errorWithParams:SoapTopList withError:error];
                return 0;
            }
            
            NSString *key      = [m_soapParams objectAtIndex:0];  //榜单Key值
            NSString *pageNum  = [m_soapParams objectAtIndex:1];  //页码
            NSString *pageSize = [m_soapParams objectAtIndex:2];  //数量
            
            soapCondition = @[cid,key,pageNum,pageSize];
        }
            break;
            
        //TOP榜单KEY值集合
        case SoapTopKeys:
            soapCondition = @[cid];
            break;

            
        default:
            break;
    }
    
    return soapCondition;
}

//错误参数处理
- (void)errorWithParams:(NSInteger)soapService withError:(NSString *)error
{
    ZNLog(@"soapRequest%d:%@",soapService,error);
}


//封装soap包信息并发送
- (void)sendSoapRequest:(NSString *)requestTag
{
    serialize = [[SoapSerialize alloc] init];
    soapRPCRequest  = [[SoapRPCRequest alloc] init];
    
    soapRPCRequest.requestTag = requestTag;
    
    [serialize setMethod:requestMethod inNameSpace:nameSpace withParameters:paramsArray];
    
    [soapRPCRequest initWithURL:[NSURL URLWithString:entryPort] andSoapSerialize:serialize];
    
    [[SoapRequestManager sharedManager] spawnConnectionWithSoapRPCRequest:soapRPCRequest delegate:self];
    
    [serviceDic setObject:[NSString stringWithFormat:@"%d",m_soapService] forKey:soapRPCRequest.identifity];
    
    if(requestTag != nil)
    {
        [requestDic setObject:requestTag forKey:soapRPCRequest.identifity];
    }
    
    [serialize release];
}

//封装Http请求URL
- (void)sendHttpRequest:(NSString *)requestUrlString withRequestTag:(NSString *)requestTag
{
    httpRPCRequest = [[HttpRPCRequest alloc] init];
    
    httpRPCRequest.requestTag = requestTag;
    
    [httpRPCRequest initWithURL:[NSURL URLWithString:requestUrlString]];
    
    [[SoapRequestManager sharedManager] spawnConnectionWithHttpRPCRequest:httpRPCRequest delegate:self];
    
    [serviceDic setObject:[NSString stringWithFormat:@"%d",m_soapService] forKey:httpRPCRequest.identifity];
    
    if(requestTag != nil)
    {
        [requestDic setObject:requestTag forKey:soapRPCRequest.identifity];
    }
    
    [serialize release];
}


#pragma mark - SoapConnectionDelegate Method
- (void)request:(ASIHTTPRequest *)request didReceiveResponse:(SoapResponse *)response
{
    NSString *key = [request.userInfo objectForKey:@"identifity"];
    
    NSInteger service = [[serviceDic objectForKey:key] integerValue];
    
    id object = response;
    
    NSArray *array = [[SKYSoapRecordParser sharedRecordParser] recordParser:object withSoapType:service];
    
    if(array)
    {
        [self.delegate soapRequestFinished:array withSoapRequestService:service withSoapRequestTag:request.tag];
    }
    else
    {
        NSString *error = @"请求数据为空";
        [self.delegate soapRequestFailed:error withSoapRequestService:service withSoapRequestTag:request.tag];
    }
    
    array = nil;
    
}

- (void)request:(ASIHTTPRequest *)request didFailWithError:(NSError *)error
{
    NSString *key = [request.userInfo objectForKey:@"identifity"];
    
    NSInteger service = [[serviceDic objectForKey:key] integerValue];
    
    ZNLog(@"SoapRequest %d:%d request failed!",service,request.tag);
}


- (void)dealloc
{
    [super dealloc];
    [self setDelegate:nil];
    
    [nameSpace release];
    [entryPort release];
    [requestMethod release];
    [categoryId release];
    
    [m_soapParams release];
    [m_soapTag release];
    [paramsArray release];
    [m_userDict release];
    
    [serviceDic release];
    [requestDic release];
}




@end
