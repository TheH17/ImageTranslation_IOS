//
//  HLInferenceTool.m
//  ImageTranslation
//
//  Created by hueyLee on 08/04/2018.
//  Copyright © 2018 李浩鹏. All rights reserved.
//

#import "HLInferenceTool.h"
#import <AFNetworking/AFNetworking.h>

@implementation HLInferenceTool

+ (BOOL)hasModeOffline:(NSString *)name {
    return NO;
}

+ (void)inferenceOnline:(NSString *)name pic:(UIImage *)image success:(void (^)(NSString *, NSString *))success failure:(void (^)(NSError *))error {
    NSString *url=@"http://47.106.89.134:8080/upload";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 20;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
    
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
        [formData appendPartWithFileData:imageData name:@"picture" fileName:@"input_sample.jpg" mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //上传进度
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"progress is %@",uploadProgress);
        });
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject[@"status"], responseObject[@"message"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //请求失败
        NSLog(@"error-->%@",error);
    }];
}

+ (void)inferenceOffline:(NSString *)name pic:(UIImage *)image success:(void (^)(NSString *, NSString *))success failure:(void (^)(NSError *))error {
}

@end
