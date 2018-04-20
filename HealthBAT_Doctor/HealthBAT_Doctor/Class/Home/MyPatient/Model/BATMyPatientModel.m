//
//  BATMyPatientModel.m
//  HealthBAT_Pro
//
//  Created by cjl on 2017/3/21.
//  Copyright © 2017年 KMHealthCloud. All rights reserved.
//

#import "BATMyPatientModel.h"

@implementation BATMyPatientModel

+ (NSDictionary *)objectClassInArray{
    return @{@"Data" : [BATPatientItem class]};
}


@end

//@implementation BATMyPatientData
//
//+ (NSDictionary *)objectClassInArray{
//    return @{@"PatientList" : [BATPatientItem class]};
//}
//
//@end

@implementation BATPatientItem


@end
