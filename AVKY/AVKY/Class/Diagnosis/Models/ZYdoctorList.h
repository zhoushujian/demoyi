/*
    flower : 4,
	operation_count : 1,
	banner : 7,
	doctor_hospital_name : 北京协和医院,
	doctor_name : 王天峰,
	doctor_portrait : http://www.bjcancer.org/Sites_OldFiles/Template/default/picture/doctor/23-large.jpg,
	doctor_id : 200000124,
	doctor_title_name : 其他,
	doctor_gender : 1,
	accuracy : 98%,
	easymob_id : d200000124
 */

#import <Foundation/Foundation.h>

@interface ZYdoctorList : NSObject
@property (nonatomic, copy) NSNumber *operation_count;
@property (nonatomic, copy) NSNumber *banner;
@property (nonatomic, copy) NSString *doctor_hospital_name;
@property (nonatomic, copy) NSString *doctor_name;
@property (nonatomic, copy) NSString *doctor_portrait;
@property (nonatomic, copy) NSNumber *doctor_id;
@property (nonatomic, copy) NSString *doctor_title_name;
@property (nonatomic, assign) BOOL doctor_gender;
@property (nonatomic, copy) NSString *accuracy;
@property (nonatomic, copy) NSString *easymob_id;
@end
