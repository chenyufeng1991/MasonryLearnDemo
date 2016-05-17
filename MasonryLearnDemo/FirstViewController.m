//
//  FirstViewController.m
//  MasonryLearnDemo
//
//  Created by chenyufeng on 16/5/15.
//  Copyright © 2016年 chenyufengweb. All rights reserved.
//

#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
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
 
 
mas_makeConstraints:只负责新增约束，初次设置约束使用；
mas_updateConstraints:针对上面的情况，会更新在block中出现的约束。如果找不到这条约束，会新增。
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
 
 常数系数:
 Masonry提供了四种设置Constant的方法：
 
// 设置left,right,top,bottom.接收MASEdgeInsets类型，其实也就是UIEdgeInsets类型，使用UIEdgeInsetsMake方法设置。
- (MASConstraint * (^)(MASEdgeInsets insets))insets;

// 设置width,height。接收CGSize类型，使用CGSizeMake方法设置。
- (MASConstraint * (^)(CGSize offset))sizeOffset;

// 设置centerX,centerY
- (MASConstraint * (^)(CGPoint offset))centerOffset;

// 设置所有的常量
- (MASConstraint * (^)(CGFloat offset))offset;
 */

/**
 *  对于一个约束，实际表示的是不等或者相等关系：
 aView.Leading = 1.0 * bView.Trailing + 10;
 
 aView：Item1；
 Leading：Attribute1;
 = :Relationship；
 1.0 ：Multipler；
 bView：Item2；
 Trailing：Attribute2；
 10 ：Constant;

 */

/**
 *  make是MASConstraintMaker类型。MASConstraintMaker提供了22种Attribute类型。
 
 //第一类
 @property (nonatomic, strong, readonly) MASConstraint *left;
 @property (nonatomic, strong, readonly) MASConstraint *top;
 @property (nonatomic, strong, readonly) MASConstraint *right;
 @property (nonatomic, strong, readonly) MASConstraint *bottom;
 @property (nonatomic, strong, readonly) MASConstraint *leading;
 @property (nonatomic, strong, readonly) MASConstraint *trailing;
 @property (nonatomic, strong, readonly) MASConstraint *width;
 @property (nonatomic, strong, readonly) MASConstraint *height;
 @property (nonatomic, strong, readonly) MASConstraint *centerX;
 @property (nonatomic, strong, readonly) MASConstraint *centerY;
 @property (nonatomic, strong, readonly) MASConstraint *baseline;

 //第二类
 @property (nonatomic, strong, readonly) MASConstraint *leftMargin;
 @property (nonatomic, strong, readonly) MASConstraint *rightMargin;
 @property (nonatomic, strong, readonly) MASConstraint *topMargin;
 @property (nonatomic, strong, readonly) MASConstraint *bottomMargin;
 @property (nonatomic, strong, readonly) MASConstraint *leadingMargin;
 @property (nonatomic, strong, readonly) MASConstraint *trailingMargin;
 @property (nonatomic, strong, readonly) MASConstraint *centerXWithinMargins;
 @property (nonatomic, strong, readonly) MASConstraint *centerYWithinMargins;
 
 //第三类
 @property (nonatomic, strong, readonly) MASConstraint *edges;
 @property (nonatomic, strong, readonly) MASConstraint *size;
 @property (nonatomic, strong, readonly) MASConstraint *center;
 
 
 （1）第一类是基本属性，向下支持到iOS6，一般用的比较多；
 （2）第二类是边缘相关属性，向下支持到iOS8，由于版本要求比较高，所以用的比较少；
 （3）第三类是复合属性，edges（left,top,right,bottom）,size(width,height),center(centerX,centerY).

 */

/**
 *  扩展UiView中的属性：

 @property (nonatomic, strong, readonly) MASViewAttribute *mas_left;
 @property (nonatomic, strong, readonly) MASViewAttribute *mas_top;
 @property (nonatomic, strong, readonly) MASViewAttribute *mas_right;
 @property (nonatomic, strong, readonly) MASViewAttribute *mas_bottom;
 @property (nonatomic, strong, readonly) MASViewAttribute *mas_leading;
 @property (nonatomic, strong, readonly) MASViewAttribute *mas_trailing;
 @property (nonatomic, strong, readonly) MASViewAttribute *mas_width;
 @property (nonatomic, strong, readonly) MASViewAttribute *mas_height;
 @property (nonatomic, strong, readonly) MASViewAttribute *mas_centerX;
 @property (nonatomic, strong, readonly) MASViewAttribute *mas_centerY;
 @property (nonatomic, strong, readonly) MASViewAttribute *mas_baseline;
 @property (nonatomic, strong, readonly) MASViewAttribute *(^mas_attribute)(NSLayoutAttribute attr);

 @property (nonatomic, strong, readonly) MASViewAttribute *mas_leftMargin;
 @property (nonatomic, strong, readonly) MASViewAttribute *mas_rightMargin;
 @property (nonatomic, strong, readonly) MASViewAttribute *mas_topMargin;
 @property (nonatomic, strong, readonly) MASViewAttribute *mas_bottomMargin;
 @property (nonatomic, strong, readonly) MASViewAttribute *mas_leadingMargin;
 @property (nonatomic, strong, readonly) MASViewAttribute *mas_trailingMargin;
 @property (nonatomic, strong, readonly) MASViewAttribute *mas_centerXWithinMargins;
 @property (nonatomic, strong, readonly) MASViewAttribute *mas_centerYWithinMargins;
 
 
 基本和MASConstraintMaker中的属性一样，只是每个属性前面都有mas_前缀，因为这个类是扩展UiView的，为了和系统类中属性区别，所以加了前缀。

 */

