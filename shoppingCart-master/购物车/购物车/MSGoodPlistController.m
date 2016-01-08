//
//  MSGoodPlistController.m
//  购物车
//
//  Created by JLHong on 15/12/16.
//  Copyright © 2015年 long. All rights reserved.
//

#import "MSGoodPlistController.h"
#import "MSGoodPlist.h"
#import "MSGoodPlistCell.h"
#import <Masonry.h>
#import "MSShoppingController.h"

#define sreenWidth  [UIScreen mainScreen].bounds.size.width

@interface MSGoodPlistController ()
@property(strong,nonatomic) NSArray *goodPlists;///<<#name#>
@property (strong , nonatomic ) UILabel  *addCountLabel;///<<#name#>
@property (strong , nonatomic )  UIButton  *rightItemBtn;///<<#name#>
@property(strong,nonatomic) NSMutableArray  *addGoodArray;///<<#name#>
@property(strong,nonatomic) CALayer  *layer;///<<#name#>
@property(strong,nonatomic) UIBezierPath *path;///<<#name#>
@end


@implementation MSGoodPlistController

#pragma mark - view life circle  viewController生命周期方法

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 90 ;
    self.title = @"商品列表";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightItemBtn];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
       self.addCountLabel.frame = CGRectMake(0, 0, 15, 15);
        [self.rightItemBtn addSubview:self.addCountLabel];
}

#pragma mark - custom methods  自定义方法
- (void)buyCountClick:(UIButton *)item {
    
    MSShoppingController *spVc = [[MSShoppingController alloc] init];
    spVc.addGoodArray = self.addGoodArray;
    [self.navigationController presentViewController: [[UINavigationController alloc] initWithRootViewController: spVc] animated:YES completion:nil];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

     return self.goodPlists.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MSGoodPlistCell *cell = [MSGoodPlistCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.goodplist = self.goodPlists[indexPath.row];
    
    __weak typeof(self) weakSeif = self;
    [cell setCompleteBlock:^(MSGoodPlistCell *cell, UIImageView *imageView) {
        
        NSIndexPath *indexPath =  [self.tableView indexPathForCell:cell];

        [weakSeif.addGoodArray addObject:weakSeif.goodPlists[indexPath.row]];
        
        CGRect rect = [tableView rectForRowAtIndexPath:indexPath];
        rect.origin.y -= tableView.contentOffset.y;
        CGRect headRect = imageView.frame;
        headRect.origin.y = rect.origin.y + headRect.origin.y - 64;
        [self startAnimationWith:headRect imageView:imageView];
    }];
    return cell;
}

- (void) startAnimationWith: (CGRect )rect imageView: (UIImageView *)imageView{
    
    if (self.layer == nil) {
        self.layer = [[CALayer alloc] init];
        self.layer.contents = imageView.layer.contents;
        self.layer.contentsGravity = kCAGravityResizeAspectFill;
        self.layer.bounds = rect ;
        self.layer.cornerRadius = CGRectGetHeight(self.layer.bounds) * 0.5;
        self.layer.masksToBounds = YES;
        self.layer.position = CGPointMake(imageView.center.x, CGRectGetMinY(rect) + 96);
        [UIApplication.sharedApplication.keyWindow.layer addSublayer: self.layer];
       
        _path = [[UIBezierPath alloc] init];
        [self.path moveToPoint:self.layer.position];
        [self.path addQuadCurveToPoint:CGPointMake(sreenWidth - 25, 35) controlPoint:CGPointMake(sreenWidth *0.5, rect.origin.y - 80)];
    }
    
    [self groupAnimation];
}

- (void)groupAnimation {
    // 开始动画禁用tableview交互
    self.tableView.userInteractionEnabled = NO;
    
    // 帧动画
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = self.path.CGPath;
    animation.rotationMode = kCAAnimationRotateAuto;
    
    // 放大动画
    CABasicAnimation *bigAnimation = [CABasicAnimation animationWithKeyPath: @"transform.scale"];
    bigAnimation.duration = 0.5;
    bigAnimation.fromValue = [NSNumber numberWithInt:1];
    bigAnimation.toValue = [NSNumber numberWithInt:2];
    bigAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    // 缩小动画
    CABasicAnimation *smallAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    smallAnimation.beginTime = 0.5;
    smallAnimation.duration = 1.5;
    smallAnimation.fromValue =  [NSNumber numberWithInt:2];
    smallAnimation.toValue =  [NSNumber numberWithFloat:0.3];
    smallAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    // 组动画
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = @[animation,bigAnimation,smallAnimation];
    groupAnimation.duration = 2;
    groupAnimation.removedOnCompletion = NO;
    groupAnimation.fillMode = kCAFillModeForwards;
    groupAnimation.delegate = self;
    [self.layer addAnimation:groupAnimation forKey: @"groupAnimation"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    // 如果动画是我们的组动画，才开始一些操作
    if (anim ==[self.layer animationForKey:@"groupAnimation"]) {
        
        // 开启交互
        self.tableView.userInteractionEnabled = YES;
        
        // 隐藏图层
        [self. layer removeAllAnimations];
        [self. layer removeFromSuperlayer];
        self. layer = nil;
        
        // 如果商品数大于0，显示购物车里的商品数量
        if (self.addGoodArray.count > 0) {
            _addCountLabel.hidden = NO;
        }
        
        // 商品数量渐出
        CATransition *goodCountAnimation = [CATransition animation];
        
        goodCountAnimation.duration = 0.25;
         _addCountLabel.text = [NSString stringWithFormat:@"%zd",self.addGoodArray.count];
        [_addCountLabel.layer addAnimation:goodCountAnimation forKey:nil];
        
        // 购物车抖动
        CABasicAnimation *cartAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
        
        cartAnimation.duration = 0.25;
        cartAnimation.fromValue = [NSNumber numberWithInt:-5];
        cartAnimation.toValue = [NSNumber numberWithInt:5];
        cartAnimation.autoreverses = YES;
        [self.rightItemBtn.layer addAnimation:cartAnimation forKey:nil];
    }
}

#pragma mark - getters and setters
- (UIButton *)rightItemBtn{
    if (_rightItemBtn == nil ){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"button_cart"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(buyCountClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn sizeToFit];
        self.rightItemBtn = btn;
    }
    return _rightItemBtn;
}

- (UILabel *)addCountLabel {
    
    if(_addCountLabel == nil){
        UILabel *label = [[UILabel alloc] init];
         _addCountLabel = label;
        _addCountLabel.backgroundColor = [UIColor whiteColor];
        _addCountLabel.textColor = [UIColor redColor];
        _addCountLabel.font = [UIFont boldSystemFontOfSize:11];
        _addCountLabel.textAlignment = NSTextAlignmentCenter;
        _addCountLabel.text = [NSString stringWithFormat:@"%zd",self.addGoodArray.count];
        _addCountLabel.layer.cornerRadius = 7.5;
        _addCountLabel.layer.masksToBounds = true;
        _addCountLabel.layer.borderWidth = 1;
        _addCountLabel.layer.borderColor = [UIColor redColor].CGColor;
        _addCountLabel.hidden = YES;

    }
    return _addCountLabel;
}

- (NSMutableArray *)addGoodArray {
    if (_addGoodArray == nil) {
        
        _addGoodArray = [NSMutableArray array];
    }
    return _addGoodArray;
}

- (NSArray *)goodPlists {
    if (_goodPlists == nil) {
        _goodPlists = [MSGoodPlist goodPlists];
    }
    return _goodPlists;
}
@end
