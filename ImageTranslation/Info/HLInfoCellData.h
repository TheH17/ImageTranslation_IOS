//
//  HLInfoCellData.h
//  ImageTranslation
//
//  Created by hueyLee on 07/04/2018.
//  Copyright © 2018 李浩鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^HLInfoCellAction)(void);

@interface HLInfoCellData : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *ImageName;

@property (nonatomic, copy) HLInfoCellAction actionBlock;

+ (instancetype)cellDataWithTitle:(NSString *)title image:(NSString *)imageName actionBlock:(HLInfoCellAction)action;

@end
