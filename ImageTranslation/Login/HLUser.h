//
//  HLUser.h
//  ImageTranslation
//
//  Created by hueyLee on 07/04/2018.
//  Copyright © 2018 李浩鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HLUser : NSObject <NSCoding>

@property (nonatomic, copy) NSString *userName;

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, copy) NSString *info;

+ (instancetype)userWithName:(NSString *)name phont:(NSString *)phone info:(NSString *)info;

@end