/**
 *  小技巧：
 （1）如果等式两边的Attribute是一样的，可以省略等式右边的Atteibute;
  (2)如果是等于关系，并且右边的view是父view，equal_to也可以省略。
 */

/**
 *  shorthand简便写法：Masonry提供了不加mas_前缀的方法，只需要定义几个宏。
 （1）MAS_SHORTHAND
 定义了MAS_SHORTHAND宏之后，就可以使用UIView,NSArray中不带mas_前缀的makeConstraints,updateConstraints,remakeConstraints.以及UIView中不带mas_前缀的Attribute。
 
 （2）MAS_SHORTHAND_GLOBALS
 默认的equalTo方法只接收id类型的对象，有时候我们想传入一个CGFloat，CGSize，UIEdgeInsets，还需要转换为NSValue对象，比较麻烦。只需要定义MAS_SHORTHAND_GLOBALS宏，就可以直接对equalTo传入基础类型，Masonry自动转化为NSValue对象。
 */

/**
 *  Masonry共有13个类，这13个类分为5个模块：
 Core：MASConstraintMaker,MASViewConstraint,MASCompositeConstraint,MASConstraint;
 Property:MASLayoutConstraint,MASViewAttribute;
 Public:NSArray+MASAdditions,View+MASAdditions;
 Help:NSLayoutConstraint+MASDebugAdditions,ViewController+MASAdditions,MASUtilities;
 Shorthand:NSArray+MASShorthandAdditions,View+MASShorthandAddtions
 
 makes debug and log output of NSLayoutConstraints more readable
 (1)NSLayoutConstraint+MASDebugAdditions:在头文件中作者已经说明：该类是为了NSLayoutConstraints的调试和日志输出更具有可读性。比如在约束冲突的时候，更易读。如果View或constraint设置了mas_key,直接用key的值显示到desctiption中，如果没有设置，直接显示View或constraint的指针。
 （2）NSArray+MASShorthandAdditions和View+MASShorthandAddtions中定义了不带mas_前缀的扩展。这些扩展根据是否定义了MAS_SHORTHAND来确定是否编译。
 （3）NSArray+MASAddtons:对外暴露添加、更新、移除约束的方法。
 （4）View+MASAddtions:为View增加mas_top,mas_left等属性。
 */

/**
 *  with的使用：
 源码对with的解释是：with是一个可选的语法属性，没有任何影响但是能提高约束的可读性。
 */

/**
 *  centerX:X轴中心位置；
    centerY:Y轴中心位置；
 */

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setRedView];
    [self setGrayViewEdgeInsetToRedView];
    [self setTwoViewInGrayView];

    [self setMutiplierAndConstant];

    [self setViewWithKey];
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
        //可以使用符合属性设置
        // make.edges.equalTo(weakSelf.redView).with.insets(UIEdgeInsetsMake(20, 20, 20, 20));

        //上述代码也可以拆分为：
        //可以使用with对同一条约束设置参数
        //        make.top.equalTo(weakSelf.redView).with.offset(20);
        //        make.left.equalTo(weakSelf.redView).with.offset(20);
        //        make.bottom.equalTo(weakSelf.redView).with.offset(-20);
        //        make.right.equalTo(weakSelf.redView).with.offset(-20);

        // 也可以去掉with
        make.top.equalTo(weakSelf.redView).offset(20);
        make.left.equalTo(weakSelf.redView).offset(20);
        make.bottom.equalTo(weakSelf.redView).offset(-20);
        make.right.equalTo(weakSelf.redView).offset(-20);
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
        make.height.equalTo(weakSelf.grayView).multipliedBy(0.5);
        make.width.equalTo(subView2.mas_width);
    }];

    [subView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.grayView.mas_centerY);
        make.left.equalTo(subView1.mas_right).with.offset(15);
        make.right.equalTo(weakSelf.grayView.mas_right).offset(-15);
        make.height.equalTo(weakSelf.grayView).multipliedBy(0.5);
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
        make.height.equalTo(weakSelf.grayView).multipliedBy(0.5);
        //可以省略下面subView2的width参数
        make.width.equalTo(subView2);
    }];

    [subView2 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.grayView);
        make.left.equalTo(subView1.mas_right).with.offset(15);
        make.right.equalTo(weakSelf.grayView).offset(-15);
        make.height.equalTo(weakSelf.grayView).multipliedBy(0.5);
        make.width.equalTo(subView1);
    }];
}

