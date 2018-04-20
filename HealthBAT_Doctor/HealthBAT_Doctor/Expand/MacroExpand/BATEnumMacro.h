//
//  BATEnumMacro.h
//  HealthBAT_Pro
//
//  Created by cjl on 16/8/29.
//  Copyright © 2016年 KMHealthCloud. All rights reserved.
//

#ifndef BATEnumMacro_h
#define BATEnumMacro_h

/**
 推送通知类型

 - BATJPushMsgTypeDoctor: 医生
 - BATJPushMsgTypePatient: 患者
 */
typedef NS_ENUM(NSUInteger, BATJPushMsgType)
{
    BATJPushMsgTypeDoctor = 1,
    BATJPushMsgTypePatient = 2,
};

/**
 收藏类型
 
 - kBATCollectionLinkTypeDoctor:   医生
 - kBATCollectionLinkTypeHospital: 医院
 - kBATCollectionLinkTypeNews:     资讯
 - kBATCollectionLinkTypeDynamic:  动态
 - kBATCollectionLinkTypeCare:     关心
 - kBATCollectionLinkTypeCourse:   课程
 */
typedef NS_ENUM(NSInteger, BATCollectionLinkType) {
    kBATCollectionLinkTypeDoctor = 1,
    kBATCollectionLinkTypeHospital = 2,
    kBATCollectionLinkTypeNews = 3,
    kBATCollectionLinkTypeDynamic = 4,
    kBATCollectionLinkTypeCare = 5,
    kBATCollectionLinkTypeCourse = 6,
    kBATCollectionLinkTypeCourseCommentLike = 7,
};

/**
 订单类型

 - BATOrderType_Video: 视频
 - BATOrderType_Audio: 语音
 - BATOrderType_TextAndImage: 图文
 - BATOrderType_Family: 家庭
 */
typedef NS_ENUM(NSInteger,BATOrderType){
    BATOrderType_Video = 1,
    BATOrderType_Audio = 2,
    BATOrderType_TextAndImage = 3,
    BATOrderType_Family = 11,
};

/**
 工作室审核状态

 - BATAuditingType_PendingReview: 待审核/审核中
 - BATAuditingType_ReviewSuccess: 审核通过
 - BATAuditingType_ReviewFail: 审核不通过
 - BATAuditingType_Close: 关闭工作室
 */
typedef NS_ENUM(NSInteger,BATAuditingType){
    BATAuditingType_PendingReview = 0,
    BATAuditingType_ReviewSuccess = 1,
    BATAuditingType_ReviewFail = 2,
    BATAuditingType_Close = 3,
    BATAuditingType_NotOpen = 4,
};

/**
 聊天服务状态

 - batDoctorStudioTextImageStatus_DoctorAskOver: 医生请求结束
 - batDoctorStudioTextImageStatus_PatientAgreeOver: 患者同意结束
 - batDoctorStudioTextImageStatus_PatientCancelOver: 患者取消结束
 - batDoctorStudioTextImageStatus_PatientComplain: 患者投诉医生
 */
typedef NS_ENUM(NSInteger,BATDoctorStudioTextImageStatus){
    batDoctorStudioTextImageStatus_DoctorAskOver = 1,
    batDoctorStudioTextImageStatus_PatientAgreeOver = 2,
    batDoctorStudioTextImageStatus_PatientCancelOver = 3,
    batDoctorStudioTextImageStatus_PatientComplain = 4,
};

/**
 咨询状态

 - BATDoctorStudioConsultState_Consulting: 咨询中
 - BATDoctorStudioConsultState_ConsultFinish: 已咨询
 */
typedef NS_ENUM(NSInteger,BATDoctorStudioConsultState){
    BATDoctorStudioConsultState_Consulting = 1,
    BATDoctorStudioConsultState_ConsultFinish = 2,
};

///**
// 名医工作室图文咨询状态
// 3-待支付，4-未回复，5-咨询取消，6-咨询结束，1-咨询中，2-咨询完成
// 
// - BATDoctorStudioConsultStatus_Consulting: 咨询中
// - BATDoctorStudioConsultStatus_ConsultCompletion: 咨询完成
// - BATDoctorStudioConsultStatus_WaitingPay: 待支付
// - BATDoctorStudioConsultStatus_NoAnswer: 未回复
// - BATDoctorStudioConsultStatus_Cancel: 咨询取消
// - BATDoctorStudioConsultStatus_ConsultEnd: 咨询结束
// */
//typedef NS_ENUM(NSInteger,BATDoctorStudioConsultStatus){
//    BATDoctorStudioConsultStatus_Consulting = 1,
//    BATDoctorStudioConsultStatus_ConsultCompletion = 2,
//    BATDoctorStudioConsultStatus_WaitingPay = 3,
//    BATDoctorStudioConsultStatus_NoAnswer = 4,
//    BATDoctorStudioConsultStatus_Cancel = 5,
//    BATDoctorStudioConsultStatus_ConsultEnd = 6,
//};

/**
 通话状态

 - BATCallState_Call: 呼叫
 - BATCallState_Answer: 接听
 - BATCallState_Calling: 通话中
 */
typedef NS_ENUM(NSInteger,BATCallState) {
    BATCallState_Call = 1,
    BATCallState_Answer = 2,
    BATCallState_Calling = 3,
};

#pragma mark 健康圈-群组详情
/**
 *  群组详情获取动态操作enum
 */
typedef NS_ENUM(NSInteger, BATGroupDetailDynamicOpration) {
    /**
     *  全部
     */
    BATGroupDetailDynamicOprationAll = -1,
    /**
     *  动态
     */
    BATGroupDetailDynamicOprationDynamic = 0,
    /**
     *  问题
     */
    BATGroupDetailDynamicOprationQuestion = 1,
};

#endif /* BATEnumMacro_h */
