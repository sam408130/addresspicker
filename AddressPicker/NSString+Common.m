//
//  NSString+Common.m
//  AddressPicker
//
//  Created by Sam on 2017/7/12.
//  Copyright © 2017年 http://www.jianshu.com/u/a6249cca0aaf. All rights reserved.
//

#import "NSString+Common.h"

@implementation NSString (Common)


- (CGSize)getSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size{
    CGSize resultSize = CGSizeZero;
    if (self.length <= 0) {
        return resultSize;
    }
    resultSize = [self boundingRectWithSize:size
                                    options:(NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin)
                                 attributes:@{NSFontAttributeName: font}
                                    context:nil].size;
    
    resultSize = CGSizeMake(MIN(size.width, ceilf(resultSize.width)), MIN(size.height, ceilf(resultSize.height)));
    
    return resultSize;
}



- (CGFloat)getHeightWithFont:(UIFont *)font constrainedToSize:(CGSize)size{
    return [self getSizeWithFont:font constrainedToSize:size].height;
}
- (CGFloat)getWidthWithFont:(UIFont *)font constrainedToSize:(CGSize)size{
    return [self getSizeWithFont:font constrainedToSize:size].width;
}

@end
