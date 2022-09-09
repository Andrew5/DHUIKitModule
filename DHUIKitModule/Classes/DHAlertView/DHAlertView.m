//
//  DHAlertView.m
//  AFNetworking
//
//  Created by rilakkuma on 2022/9/8.
//

#import "DHAlertView.h"
@interface DHAlertView ()
@property (nonatomic, strong) UIView *contentRootView;
@property (nonatomic, assign) CGRect contentFrame;

@end
@implementation DHAlertView
- (id)init {
    self = [super init];
    if (self) {
        [self createUI];
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self) {
        if (CGRectIsEmpty(frame)) {
            //frame 是空 什么都不做
        }else{
            [self createUI];
        }
    }
    return self;
}

///换成懒加载
- (void)createUI {
    //背景
    UIView *backView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    backView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    [self addSubview:backView];
    self.contentFrame = backView.frame;
    CGFloat HContentRootView = 200;//弹窗子控件高度
    CGFloat spaceContentRootView = 40;//弹窗子控件左右间距

    //子控件添加至此View上
    UIView *contentRootView = [[UIView alloc]init];
    [self addSubview:contentRootView];
    contentRootView.frame = CGRectMake(spaceContentRootView, (CGRectGetHeight(backView.frame) - HContentRootView)/2, CGRectGetWidth(backView.frame) - spaceContentRootView * 2, HContentRootView);
    contentRootView.backgroundColor = UIColor.whiteColor;
    
    CAShapeLayer *topCornerLayer = [CAShapeLayer layer];
    topCornerLayer.fillColor = UIColor.whiteColor.CGColor;
    topCornerLayer.frame = contentRootView.bounds;
    UIBezierPath *path = nil;
    path = [UIBezierPath bezierPathWithRoundedRect:contentRootView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(4, 4)];
    topCornerLayer.path = path.CGPath;
    contentRootView.layer.mask = topCornerLayer;
    
    UILabel *textLabel = [[UILabel alloc]init];
    textLabel.text = @"尊敬的用户您好：为了给您提供更优质的服务，请您联系客服安装万商APP，客服电话：xxxxxx,感谢您的支持！";

//        CGSize textSize = [textLabel.text boundingRectWithSize:CGSizeMake(CGRectGetWidth(contentRootView.frame) - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    //计算出最优的size不会改变自己的size sizeThatFits并不会折行显示
    CGSize size = [textLabel sizeThatFits:CGSizeMake(CGRectGetWidth(contentRootView.frame) - 20, MAXFLOAT)];
    textLabel.frame = CGRectMake(10, 10, CGRectGetWidth(contentRootView.frame) - 20, size.height);
    textLabel.numberOfLines = 0;
    // sizeToFit 会根据 字体大小 和多少计算出最优的 size 并改变自身的 size sizeToFits会在设置的宽度内折行显示
    [textLabel sizeToFit];

    textLabel.textColor = UIColor.blackColor;
    [contentRootView addSubview:textLabel];
    
    UIButton *buttonTmp;
    NSArray *titleArray = @[@"我再想想",@"下载万商"];
    for (int i = 0; i< titleArray.count; i++) {
        CGFloat Wbutton = CGRectGetWidth(contentRootView.frame) / titleArray.count;
        CGFloat Hbutton = 40;
//            CGFloat Xbutton = i * Wbutton;
        CGFloat Ybutton = CGRectGetHeight(contentRootView.frame) - 40;
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        if (i == 0) {
            button.frame = CGRectMake(0, Ybutton, Wbutton, Hbutton);
            [button setTitleColor:UIColor.blackColor forState:(UIControlStateNormal)];
        } else {
            button.frame = CGRectMake(CGRectGetMaxX(buttonTmp.frame), Ybutton, Wbutton, Hbutton);
            [button setTitleColor:UIColor.redColor forState:(UIControlStateNormal)];
        }
//            button.frame = CGRectMake(Xbutton, Ybutton, Wbutton, Hbutton);
        buttonTmp = button;
        [contentRootView addSubview:button];
        [button setTitle:titleArray[i] forState:(UIControlStateNormal)];
        button.tag = 100+i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    _contentRootView = contentRootView;
}
- (void)buttonClick:(UIButton *)buttonAction {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(alertView:didSelectedOptionButtonWithTag:)]) {
        [self.delegate alertView:self didSelectedOptionButtonWithTag:buttonAction.tag-100];
    }
}

