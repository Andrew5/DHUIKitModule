//
//  DHActionLinkLabel.h
//  Pods
//
//  Created by rilakkuma on 2022/9/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DHActionLinkLabel : UILabel

@property (nonatomic, weak) NSObject    *delegate;
@property (nonatomic, assign) SEL       didTouch;
@property (nonatomic, assign) BOOL      changeAlpha;
@property (nonatomic, assign) int       line;
@property (nonatomic, assign) BOOL      isAction;

- (void)liaoya_getUserFollowSuccess;
@end

NS_ASSUME_NONNULL_END
