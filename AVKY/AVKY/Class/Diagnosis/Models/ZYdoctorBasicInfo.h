/*
 easymob_id : d300000315,
	mentor_id : 0,
	doctor_id : 300000315,
	doctor_gender : 1,
	flower_fee : 0,
	hospital_name : 北京协和医院,
	doctor_portrait : http://hdkj-web1.chinacloudapp.cn:8080/res/2093000003151445677716555.jpg,
	flower : 0,
	mentor_content : <null>,
	banner_fee : 0,
	flower_fee_name : <null>,
	doctor_title_name : 心理医生,
	banner : 0,
	is_saved : 2,
	banner_fee_name : <null>,
	doctor_name : 何晔鑫,
	operation_count : 0,
	department_name : 变态反应科门诊
 */
#import <Foundation/Foundation.h>

@interface ZYdoctorBasicInfo : NSObject
@property (nonatomic, copy) NSString * easymob_id;
@property (nonatomic, copy) NSNumber *mentor_id;
@property (nonatomic, copy) NSNumber *doctor_id;
@property (nonatomic, assign) BOOL doctor_gender;
@property (nonatomic, copy) NSNumber *flower_fee;
@property (nonatomic, copy) NSString *hospital_name;
@property (nonatomic, copy) NSString *doctor_portrait;
@property (nonatomic, copy) NSNumber *flower;
@property (nonatomic, copy) NSNumber *banner_fee;
@property (nonatomic, copy) NSNumber * is_saved;
@property (nonatomic, copy) NSString *doctor_name;
@property (nonatomic, copy) NSNumber * operation_count;
@property (nonatomic, copy) NSString *department_name;
@end