- (void)show {

    UIWindow* window = [[[UIApplication sharedApplication] windows] firstObject];

    _contentRootView.layer.shouldRasterize = YES;
    _contentRootView.layer.rasterizationScale = [[UIScreen mainScreen]scale];

    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [[UIScreen mainScreen]scale];
    
    
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    
    //空矩形 CGRectNull；取两个不相交矩形的相交区域会返回CGRectNull,一个矩形与CGRectNull的并集为原矩形。使用CGRectIsNull判断一个矩形是否为CGRectNull。
    //CGRectIsEmpty对CGRectZero和CGRectNull都返回true;
//    检测矩形是否长度或者宽度为0，或者为null
//    bool CGRectIsEmpty(CGRect rect)
//    检测矩形是否为null
//    bool CGRectIsNull(CGRect rect)
//    检测矩形是否为无穷大
//    bool CGRectIsNull(CGRect rect)
//    CGFloat CGRectGetMinX(CGRect rect) 获取最小的X值
//    CGFloat CGRectGetMidX(CGRect rect) 获取矩形的中心点X值
//    CGFloat CGRectGetMaxX(CGRect rect) 获取矩形的最大X值
//    CGFloat CGRectGetMinY(CGRect rect) 获取最小的Y值
//    CGFloat CGRectGetMidY(CGRect rect) 获取矩形的中心点Y值
//    CGFloat CGRectGetMaxY(CGRect rect) 获取矩形的最大Y值
//    CGFloat CGRectGetWidth(CGRect rect) 获取矩形的宽度值
//    CGFloat CGRectGetHeight(CGRect rect) 获取矩形的高度值

    if (CGRectIsEmpty(self.frame)) {
        self.frame  = self.contentFrame;
    }
    
    
    [window addSubview:self];
    [window bringSubviewToFront:self];
    
    _contentRootView.layer.opacity = 0.5f;
    _contentRootView.layer.transform = CATransform3DMakeScale(1.3, 1.3, 1);
    __weak typeof(self) weakself = self;
    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.04f];
        weakself.contentRootView.layer.opacity = 1.0f;
        weakself.contentRootView.layer.transform = CATransform3DMakeScale(1, 1, 1);
    } completion:^(BOOL finished) {

    }];


//    self.layer.position = self.center;
//    self.transform = CGAffineTransformMakeScale(0.90, 0.90);
//    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
//        self.transform = CGAffineTransformMakeScale(1.0, 1.0);
//    } completion:^(BOOL finished) {
//    }];
    
//       CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//       animation.duration      = 0.05;
//       animation.repeatCount   = 1;
//       animation.fromValue     = @1.75f;
//       animation.toValue       = @1.0f;
//       [animation setRemovedOnCompletion:NO];
//       animation.fillMode = kCAFillModeForwards;
//       [self.layer addAnimation:animation forKey:@"scale-show-layer"];
    //弹簧效果
    //    CASpringAnimation *animation = [CASpringAnimation animationWithKeyPath:@"position"];
    //    animation.beginTime = CACurrentMediaTime() + 1;
    //    animation.damping = 2;
    //    animation.stiffness = 50;
    //    animation.mass = 1;
    //    animation.initialVelocity = 10;
    //    [animation setFromValue:[NSValue valueWithCGPoint:self.layer.position]];
    //    [animation setToValue:[NSValue valueWithCGPoint:CGPointMake(self.layer.position.x, self.layer.position.y + 50)]];
    //    animation.duration = animation.settlingDuration;
    //    [self.layer addAnimation:animation forKey:@"spring"];
    
    //仿弹窗弹簧效果
    //    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    //    animation.duration = 0.1;
    //    animation.removedOnCompletion = NO;
    //    animation.fillMode = kCAFillModeForwards;
    //    animation.timingFunction = [CAMediaTimingFunction functionWithName:@"easeInEaseOut"];
    //    NSMutableArray * values = [NSMutableArray array];
    //    //        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    //    //        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    //    //        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
    //    //        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    //    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    //    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1.0)]];
    //    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    //    animation.values = values;
    //    [self.layer addAnimation:animation forKey:nil];

}

- (void)dismiss {
    
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    [self removeFromSuperview];
}
@end
