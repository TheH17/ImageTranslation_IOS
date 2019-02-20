//
//  HLRelateData.h
//  ImageTranslation
//
//  Created by hueyLee on 07/04/2018.
//  Copyright © 2018 李浩鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HLRelateData : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *subTitle;

@property (nonatomic, copy) NSString *info;

/**
 增加注释，测试合并
 */
+ (NSArray<HLRelateData *> *)dataArray1;

@end
