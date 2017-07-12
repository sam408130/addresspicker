//
//  UIView+Common.m
//  AddressPicker
//
//  Created by Sam on 2017/7/12.
//  Copyright © 2017年 http://www.jianshu.com/u/a6249cca0aaf. All rights reserved.
//

#import "UIView+Common.h"
#import "SVProgressHUD.h"

@implementation UIView (Common)

-(void)showSuccess:(NSString *)info{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:127/255.0 green:27/255.0 blue:27/255.0 alpha:1]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setSuccessImage:[UIImage imageNamed:@"icon_zhengquezhuangtai"]];
    [SVProgressHUD showSuccessWithStatus:info];
}

-(void)showError:(NSString *)info{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:127/255.0 green:27/255.0 blue:27/255.0 alpha:1]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setErrorImage:[UIImage imageNamed:@"icon_cuowuzhuangtai"]];
    [SVProgressHUD showErrorWithStatus:info];
}


- (void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
- (void)setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
- (void)setOrigin:(CGPoint)origin{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}
- (void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
- (void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
- (void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size.width = size.width;
    frame.size.height = size.height;
    self.frame = frame;
}





@end
