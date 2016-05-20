//
//  QYUserModel.m
//  02-微博
//
//  Created by qingyun on 16/4/19.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "QYUserModel.h"
#import "Common.h"

@implementation QYUserModel
-(instancetype) initWithDictionary:(NSDictionary *)userInfo
{
    if (self = [super init]) {
        //用户ID
        _idStr = userInfo[kUserId];
        //昵称
        _screenName = userInfo[kUserScreenName];
        //好友显示的名称
        _name = userInfo[kUserName];
        //用户头像（50 * 50）
        _profileImageUrl = userInfo[kUserProfileImageUrl];
        //大图
        _avatarLarge = userInfo[kUserAvatarLarge];
        //高清（1024 * 1024）
        _avatarHD = userInfo[kUserAvatarHD];
        //粉丝数   强转
        _followersCountds = [userInfo[kUserFollowersCount] integerValue];
        //关注数
        _friendsCounts = [userInfo[kUserFriendsCount] integerValue];
        //微博数
        _statusesCounts = [userInfo[kUserStatusesCount] integerValue];
        //收藏数
        _favouritesCounts = [userInfo[kUserFavouritesCount] integerValue];
    }
    return self;
}

+(instancetype) userWithDictionary:(NSDictionary *)userInfo
{
    return [[self alloc] initWithDictionary:userInfo];
}
@end
