/*
 duty_status_name : 有号,
	icon_type : 1,
	duty_status : 1,
	duty_source_id : 5561,
	zuozhen_id : 144,
	duty_code : 1,
	has_number : 1,
	duty_date : 2015-12-30
 */

#import <Foundation/Foundation.h>

@interface duties : NSObject
@property (nonatomic, copy) NSString *duty_status_name;
@property (nonatomic, copy) NSNumber * icon_type;
@property (nonatomic, copy) NSNumber * duty_status;
@property (nonatomic, copy) NSNumber * duty_source_id;
@property (nonatomic, copy) NSNumber * zuozhen_id;
@property (nonatomic, copy) NSNumber * duty_code;
@property (nonatomic, copy) NSNumber * has_number;
@property (nonatomic, copy) NSString * duty_date;
@end
