//
//  BATAppDelegate+BATDoctorStatus.m
//  HealthBAT_Doctor
//
//  Created by cjl on 2017/4/11.
//  Copyright © 2017年 KM. All rights reserved.
//

#import "BATAppDelegate+BATDoctorStatus.h"

@implementation BATAppDelegate (BATDoctorStatus)

- (void)getDoctorStatus:(void (^)(BATAuditingType,BATDoctorStatusModel*))complete
{
    [HTTPTool requestWithURLString:@"/api/Doctor/GetDoctorStatusEntity" parameters:nil type:kGET success:^(id responseObject) {
        
        BATDoctorStatusModel *doctorStatusModel = [BATDoctorStatusModel mj_objectWithKeyValues:responseObject];
        
        if (doctorStatusModel.Data.IsOpenRoom) {
            
            if (doctorStatusModel.Data.Auditing == 0) {
                //待审核/审核中
                if (complete) {
                    complete(BATAuditingType_PendingReview,doctorStatusModel);
                }
                
            } else if (doctorStatusModel.Data.Auditing == 1) {
                //审核通过
                if (complete) {
                    complete(BATAuditingType_ReviewSuccess,doctorStatusModel);
                }
                
            } else if (doctorStatusModel.Data.Auditing == 2) {
                //审核不通过
                if (complete) {
                    complete(BATAuditingType_ReviewFail,doctorStatusModel);
                }
                
            } else if (doctorStatusModel.Data.Auditing == 3) {
                //关闭工作室
                if (complete) {
                    complete(BATAuditingType_Close,doctorStatusModel);
                }
                
            }
            
        } else {
            if (complete) {
                complete(BATAuditingType_NotOpen,doctorStatusModel);
            }
        }
    } failure:^(NSError *error) {
        if (complete) {
            complete(BATAuditingType_NotOpen,nil);
        }
    }];
}

@end
