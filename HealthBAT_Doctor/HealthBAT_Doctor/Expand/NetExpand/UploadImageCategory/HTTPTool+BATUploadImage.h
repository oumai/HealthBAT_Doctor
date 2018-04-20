//
//  HTTPTool+BATUploadImage.h
//  HealthBAT_Pro
//
//  Created by KM on 16/9/132016.
//  Copyright © 2016年 KMHealthCloud. All rights reserved.
//

#import "HTTPTool.h"
#import "BATUploadImageModel.h"

@interface HTTPTool (BATUploadImage)


/**
 上传文件

 @param params 参数
 @param block 上传formData
 @param success 成功
 @param failure 失败
 @param fractionCompleted 进度
 */
+ (void)requestUploadImageToBATWithParams:(id)params
                constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                                  success:(void(^)(NSArray *imageArray))success
                                  failure:(void(^)(NSError *error))failure
                        fractionCompleted:(void(^)(double count))fractionCompleted;
@end
