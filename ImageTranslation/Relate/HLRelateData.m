//
//  HLRelateData.m
//  ImageTranslation
//
//  Created by hueyLee on 07/04/2018.
//  Copyright © 2018 李浩鹏. All rights reserved.
//

#import "HLRelateData.h"

@implementation HLRelateData

+ (instancetype)dataWithTitle:(NSString *)title subT:(NSString *)sub {
    HLRelateData *d = [self new];
    d.title = title;
    d.subTitle = sub;
    return d;
}

+ (NSArray<HLRelateData *> *)dataArray {
    NSMutableArray *a = [NSMutableArray array];
    [a addObject:[HLRelateData dataWithTitle:@"pix2pix" subT:@"在监督学习条件下完成多领域图像翻译"]];
    [a addObject:[HLRelateData dataWithTitle:@"cycle_Gan" subT:@"非监督下使用循环结构完成图像翻译"]];
    [a addObject:[HLRelateData dataWithTitle:@"DCGAN" subT:@"将CNN结构引入GAN当中"]];
    [a addObject:[HLRelateData dataWithTitle:@"WGAN" subT:@"在损失函数的角度对GAN做了改进"]];
    [a addObject:[HLRelateData dataWithTitle:@"WGAN-GP" subT:@"WGAN之后的改进版"]];
    [a addObject:[HLRelateData dataWithTitle:@"DTN" subT:@"多领域下的图像翻译"]];
    [a addObject:[HLRelateData dataWithTitle:@"COGAN" subT:@"非循环同向GAN结构"]];
    [a addObject:[HLRelateData dataWithTitle:@"pix2pixHD" subT:@"高分辨率的pix2pix模型"]];
    [a addObject:[HLRelateData dataWithTitle:@"XGAN" subT:@"针对多个应用方向的图像翻译"]];
    return a;
}

@end
