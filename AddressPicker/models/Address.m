//
//  Address.m
//  XiaoTuiChe
//
//  Created by Sam on 12/18/15.
//  Copyright © 2015 Ding Sai. All rights reserved.
//

#import "Address.h"

@implementation Address




- (NSDictionary *)toParams {
    
    return @{
             @"phone":self.phone,
             @"userName":self.userName,

             @"provinceName":self.provinceName,
             @"cityName":self.cityName,
             @"address":self.address,
             @"addressId":self.addressId,
             @"districtName":self.districtName,
             @"defaultFlag":@"0"
             };
}

@end
