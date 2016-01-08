//
//  MSGoodPlist.m
//  购物车
//
//  Created by JLHong on 15/12/16.
//  Copyright © 2015年 long. All rights reserved.
//

#import "MSGoodPlist.h"

@implementation MSGoodPlist

-  (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dict];
        self.isAddShoppingCar =  NO;
        self.buyCount = [NSString stringWithFormat:@"1"];
        self.isSelected = YES;
    }
    return self;
}

+ (instancetype)goodPlistWithDict:(NSDictionary *)dict {
    
    return [[self alloc] initWithDict:dict];
}


+ (NSArray *)goodPlists {

    NSMutableArray *goodArr = [NSMutableArray array];
    
    for (int index = 0 ; index < 10;  index ++) {
        
        NSMutableDictionary *addDict = [NSMutableDictionary dictionary];
        addDict[@"icon"] =  [NSString stringWithFormat:@"goodicon_%zd",index];
        addDict[@"title"] = [NSString stringWithFormat:@"%zd阿哥",index + 1];
        addDict[@"desc"] =[NSString stringWithFormat:@"这是第%zd个商品",index + 1];
        addDict[@"newprice"] = [NSString stringWithFormat:@"1000%zd",index];
        addDict[@"oldprice"] = [NSString stringWithFormat:@"2000%zd",index];
        
        [goodArr addObject: [self goodPlistWithDict:addDict]];
    }
    return goodArr.copy;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}
@end
