//
//  FirstViewController.m
//  MasonryLearnDemo
//
//  Created by chenyufeng on 16/5/15.
//  Copyright © 2016年 chenyufengweb. All rights reserved.
//

#import "FirstViewController.h"
#import "Masonry.h"

//定义宏，用于block
#define WeakSelf(weakSelf) __weak __typeof(&*self)weakSelf = self;

@interface FirstViewController ()

@property (nonatomic, strong) UIView *redView;
@property (nonatomic, strong) UIView *grayView;

@end

/**
 *  (1)make.center.mas_equalTo(B) :view的X、Y轴中心位于B的中心；
   （2）make.size.mas_equalTo(CGSizeMake(200,200));  :设置view的大小，设置大小可以使用CGSizeMake,而不需要CGRectMake;
 */

/**
 *  masonry中有三种添加约束的方法：
 - (NSArray *)mas_makeConstraints:(void(^)(MASConstraintMaker *))block;
 - (NSArray *)mas_updateConstraints:(void(^)(MASConstraintMaker *))block;
 - (NSArray *)mas_remakeConstraints:(void(^)(MASConstraintMaker *make))block;
 
 
mas_makeConstraints:只负责新增约束，Autolayout不能同时存在两条针对同一对象的约束，否则会报错；
mas_updateConstraints:针对上面的情况，会更新在block中出现的约束，不会导致出现两个相同约束的情况；
mas_remakeConstraints：会清除之前的所有约束，仅保留最新的约束；

 */

/**
 *  讲讲equalTo和c的区别：其实mas_equalTo是一个宏
 #define mas_equalTo(...)                 equalTo(MASBoxValue((__VA_ARGS__)))
 #define mas_greaterThanOrEqualTo(...)    greaterThanOrEqualTo(MASBoxValue((__VA_ARGS__)))
 #define mas_lessThanOrEqualTo(...)       lessThanOrEqualTo(MASBoxValue((__VA_ARGS__)))

 #define mas_offset(...)                  valueOffset(MASBoxValue((__VA_ARGS__)))
 
 使用mas_equalTo其实就是对数据进行装箱。
mas_equalTo就是等于；
mas_greaterThanOrEqualTo就是大于等于；
mas_lessThanOrEqualTo就是小于等于；
 */

/**
 *  multipliedBy(0.5)
  这个参数就是设置比例系数
 */

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setRedView];
    [self setGrayViewEdgeInsetToRedView];
    [self setTwoViewInGrayView];


}

//绘制一个红色的View
- (void)setRedView
{
    WeakSelf(weakSelf);

    self.redView = [[UIView alloc] init];
    self.redView.backgroundColor = [UIColor redColor];
    //在设置Autolayout之前，要将view添加到self.view上面
    [self.view addSubview:self.redView];

    [self.redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(weakSelf.view);
        make.size.mas_equalTo(CGSizeMake(200, 200));
    }];
}

//在红色的View中绘制一个灰色的View
- (void)setGrayViewEdgeInsetToRedView
{
    WeakSelf(weakSelf);

    self.grayView = [[UIView alloc] init];
    self.grayView.backgroundColor = [UIColor grayColor];
    [self.redView addSubview:self.grayView];

    [self.grayView mas_makeConstraints:^(MASConstraintMaker *make) {
        // make.edges.equalTo(weakSelf.redView).with.insets(UIEdgeInsetsMake(20, 20, 20, 20));

        //上述代码也可以拆分为：
        //可以使用with对同一条约束设置参数
        make.top.equalTo(weakSelf.redView).with.offset(20);
        make.left.equalTo(weakSelf.redView).with.offset(20);
        make.bottom.equalTo(weakSelf.redView).with.offset(-20);
        make.right.equalTo(weakSelf.redView).with.offset(-20);
    }];
}

//在灰色View里面绘制两个等宽等间距的View,设置左右边距、相互之间边距为15
- (void)setTwoViewInGrayView
{
    WeakSelf(weakSelf);
    UIView *subView1 = [[UIView alloc] init];
    UIView *subView2 = [[UIView alloc] init];

    subView1.backgroundColor = [UIColor orangeColor];
    subView2.backgroundColor = [UIColor blueColor];

    [self.grayView addSubview:subView1];
    [self.grayView addSubview:subView2];

    [subView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.grayView.mas_centerY);
        make.left.equalTo(weakSelf.grayView.mas_left).with.offset(15);
        make.right.equalTo(subView2.mas_left).with.offset(-15);
        //设置subView1的高度为grayView高度的0.5.
        make.height.equalTo(self.grayView).multipliedBy(0.5);
        make.width.equalTo(subView2.mas_width);
    }];

    [subView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.grayView.mas_centerY);
        make.left.equalTo(subView1.mas_right).with.offset(15);
        make.right.equalTo(weakSelf.grayView.mas_right).offset(-15);
        make.height.equalTo(self.grayView).multipliedBy(0.5);
        make.width.equalTo(subView1.mas_width);
    }];

    //以上的两个约束还有如下简化的写法
    [subView1 mas_remakeConstraints:^(MASConstraintMaker *make) {
        //设置subView1的centerY属性，如果后面的grayView的参数也是centerY的话，就可以省略
        make.centerY.equalTo(weakSelf.grayView);
        //因为默认也是想要和grayView的左边距对齐，所以可以省略mas_left;
        make.left.equalTo(weakSelf.grayView).with.offset(15);
        //下面的mas_left不能省略，因为前面的参数是right,当前后参数不一致时，不能省略后面的参数
        make.right.equalTo(subView2.mas_left).with.offset(-15);
        make.height.equalTo(self.grayView).multipliedBy(0.5);
        //可以省略下面subView2的width参数
        make.width.equalTo(subView2);
    }];

    [subView2 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.grayView);
        make.left.equalTo(subView1.mas_right).with.offset(15);
        make.right.equalTo(weakSelf.grayView).offset(-15);
        make.height.equalTo(self.grayView).multipliedBy(0.5);
        make.width.equalTo(subView1);
    }];
}

@end
















