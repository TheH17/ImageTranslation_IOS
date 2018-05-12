//
//  HLInferenceTool.h
//  ImageTranslation
//
//  Created by hueyLee on 08/04/2018.
//  Copyright © 2018 李浩鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HLInferenceTool : NSObject

+ (BOOL)hasModeOffline:(NSString *)name;

+ (void)downloadMode:(NSString *)name success:(void (^)(NSString *, NSString *))success failure:(void (^)(NSError *))error;

+ (void)inferenceOnline:(NSString *)name pic:(UIImage *)image success:(void (^)(NSString *, NSString *, NSString*))success failure:(void (^)(NSError *))error;

+ (void)inferenceOffline:(NSString *)name pic:(UIImage *)image success:(void (^)(NSString *, NSString *))success failure:(void (^)(NSError *))error;

@end
