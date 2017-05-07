/**
 
 这个分类主要是解决 textfield 输入框左边图片
 
 */

#import <UIKit/UIKit.h>

@interface UITextField (image)

/**
 *  设置textfield 的leftView 图片
 *
 *  @param textField textfield
 *  @param iamgeName 图片名
 */
+(void)setTextFieldLeftImage:(UITextField *)textField image:(NSString *)imageName;
@end
