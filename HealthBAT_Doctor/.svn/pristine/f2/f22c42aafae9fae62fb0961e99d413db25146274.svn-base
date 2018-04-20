//
//  BATServiceSettingModel.h
//  HealthBAT_Pro
//
//  Created by cjl on 2017/3/20.
//  Copyright © 2017年 KMHealthCloud. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BATServiceSettingData,BATFamilyServiceItem,BATFamilyDoctorCostItem;
@interface BATServiceSettingModel : NSObject

@property (nonatomic, assign) NSInteger ResultCode;

@property (nonatomic, copy) NSString *ResultMessage;

@property (nonatomic, strong) BATServiceSettingData *Data;

@end

@interface BATServiceSettingData : NSObject

@property (nonatomic,copy) NSString *ID;

@property (nonatomic,assign) BOOL IsVideoConsult;

@property (nonatomic,copy) NSString *VideoConsultCost;

@property (nonatomic,assign) BOOL IsVoiceConsult;

@property (nonatomic,copy) NSString *VoiceConsultCost;

@property (nonatomic,assign) BOOL IsWordConsult;

@property (nonatomic,copy) NSString *WordConsultCost;

@property (nonatomic,assign) BOOL IsFamilyDoctor;

@property (nonatomic,strong) NSMutableArray <BATFamilyDoctorCostItem *> *FamilyDoctorCostList;

@property (nonatomic,strong) NSMutableArray <BATFamilyServiceItem *> *FamilyServiceList;

@end

@interface BATFamilyDoctorCostItem : NSObject

@property (nonatomic,copy) NSString *TKey;

@property (nonatomic,copy) NSString *TValue;

@end

@interface BATFamilyServiceItem : NSObject

@property (nonatomic,copy) NSString *TKey;

@property (nonatomic,assign) BOOL TValue;

@end
