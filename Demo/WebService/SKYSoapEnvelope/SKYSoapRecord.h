//
//  SoapRecord.h
//  数据对象
//
//  Created by George on 12/5/13.
//  Copyright (c) 2013 Skyworth. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SKYSoapRecord : NSObject

//图像
@property(nonatomic,copy,readonly) NSString *m_imageURL;      //图片路径
@property(nonatomic,retain) UIImage  *m_image;                //图片

//分类
@property(nonatomic,copy,readonly) NSString *m_catId;        //分类ID
@property(nonatomic,copy,readonly) NSString *m_catName;      //分类名

//EPG
@property(nonatomic,copy,readonly) NSString *m_epgBeginTime;    //开始时间
@property(nonatomic,copy,readonly) NSString *m_epgCategoryId;   //频道分类ID
@property(nonatomic,copy,readonly) NSString *m_epgChannelId;    //频道ID
@property(nonatomic,copy,readonly) NSString *m_epgChannelName;  //频道名称
@property(nonatomic,copy,readonly) NSString *m_epgCreateDate;   //创建时间
@property(nonatomic,copy,readonly) NSString *m_epgPgId;         //节目ID
@property(nonatomic,copy,readonly) NSString *m_epgPgName;       //节目名称


//Media
@property(nonatomic,copy,readonly) NSString *m_mediaId;            //影片Id
@property(nonatomic,copy,readonly) NSString *m_mediaActor;         //演员
@property(nonatomic,copy,readonly) NSString *m_mediaScreenwriter;  //编剧
@property(nonatomic,copy,readonly) NSString *m_mediaDesc;          //描述
@property(nonatomic,copy,readonly) NSString *m_mediaTitle;         //名称
@property(nonatomic,copy,readonly) NSString *m_mediaURL;           //视频地址
@property(nonatomic,copy,readonly) NSString *m_mediaWebUrl;        //网页地址


//用户数据
@property(nonatomic,copy,readonly) NSString *m_userId;        //用户ID
@property(nonatomic,copy,readonly) NSString *m_userEmail;     //用户邮箱
@property(nonatomic,copy,readonly) NSString *m_userNickName;  //用户昵称
@property(nonatomic,copy,readonly) NSString *m_userTrueName;  //用户实名
@property(nonatomic,copy,readonly) NSString *m_userBirthday;  //用户生日
@property(nonatomic,copy,readonly) NSString *m_userSex;       //用户性别 0女 1男
@property(nonatomic,copy,readonly) NSString *m_userAddress;   //用户地址
@property(nonatomic,copy,readonly) NSString *m_userTel;       //用户电话
@property(nonatomic,copy,readonly) NSString *m_userLoginCode; //用户登陆 0不自动 1自动


/**返回字典解析
 * dict 为返回的字典
 * type 为请求类型
 **/
- (id)initWithDic:(NSDictionary *)dict withType:(NSInteger)type;

@end
