//
//  HLUserTool.h
//  ImageTranslation
//
//  Created by hueyLee on 07/04/2018.
//  Copyright © 2018 李浩鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HLUser;
@interface HLUserTool : NSObject

+ (HLUser *)getUser;

+ (void)saveUser:(HLUser *)user;

@end