//比例系数和常数
/**
 *  我要绘制一个View，宽度是self.view的0.5再减少10，高度是self.view的0.2，距离self.view左边距10，根据以下公式：
 A.width = multipier * B.width + constant
 
 小技巧：
 （1）multipier默认为1时，可以不写。
 （2）offset默认为0时，可以不写。
 所以，如果你不嫌麻烦的话，可以对所有的约束添加multipliedBy()和offset().看起来也会清楚直观。
 */
- (void)setMutiplierAndConstant
{
    WeakSelf(weakSelf);
    UIView *yellowView = [[UIView alloc] init];
    yellowView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:yellowView];

    [yellowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(weakSelf.view.mas_width).offset(-10).multipliedBy(0.5);//根据公式，这里的-10就是constant.
        make.height.equalTo(weakSelf.view.mas_height).multipliedBy(0.2).offset(0);
        make.top.equalTo(weakSelf.redView.mas_bottom).multipliedBy(1).offset(0);
        make.left.equalTo(weakSelf.view.mas_left).multipliedBy(1).offset(10);
    }];
}

/**
 *  这里要用到mas_key属性，其实也相当于View原生的tag属性一样，是为了来区分不同的View的。mas_key标识的是字符串，更加方便直观。
 */
/**
 下面的方法中的约束是包含冲突的，当没有设置mas_key时，警告输出是这样的：
 Probably at least one of the constraints in the following list is one you don't want.
	Try this:
 (1) look at each constraint and try to figure out which you don't expect;
 (2) find the code that added the unwanted constraint or constraints and fix it.
 (
 "<MASLayoutConstraint:0x7fef6a6a5d80 UIView:0x7fef6a4289d0.width == 100>",
 "<MASLayoutConstraint:0x7fef6a7161a0 UIView:0x7fef6a4289d0.left == UIView:0x7fef6a40b970.left + 10>",
 "<MASLayoutConstraint:0x7fef6a7145e0 UIView:0x7fef6a4289d0.right == UIView:0x7fef6a40b970.right - 10>",
 "<NSLayoutConstraint:0x7fef6a7ade60 UIView:0x7fef6a40b970.width == 320>"
 )

 Will attempt to recover by breaking constraint
 <MASLayoutConstraint:0x7fef6a6a5d80 UIView:0x7fef6a4289d0.width == 100>
 */

/**
 *  当设置mas_key后，警告输出是这样的：提示信息就非常明确了。
 Probably at least one of the constraints in the following list is one you don't want.
	Try this:
 (1) look at each constraint and try to figure out which you don't expect;
 (2) find the code that added the unwanted constraint or constraints and fix it.
 (
 "<MASLayoutConstraint:0x7fbf23e3b0b0 UIView:firstView.width == 100>",
 "<MASLayoutConstraint:0x7fbf23e58410 UIView:firstView.left == UIView:self.view.left + 10>",
 "<MASLayoutConstraint:0x7fbf23e588d0 UIView:firstView.right == UIView:self.view.right - 10>",
 "<NSLayoutConstraint:0x7fbf23e5a610 UIView:self.view.width == 320>"
 )

 Will attempt to recover by breaking constraint
 <MASLayoutConstraint:0x7fbf23e3b0b0 UIView:firstView.width == 100>
 */
- (void)setViewWithKey
{
    UIView *firstView = [[UIView alloc] init];
    firstView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:firstView];

    //这里使用mas_key参数
    self.view.mas_key = @"self.view";
    firstView.mas_key = @"firstView";

    //写一个冲突的约束
    [firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 100));
        make.left.offset(10);
        make.right.offset(-10);
    }];
}


//使用宏定义后，我还是以上面setViewWithKey中的实现为例
/**
 *  #define MAS_SHORTHAND
    #define MAS_SHORTHAND_GLOBALS
    #import "Masonry.h"
 
 注意： #import "Masonry.h"导入头文件一定要在两个宏定义之后。
 
 添加了MAS_SHORTHAND之后，就不用带mas_前缀；
 添加了MAS_SHORTHAND_GLOBALS之后，equalTo等价于mas_equalTo

 */

- (void)useShorthand
{
    UIView *firstView = [[UIView alloc] init];
    firstView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:firstView];

    self.view.mas_key = @"self.view";
    firstView.mas_key = @"firstView";

    //写一个冲突的约束
    [firstView makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(100, 100));
        make.left.offset(10);
        make.right.offset(-10);
    }];

}


@end
















