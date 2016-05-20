//
//  Common.h
//  02-微博
//
//  Created by qingyun on 16/4/19.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#ifndef Common_h
#define Common_h

#define kScreenW  [UIScreen mainScreen].bounds.size.width

//首先解析微博用户数据所需要的关键字
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
static NSString * const kUserId = @"idstr";
static NSString * const kUserScreenName = @"screen_name";
static NSString * const kUserName = @"name";
static NSString * const kUserProfileImageUrl = @"profile_image_url";
static NSString * const kUserAvatarLarge = @"avatar_large";
static NSString * const kUserAvatarHD= @"avatar_hd";
static NSString * const kUserFollowersCount = @"followers_count";
static NSString * const kUserFriendsCount = @"friends_count";
static NSString * const kUserStatusesCount = @"statuses_count";
static NSString * const kUserFavouritesCount = @"favourites_count";

//解析微博数据所需要的关键字
/*
 created_at	string	微博创建时间
 idstr	string	字符串型的微博ID
 text	string	微博信息内容
 source	string	微博来源
 thumbnail_pic	string	缩略图片地址，没有时不返回此字段
 bmiddle_pic	string	中等尺寸图片地址，没有时不返回此字段
 original_pic	string	原始图片地址，没有时不返回此字段
 user	object	微博作者的用户信息字段 详细
 retweeted_status	object	被转发的原微博信息字段，当该微博为转发微博时返回 详细
 reposts_count	int	转发数
 comments_count	int	评论数
 attitudes_count	int	表态数
 pic_urls        array  微博图片集合
 */

static NSString * const kStatusCreatAt = @"created_at";
static NSString * const kStatusId = @"idstr";
static NSString * const kStatusText = @"text";
static NSString * const kStatusSource = @"source";
static NSString * const kStatusThumbnailPic = @"thumbnail_pic";
static NSString * const kStatusBmiddlePic = @"bmiddle_pic";
static NSString * const kStatusOriginalPic = @"original_pic";
static NSString * const kStatusUser = @"user";
static NSString * const kStatusRetweetedStatus = @"retweeted_status";
static NSString * const kStatusPicUrls = @"pic_urls";
static NSString * const kStatusRepostsCount = @"reposts_count";
static NSString * const kStatusCommentsCount = @"comments_count";
static NSString * const kStatusAttitudesCount = @"attitudes_count";



#endif /* Common_h */
