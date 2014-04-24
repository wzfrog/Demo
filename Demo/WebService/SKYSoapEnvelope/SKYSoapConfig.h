//
//  Config.h
//  SrtIOSFramework
//
//  Created by  on 12-4-17.
//  Copyright (c) 2012年 Rico. All rights reserved.
//

#import <Foundation/Foundation.h>

/**运行模式
 * 0 代表debug模式
 * 1 代表release模式
 **/
enum SoapConfigMode
{
    DEBUGMODE = 0,
    RELEASEMODE = 1
};


//Top榜单Key值约定

#define TOP_HOT_TV          @"1"           //热播排行电视剧

#define TOP_HOT_MOVIE       @"2"           //热播排行电影

#define TOP_LATEST_TV       @"3"           //最新推荐电视剧

#define TOP_LATEST_MOVICE   @"4"           //最新推荐电影

#define TOP_BEST_MEDIA      @"latest"      //精品推荐

#define TOP_HD_MEDIA        @"superclear"  //高清影视



//影视分类

#define M_CAT_HD          @"10092"          //高清影视

#define M_CAT_BEST        @"10091"          //精品推荐

#define M_CAT_LATEST      @"10090"          //新片速递

#define M_CAT_VARIETY     @"10065"          //综艺

#define M_CAT_CARTOON     @"6"              //卡通

#define M_CAT_TV          @"5"              //电视剧

#define M_CAT_MOVIE       @"4"              //电影


//用户数据字典

#define USER_ID           @"id"        //用户ID

#define USER_EMAIL        @"email"     //用户邮箱

#define USER_PASSWORD     @"password"  //用户密码

#define USER_LOGIN        @"loginType" //用户登陆 1为自动 0为默认

#define USER_ICON         @"icon"      //用户头像

#define USER_BIRTHDAY     @"birthday"  //用户生日

#define USER_SEX          @"sex"       //用户性别

#define USER_TRUENAME     @"truename"  //用户真名

#define USER_NICKNAME     @"nickname"  //用户昵称

#define USER_TEL          @"tel"       //用户电话

#define USER_ADDRESS      @"address"   //用户地址


/**EPG频道分类ID
 * 卫视 70011
 * 央视 70012
 **/

#define EPG_WS_ID @"70011"
#define EPG_YS_ID @"70012"
#define EPG_DF_ID @"70013"



/**请求服务包含Soap和Http两种
 * 按照此枚举类型来分别获取命名空间以及服务入口
 * 请求完成回调时按照此枚举值获取对应的返回值
 **/
enum RequestService
{
    SoapEPGChannelCat    = 0,   //EPG频道分类
    SoapEPGChannelList   = 1,   //EPG频道列表
    SoapEPGProgramList   = 2,   //EPG节目列表
    SoapEPGProgramDetail = 3,   //EPG节目详情
    SoapEPGRelations     = 4,   //EPG相关列表
    SoapMediaCat         = 5,   //影片分类
    SoapMediaList        = 6,   //影片列表
    SoapMediaDetail      = 7,   //影片详情
    SoapMediaRelations   = 8,   //相关资源
    SoapAdInfo           = 9,   //广告信息
    SoapTopKeys          = 10,  //top榜单集合Key
    SoapTopList          = 11,  //推荐、热播、精品
    
    HttpUserRegister     = 12,  //用户注册
    HttpUserLogin        = 13,  //用户登陆
    HttpGetUserInfo      = 14,  //获取用户信息
    HttpUpdateUserInfo   = 15,  //更新用户信息
};


/**
 * 请求分类值约定 CategoryId
 * 依据类型来获取后台服务端对应的约定值
 **/

#define SOAP_MOVIE_ID  @"0001"   //影视类ID

#define SOAP_MUSIC_ID  @"0002"   //音乐类ID

#define SOAP_MUSIC_SPE @"00021"  //音乐专辑

#define SOAP_PIC_ID    @"0003"   //图片类ID

#define SOAP_APP_ID    @"0004"   //应用类ID

#define SOAP_NEWS_ID   @"0005"   //资讯类ID

#define SOAP_EPG_ID    @"0006"   //EPG类ID

#define SOAP_EPG_CH_ID @"00061"  //EPG频道ID

#define SOAP_EPG_PG_ID @"00062"  //EPG节目ID

#define SOAP_BROADCAST @"0009"   //广播



/**SOAP请求方法函数名定义
 * soapMethod方法
 **/
#define SOAP_SS_CMD @"ShowSource"         //获取详情

#define SOAP_SC_CMD @"ShowCategory"       //获取资源分类

#define SOAP_LS_CMD @"ListSources"        //获取资源列表

#define SOAP_LT_CMD @"ListTops"           //获取资源TOP集合

#define SOAP_LR_CMD @"ListRelationCross"  //获取相关资源列表

#define SOAP_MR_CMD @"ListRelations"      //获取电影类相关资源

#define SOAP_LG_CMD @"ListSegments"       //获取资源子集（非独立资源）

#define SOAP_AD_CMD @"getAds"             //获取广告信息
 
#define SOAP_TL_CMD @"ListTops"           //获取TOP榜单列表

#define SOAP_TK_CMD @"TopKeys"            //获取TOP榜单KEY集合



/**HTTP请求方法函数名定义
 * httpMethod方法
 **/
#define HTTP_USER_RG_CMD  @"register"       //用户注册

#define HTTP_USER_LG_CMD  @"userLogin"      //用户登陆

#define HTTP_USER_GET_CMD @"getUserInfo"    //获取用户信息

#define HTTP_USER_UPD_CMD @"updateUser"     //更新用户信息



@interface SKYSoapConfig : NSObject

+ (enum SoapConfigMode)getCurrentRunMode;

+ (NSString *)getConfigFilePath;

#pragma mark - SoapRequest
+ (NSString *)getServerEntry;

+ (NSString *)getResourceNameSpace;

+ (NSString *)getAdNameSpace;

#pragma mark - HttpRequest
+ (NSString *)getUserNameSpace;

+ (NSString *)getFileUploadPath;



+ (NSString *)getCategoryId:(enum RequestService) type;




@end
