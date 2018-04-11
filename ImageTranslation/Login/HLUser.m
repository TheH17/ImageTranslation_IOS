//
//  HLUser.m
//  ImageTranslation
//
//  Created by hueyLee on 07/04/2018.
//  Copyright © 2018 李浩鹏. All rights reserved.
//

#import "HLUser.h"
#import <objc/runtime.h>

@implementation HLUser

+ (instancetype)userWithName:(NSString *)name phont:(NSString *)phone info:(NSString *)info {
    HLUser *user = [[self alloc] init];
    user.userName = name;
    user.phone = phone;
    user.info = info;
    return user;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    unsigned int count = 0;
    //  利用runtime获取实例变量的列表
    Ivar *ivars = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i ++) {
        //  取出i位置对应的实例变量
        Ivar ivar = ivars[i];
        //  查看实例变量的名字
        const char *name = ivar_getName(ivar);
        //  C语言字符串转化为NSString
        NSString *nameStr = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
        //  利用KVC取出属性对应的值
        id value = [self valueForKey:nameStr];
        //  归档
        [aCoder encodeObject:value forKey:nameStr];
    }
    //  记住C语言中copy出来的要进行释放
    free(ivars);
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        unsigned int count = 0;
        Ivar *ivars = class_copyIvarList([self class], &count);
        for (int i = 0; i < count; i ++) {
            Ivar ivar = ivars[i];
            const char *name = ivar_getName(ivar);
            
            //
            NSString *key = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
            id value = [aDecoder decodeObjectForKey:key];
            //  设置到成员变量身上
            [self setValue:value forKey:key];
        }
        
        free(ivars);
    }
    return self;
}

@end
