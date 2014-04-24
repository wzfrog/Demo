//
//  SoapRecord.m
//  SkyIOSDemo
//
//  Created by George on 12/5/13.
//  Copyright (c) 2013 Zoro. All rights reserved.
//

#import "SKYSoapRecord.h"
#import "SKYSoapConfig.h"


@implementation SKYSoapRecord

//分类
@synthesize m_catId   = _m_catId;
@synthesize m_catName = _m_catName;

//EPG
@synthesize m_epgBeginTime     = _m_epgBeginTime;
@synthesize m_epgCategoryId    = _m_epgCategoryId;
@synthesize m_epgChannelId     = _m_epgChannelId;
@synthesize m_epgChannelName   = _m_epgChannelName;
@synthesize m_epgCreateDate    = _m_epgCreateDate;
@synthesize m_epgPgId          = _m_epgPgId;
@synthesize m_epgPgName        = _m_epgPgName;


//Media
@synthesize m_mediaId           = _m_mediaId;
@synthesize m_mediaActor        = _m_mediaActor;
@synthesize m_mediaScreenwriter = _m_mediaScreenwriter;
@synthesize m_mediaDesc         = _m_mediaDesc;
@synthesize m_mediaTitle        = _m_mediaTitle;
@synthesize m_mediaURL          = _m_mediaURL;
@synthesize m_mediaWebUrl       = _m_mediaWebUrl;


//Image
@synthesize m_imageURL = _m_imageURL;
@synthesize m_image    = _m_image;


//用户数据
@synthesize m_userId       = _m_userId;
@synthesize m_userAddress  = _m_userAddress;
@synthesize m_userBirthday = _m_userBirthday;
@synthesize m_userEmail    = _m_userEmail;
@synthesize m_userNickName = _m_userNickName;
@synthesize m_userSex      = _m_userSex;
@synthesize m_userTel      = _m_userTel;
@synthesize m_userTrueName = _m_userTrueName;
@synthesize m_userLoginCode= _m_userLoginCode;


- (id)initWithDic:(NSDictionary *)dict withType:(NSInteger)type
{
    self = [super init];
    if(self)
    {
        [self parseDictionary:dict withType:type];
    }
    
    return self;
}

//解析
- (void)parseDictionary:(NSDictionary *)dict withType:(NSInteger)type
{
    
    //分类
    _m_catId   = [dict objectForKey:@"id"];
    _m_catName = [dict objectForKey:@"name"];
    
    //EPG
    _m_epgBeginTime   = [dict objectForKey:@"begintime"];
    _m_epgCategoryId  = [dict objectForKey:@"category_id"];
    _m_epgChannelId   = [dict objectForKey:@"ch_id"];
    _m_epgChannelName = [dict objectForKey:@"ch_name"];
    _m_epgCreateDate  = [dict objectForKey:@"created_date"];
    _m_epgPgId        = [dict objectForKey:@"pg_id"];
    _m_epgPgName      = [dict objectForKey:@"pg_name"];
    
    
    
    //Media
    _m_mediaId           = [dict objectForKey:@"id"];
    _m_mediaActor        = [dict objectForKey:@"actor"];
    _m_mediaScreenwriter = [dict objectForKey:@"bianju"];
    _m_mediaDesc         = [dict objectForKey:@"description"];
    _m_mediaTitle        = [dict objectForKey:@"title"];
    _m_mediaURL          = [dict objectForKey:@"url"];
    _m_mediaWebUrl       = [dict objectForKey:@"playurl"];
    
    
    //用户数据
    _m_userId          = [dict objectForKey:@"userId"];
    _m_userAddress     = [dict objectForKey:@"address"];
    _m_userBirthday    = [dict objectForKey:@"birthday"];
    _m_userEmail       = [dict objectForKey:@"email"];
    _m_userNickName    = [dict objectForKey:@"userNickName"];
    _m_userTrueName    = [dict objectForKey:@"userRealName"];
    _m_userSex         = [dict objectForKey:@"sex"];
    _m_userTel         = [dict objectForKey:@"telephoneNo"];
    _m_userLoginCode   = [dict objectForKey:@"autoLogin"];
    
    //Image
    switch (type)
    {
            //EPG频道分类
        case SoapEPGChannelCat:
             _m_imageURL = [dict objectForKey:@""];
            break;
            
            //EPG频道列表
        case SoapEPGChannelList:
             _m_imageURL = [dict objectForKey:@"ch_img"];
            break;
            
            //EPG节目列表
        case SoapEPGProgramList:
             _m_imageURL = [dict objectForKey:@""];
            break;
            
            //EPG节目详情
        case SoapEPGProgramDetail:
             _m_imageURL = [dict objectForKey:@""];
            break;
            
            //影片分类
        case SoapMediaCat:
             _m_imageURL = [dict objectForKey:@"logo_s"];
            break;
            
            //影片列表
        case SoapMediaList:
             _m_imageURL = [dict objectForKey:@"thumb"];
            break;
            
            //影片详情
        case SoapMediaDetail:
             _m_imageURL = [dict objectForKey:@"thumb"];
            break;
            
            //广告位
        case SoapAdInfo:
            _m_imageURL = [dict objectForKey:@"url"];
            break;
            
            //推荐TOP榜单列表
        case SoapTopList:
            _m_imageURL = [dict objectForKey:@"thumb"];
            break;
            
             //电影相关
        case SoapMediaRelations:
            _m_imageURL = [dict objectForKey:@"thumb"];
            break;
            
            //电视相关
        case SoapEPGRelations:
            _m_imageURL = [dict objectForKey:@"thumb"];
            break;
            
            //用户头像
        case HttpGetUserInfo:
            _m_imageURL = [dict objectForKey:@"userIcon"];
            break;
            
        case SoapTopKeys:
            _m_catId        = [dict objectForKey:@"key"];
            _m_catName      = [dict objectForKey:@"value"];
            break;
            
            
        default:
            break;
    }
    
}


- (void)dealloc
{
    [super dealloc];
    
    [_m_catId release];
    [_m_catName release];
    
    [_m_epgBeginTime release];
    [_m_epgCategoryId release];
    [_m_epgChannelId release];
    [_m_epgChannelName release];
    [_m_epgCreateDate release];
    [_m_epgPgId release];
    [_m_epgPgName release];
    
    
    [_m_mediaId release];
    [_m_mediaActor release];
    [_m_mediaScreenwriter release];
    [_m_mediaDesc release];
    [_m_mediaTitle release];
    [_m_mediaURL release];
    [_m_mediaWebUrl release];
    
    [_m_imageURL release];
    [_m_image release];
    
    
    [_m_userId release];
    [_m_userAddress release];
    [_m_userBirthday release];
    [_m_userEmail release];
    [_m_userNickName release];
    [_m_userSex release];
    [_m_userTel release];
    [_m_userTrueName release];
    [_m_userLoginCode release];
}



@end
