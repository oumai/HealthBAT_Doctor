//
//  HTTPTool+BATUploadImage.m
//  HealthBAT_Pro
//
//  Created by KM on 16/9/132016.
//  Copyright © 2016年 KMHealthCloud. All rights reserved.
//

#import "HTTPTool+BATUploadImage.h"
#import "SVProgressHUD.h"

@implementation HTTPTool (BATUploadImage)

+ (void)requestUploadImageToBATWithParams:(id)params
                constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                                  success:(void(^)(NSArray *imageArray))success
                                  failure:(void(^)(NSError *error))failure
                        fractionCompleted:(void(^)(double count))fractionCompleted
{

    NSString *URLString = @"http://upload.jkbat.com";
    [HTTPTool baseUploadFileWithURLString:URLString HTTPHeader:nil WithParams:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {

        if (block) {

            block(formData);
        }
    } success:^(id dic) {

                NSArray *imageArray = (NSArray *)dic;
                if (success) {
                    success(imageArray);
                }
    } failure:^(NSError *error) {

        if (failure) {

            failure(error);
        }
    } fractionCompleted:^(double count) {

        if (fractionCompleted) {
            fractionCompleted(count);
        }
    }];
}

@end
