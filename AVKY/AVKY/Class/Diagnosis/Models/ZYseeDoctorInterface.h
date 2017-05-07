/*{zuozhen_infos : [
	{
	zuozhen_department_name : 神经内科,
	icon_type : 1,
	zuozhen_fee : 12,
	zuozhen_address : 走哪算哪,
	zuozhen_id : 144,
	offer_time : 9：00,
	zuozhen_hospital_name : 北京协和医院
 }],period : 14,
	start_date : 2015-12-30,
	duties : [
	{
	duty_status_name : 有号,
	icon_type : 1,
	duty_status : 1,
	duty_source_id : 5561,
	zuozhen_id : 144,
	duty_code : 1,
	has_number : 1,
	duty_date : 2015-12-30},]}
 */

#import <Foundation/Foundation.h>
#import "zuozhen_infos.h"
#import "duties.h"

@interface ZYseeDoctorInterface : NSObject
@property (nonatomic, strong) zuozhen_infos *zuozhen_infos;
@property (nonatomic, copy) NSNumber * period;
@property (nonatomic, copy) NSString *start_date;
@property (nonatomic, strong) duties *duties;
@end
