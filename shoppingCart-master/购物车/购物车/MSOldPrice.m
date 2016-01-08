//
//  MSOldPrice.m
//  购物车
//
//  Created by JLHong on 15/12/16.
//  Copyright © 2015年 long. All rights reserved.
//

#import "MSOldPrice.h"

@implementation MSOldPrice

- (void)drawRect:(CGRect)rect{
    
    [super drawRect:rect];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(ctx, 0, rect.size.height * 0.5);
    CGContextAddLineToPoint(ctx, rect.size.width, rect.size.height * 0.5);
    CGContextStrokePath(ctx);
}

@end
