//
//  UIView+Common.h
//  AddressPicker
//
//  Created by Sam on 2017/7/12.
//  Copyright © 2017年 http://www.jianshu.com/u/a6249cca0aaf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Common)

-(void)showSuccess:(NSString *)info;
-(void)showError:(NSString *)info;

- (void)setY:(CGFloat)y;
- (void)setX:(CGFloat)x;
- (void)setOrigin:(CGPoint)origin;
- (void)setHeight:(CGFloat)height;
- (void)setWidth:(CGFloat)width;
- (void)setSize:(CGSize)size;



@end
