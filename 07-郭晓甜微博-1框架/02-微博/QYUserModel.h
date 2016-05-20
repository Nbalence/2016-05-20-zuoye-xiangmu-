//
//  QYUserModel.h
//  02-微博
//
//  Created by qingyun on 16/4/19.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QYUserModel : NSObject

/*
 idstr	string	字符串型的用户UID
 screen_name	string	用户昵称
 name	string	友好显示名称
 profile_image_url	string	用户头像地址（中图），50×50像素
 avatar_large	string	用户头像地址（大图），180×180像素
 avatar_hd	string	用户头像地址（高清），高清头像原图
 followers_count	int	粉丝数
 friends_count	int	关注数
 statuses_count	int	微博数
 favourites_count int	收藏数
 */

@property (nonatomic,strong) NSString *idStr;
@property (nonatomic,strong) NSString *screenName;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *profileImageUrl;
@property (nonatomic,strong) NSString *avatarLarge;
@property (nonatomic,strong) NSString *avatarHD;
@property (nonatomic)        NSInteger followersCountds;
@property (nonatomic)        NSInteger friendsCounts;
@property (nonatomic)        NSInteger statusesCounts;
@property (nonatomic)        NSInteger favouritesCounts;


//初始化
-(instancetype) initWithDictionary:(NSDictionary *)userInfo;
+(instancetype) userWithDictionary:(NSDictionary *)userInfo;














@end
