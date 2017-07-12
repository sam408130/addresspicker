//
//  Address.h
//  XiaoTuiChe
//
//  Created by Sam on 12/18/15.
//  Copyright © 2015 Ding Sai. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "AddrObject.h"

@interface Address : NSObject

@property (nonatomic, strong) NSString *userName , *phone, *address, *cityName, *provinceName, *userId, *zipCode, *cityStr, *districtName, *fullAddress , *defaultFlag;
@property (nonatomic, strong) AddrObject *province, *city, *district;
@property (nonatomic, strong) NSString *cityId, *provinceId, *distId, *addressId;
@property (nonatomic, assign) BOOL isSelected;

-(NSDictionary *)toParams;
@end
