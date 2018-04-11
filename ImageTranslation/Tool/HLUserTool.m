//
//  HLUserTool.m
//  ImageTranslation
//
//  Created by hueyLee on 07/04/2018.
//  Copyright © 2018 李浩鹏. All rights reserved.
//

#import "HLUserTool.h"
#import "HLUser.h"

#define HLUserInfoFile [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"userInfo.dat"]

@implementation HLUserTool

static HLUser *_user;

+ (HLUser *)getUser {
    return [NSKeyedUnarchiver unarchiveObjectWithFile:HLUserInfoFile];
}

+ (void)saveUser:(HLUser *)user {
    [NSKeyedArchiver archiveRootObject:user toFile:HLUserInfoFile];
}

@end
