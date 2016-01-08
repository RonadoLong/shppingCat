//
//  MSGoodPlist.h
//  购物车
//
//  Created by JLHong on 15/12/16.
//  Copyright © 2015年 long. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSGoodPlist : NSObject

@property (copy , nonatomic) NSString *icon; ///<<#name#>

@property (copy , nonatomic) NSString *title; ///<<#name#>

@property (copy , nonatomic) NSString *desc; ///<<#name#>

@property (copy , nonatomic) NSString *buyCount; ///<<#name#>

@property (assign , nonatomic) BOOL isAddShoppingCar; ///<<#name#>

@property (copy , nonatomic) NSString *newprice; ///<<#name#>

@property (copy , nonatomic) NSString *oldprice; ///<<#name#>

@property (assign , nonatomic) BOOL isSelected ;///<<#name#>

- (instancetype) initWithDict:(NSDictionary *)dict;

+ (instancetype) goodPlistWithDict:(NSDictionary *)dict;

+ (NSArray *)goodPlists;

@end
