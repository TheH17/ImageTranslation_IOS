//
//  HLInfoCellData.m
//  ImageTranslation
//
//  Created by hueyLee on 07/04/2018.
//  Copyright © 2018 李浩鹏. All rights reserved.
//

#import "HLInfoCellData.h"

@implementation HLInfoCellData

+ (instancetype)cellDataWithTitle:(NSString *)title image:(NSString *)imageName actionBlock:(HLInfoCellAction)action {
    HLInfoCellData *data = [self new];
    data.title = title;
    data.ImageName = imageName;
    data.actionBlock = action;
    return data;
}

@end
