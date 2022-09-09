//
//  DHActionLinkLabel.m
//  Pods
//
//  Created by rilakkuma on 2022/9/8.
//

#import "DHActionLinkLabel.h"

@implementation DHActionLinkLabel

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.changeAlpha = NO;
        self.line = 0;
        self.isAction = NO;
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if(self.changeAlpha)
        self.alpha = 0.5;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesMoved: touches withEvent: event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if(self.changeAlpha)
        self.alpha = 1;
    if (self.isAction) {
        return;
    }
    self.isAction = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.isAction = NO;
    });
    BOOL inside = YES;
    for(int i=0;i<[touches count];i++){
        CGPoint p = [[[touches allObjects] objectAtIndex:i] locationInView:self];
        if(p.x<0 || p.y <0){
            inside = NO;
            break;
        }
        if(p.x>self.frame.size.width || p.y>self.frame.size.height){
            inside = NO;
            break;
        }
    }
    if(!inside)
        return;
    if(self.delegate != nil && [self.delegate respondsToSelector:self.didTouch])
        [self.delegate performSelectorOnMainThread:self.didTouch withObject:self waitUntilDone:NO];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    if(self.changeAlpha)
        self.alpha = 1;
}

- (void)dealloc {
    self.delegate = nil;
    self.didTouch = nil;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    if(self.line>0){
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGSize fontSize = [self.text boundingRectWithSize:CGSizeMake(self.bounds.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil].size;
        const CGFloat * colors = CGColorGetComponents(self.textColor.CGColor);
        CGContextSetRGBStrokeColor(ctx, colors[0], colors[1], colors[2], self.line);
        [self.textColor set];
        CGContextSetLineWidth(ctx, self.line);
        CGPoint l,r;
        if (self.textAlignment == NSTextAlignmentLeft) {
            l = CGPointMake(0, self.frame.size.height/2.0 +fontSize.height/2.0);
            r = CGPointMake(fontSize.width/2.0, self.frame.size.height/2.0 + fontSize.height/2.0);
        }else if (self.textAlignment == NSTextAlignmentRight) {
            l = CGPointMake(self.frame.size.width - fontSize.width,
                            self.frame.size.height/2.0 +fontSize.height/2.0);
            r = CGPointMake(self.frame.size.width,
                            self.frame.size.height/2.0 + fontSize.height/2.0);
        }else if (self.textAlignment == NSTextAlignmentCenter) {
            l = CGPointMake(self.frame.size.width/2.0 - fontSize.width/2.0,
                            self.frame.size.height/2.0 + fontSize.height/2.0);
            r = CGPointMake(self.frame.size.width/2.0 + fontSize.width/2.0,
                            self.frame.size.height/2.0 + fontSize.height/2.0);
        }
        CGContextMoveToPoint(ctx, l.x, l.y);
        CGContextAddLineToPoint(ctx, r.x, r.y);
        CGContextStrokePath(ctx);
    }
}

- (void)setDidTouch:(SEL)value{
    if(value){
        self.didTouch = value;
        self.changeAlpha = YES;
        self.userInteractionEnabled = YES;
    }
}

- (void)liaoya_getUserFollowSuccess {
    NSLog(@"Get Info Failed");
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
