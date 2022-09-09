//
//  JDBMProgressHUD.m
//
//
//  Created by ext.zhaoxueli1 on 2022/7/15.
//  Copyright © 2022 刘沛. All rights reserved.
//

#import "DHProgressHUD.h"
#import <Lottie/Lottie.h>

/// 刷新图片宽高(大小)
static CGFloat globalLoadViewW = 40;

static DHProgressHUD *hud;

@interface DHProgressHUD ()

@property (strong, nonatomic) LOTAnimationView *calculateView;

@end

@implementation DHProgressHUD


- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.contentMode = UIViewContentModeCenter;
        self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin
        | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        
        // 获取资源文件路径
        NSBundle *bundlePath1 = [NSBundle bundleForClass:[NSClassFromString(@"DHProgressHUD") class]];
        NSBundle *bundlePath2 = [NSBundle bundleWithPath:[bundlePath1 pathForResource:@"DHProgressHUD" ofType:@"bundle"]];
        
        // 读取图片资源路径
        NSString *normalImgPath1 = [bundlePath2 pathForResource:@"tabBar_publish_click_icon" ofType:@"imageset"];
        NSString *imageName1 = [NSString stringWithFormat:@"%@/tabBar_publish_click_icon.png",normalImgPath1];

        // 读取图片资源路径
        NSString *normalImgPath2 = @"tabBar_publish_click_icon.imageset/tabBar_publish_click_icon.png";
        NSString *imageName2 = [bundlePath2 pathForResource:normalImgPath2 ofType:nil];

        UIImageView *uuu = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName1]];
        [self addSubview:uuu];
        uuu.frame = CGRectMake(10, 10, 100, 100);
        uuu.contentMode = UIViewContentModeScaleAspectFit;
        
        [self creatAnimation];
    }
    return self;
}

- (id)initWithView:(UIView *)view {
    
    NSAssert(view, @"View must not be nil.");
    return [self initWithFrame:view.bounds];
}

- (id)initWithWindow:(UIWindow *)window {
    
    return [self initWithView:window];
}

- (void)creatAnimation {
    
    self.calculateView = [[LOTAnimationView alloc] init];
    self.calculateView.frame = CGRectMake(CGRectGetMidX(self.frame) - globalLoadViewW/2, CGRectGetMidY(self.frame) - globalLoadViewW/2, globalLoadViewW, globalLoadViewW);
    [self.calculateView setContentMode:UIViewContentModeScaleAspectFit];

    NSBundle *curBundle1 = [NSBundle bundleForClass:[NSClassFromString(@"DHProgressHUD") class]];
    NSBundle *fullBundle1 = [NSBundle bundleWithPath:[curBundle1 pathForResource:@"DHProgressHUD" ofType:@"bundle"]];
    
    // 获取文件路径
    NSString *normalImgPath2 = [fullBundle1 pathForResource:@"GlobalLoading" ofType:@"json"];
    // 将文件数据化
    NSData *data = [[NSData alloc] initWithContentsOfFile:normalImgPath2];
        
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    [self.calculateView setAnimationFromJSON:dic inBundle:fullBundle1];
    [self.calculateView setLoopAnimation:YES];
    [self addSubview:self.calculateView];
    [self.calculateView play];
}

+ (void)showHUDAddedTo:(UIView *)view {
    hud = [[DHProgressHUD alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    hud.backgroundColor = [UIColor clearColor];
    hud.center = view.center;
    [view addSubview:hud];
}
/**
 *  hide loadingView
 */
+ (void)hide {
    if (hud) {
        [hud.calculateView stop];
        [hud removeFromSuperview];
    }
}

- (void)show:(BOOL)animated {
    NSAssert([NSThread isMainThread], @"MBProgressHUD needs to be accessed on the main thread.");
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
