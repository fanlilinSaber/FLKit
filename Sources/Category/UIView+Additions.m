//
//  UIView+Additions.m
//  YiYuanYunGou
//
//  Created by 范李林 on 16/9/1.
//  Copyright © 2016年 LC. All rights reserved.
//

#import "UIView+Additions.h"
#import <QuartzCore/QuartzCore.h>
@implementation UIView (Additions)

- (void)addGradientLayerWithColors:(NSArray *)cgColorArray{
    [self addGradientLayerWithColors:cgColorArray locations:nil startPoint:CGPointMake(0.0, 0.5) endPoint:CGPointMake(1.0, 0.5)];
}

- (void)addGradientLayerWithColors:(NSArray *)cgColorArray locations:(NSArray *)floatNumArray startPoint:(CGPoint )startPoint endPoint:(CGPoint)endPoint{
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = self.bounds;
    if (cgColorArray && [cgColorArray count] > 0) {
        layer.colors = cgColorArray;
    }else{
        return;
    }
    if (floatNumArray && [floatNumArray count] == [cgColorArray count]) {
        layer.locations = floatNumArray;
    }
    layer.startPoint = startPoint;
    layer.endPoint = endPoint;
    [self.layer addSublayer:layer];
}

- (void)removeViewWithTag:(NSInteger)tag{
    for (UIView *aView in [self subviews]) {
        if (aView.tag == tag) {
            [aView removeFromSuperview];
        }
    }
}

- (void)outputSubviewTree{
    [UIView outputTreeInView:self withSeparatorCount:0];
}

+ (void)outputTreeInView:(UIView *)view withSeparatorCount:(NSInteger)count{
    NSString *outputStr = @"";
    outputStr = [outputStr stringByReplacingCharactersInRange:NSMakeRange(0, count) withString:@"-"];
    outputStr = [outputStr stringByAppendingString:view.description];
    printf("%s\n", outputStr.UTF8String);
    
    if (view.subviews.count == 0) {
        return;
    }else{
        count++;
        for (UIView *subV in view.subviews) {
            [self outputTreeInView:subV withSeparatorCount:count];
        }
    }
}

- (void)alignHorizontal{
    
    self.x = (self.superview.width - self.width) * 0.5;
}

- (void)alignVertical{
    self.y = (self.superview.height - self.height) *0.5;
}

- (BOOL)visible{
    return !self.hidden;
}
- (BOOL)isShowOnWindow{
    //主窗口
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    //相对于父控件转换之后的rect
    CGRect newRect = [keyWindow convertRect:self.frame fromView:self.superview];
    //主窗口的bounds
    CGRect winBounds = keyWindow.bounds;
    //判断两个坐标系是否有交汇的地方，返回bool值
    BOOL isIntersects =  CGRectIntersectsRect(newRect, winBounds);
    if (self.hidden != YES && self.alpha >0.01 && self.window == keyWindow && isIntersects) {
        return YES;
    }else{
        return NO;
    }
}
- (void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}

- (void)fadeIn{
    [self fadeInOnComplet:nil];
}

- (void)fadeOut{
    [self fadeOutOnComplet:nil];
}

- (void)setBorderWidth:(CGFloat)width andColor:(UIColor *)color
{
    self.layer.borderWidth = width;
    self.layer.borderColor = color.CGColor;
}

- (void)fadeInOnComplet:(void(^)(BOOL finished))complet{
//    self.alpha = 0;
    [UIView animateWithDuration:.28 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.alpha = 1;
    } completion:complet];
}

- (void)fadeInOnAlpha:(CGFloat)alpha complet:(void(^)(BOOL finished))complet{
    [UIView animateWithDuration:.28 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.alpha = alpha;
    } completion:complet];
    if ([UIView areAnimationsEnabled]) {
        [UIView setAnimationsEnabled:YES];
    }
}

- (void)fadeOutOnComplet:(void(^)(BOOL finished))complet{
    [UIView animateWithDuration:.28 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.alpha = 0;
    } completion:complet];
    if ([UIView areAnimationsEnabled]) {
        [UIView setAnimationsEnabled:YES];
    }
}

- (void)fadeInAddView:(nonnull UIView *)view duration:(NSTimeInterval)duration{
    self.alpha = 0;
    [view addSubview:self];
    [UIView animateWithDuration:duration animations: ^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        self.alpha = 1;
    } completion: ^(BOOL finished) {
        if (finished) {
        }
    }];
}

- (void)fadeOutAndRemove{
    [UIView animateWithDuration:0.35f animations: ^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        self.alpha = 0;
    } completion: ^(BOOL finished) {
        if (finished) {
            [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            [self removeFromSuperview];
        }
    }];
}

- (void)fadeOutAndRemoveOnComplet:(void(^)(BOOL f))complet{
    [UIView animateWithDuration:0.35f animations: ^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        self.alpha = 0;
    } completion: ^(BOOL finished) {
        if (finished) {
            [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            [self removeFromSuperview];
            complet(finished);
        }
    }];
}

- (void)removeAllSubviews{
    for (UIView *temp in self.subviews) {
        [temp removeFromSuperview];
    }
}

- (void)removeSubviewWithTag:(NSInteger)tag{
    for (UIView *temp in self.subviews) {
        if (temp.tag==tag) {
            [temp removeFromSuperview];
        }
    }
}

- (void)removeSubviewExceptTag:(NSInteger)tag{
    for (UIView *temp in self.subviews) {
        if (temp.tag!=tag) {
            if ([temp isKindOfClass:[UIImageView class]]) {
                [(UIImageView *)temp setImage:nil];
            }
            [temp removeFromSuperview];
        }
    }
}

- (void)removeSubviewExceptClass:(Class)class_a{
    for (UIView *temp in self.subviews) {
        if (![temp isKindOfClass:class_a]) {
            [temp removeFromSuperview];
        }
    }
}

- (UIImage *)toAlphaRetinaImageRealTime{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *screenShotimage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenShotimage;
}

- (UIImage *)toRetinaImage{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 0);
    [self drawViewHierarchyInRect:self.bounds
               afterScreenUpdates:NO];
    UIImage *screenShotimage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenShotimage;
}

- (UIImage *)toAlphaRetinaImage{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0);
    [self drawViewHierarchyInRect:self.bounds
               afterScreenUpdates:NO];
    UIImage *screenShotimage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenShotimage;
}



- (UIImage *)toRetinaImageRealTime{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *screenShotimage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenShotimage;
}


- (UIImage *)toImageWithRect:(CGRect)frame{
    return [self toImageWithRect:frame withAlpha:NO];
}

- (UIImage *)toImageWithRect:(CGRect)frame withAlpha:(BOOL)alpha{
    UIGraphicsBeginImageContextWithOptions(frame.size, !alpha, 1);//这里通过设置scale为1来截取{[UIScreen screenWidth], 49}大小的图,而不是在retina下截取2x大小的图
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextConcatCTM(context, CGAffineTransformMakeTranslation(-frame.origin.x, -frame.origin.y));
    [self.layer renderInContext:context];
    UIImage *screenShot1 = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenShot1;
}

- (UIImage *)visbleToImage{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if ([self isKindOfClass:[UIScrollView class]]) {
        CGPoint offset=[(UIScrollView *)self contentOffset];
        CGContextTranslateCTM(context, -offset.x, -offset.y);
    }
    [self.layer renderInContext:context];
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    UIImage *visibleScrollViewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return visibleScrollViewImage;
}


- (void)addShadowWithColor:(UIColor *)color{
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 5, self.bounds.size.width, self.bounds.size.height)];
    [self.layer setShadowColor:color.CGColor];
    [self.layer setShadowOpacity:1];
    [self.layer setShadowRadius:10.0f];
    [self.layer setShadowPath:[path CGPath]];
}

- (void)addShadowWithAlpha:(float)alpha{
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 5, self.bounds.size.width, self.bounds.size.height)];
    [self.layer setShadowColor:[UIColor grayColor].CGColor];
    [self.layer setShadowOpacity:alpha];
    [self.layer setShadowRadius:10.0f];
    [self.layer setShadowPath:[path CGPath]];
}

- (void)addShadow{
    [self addShadowWithAlpha:1];
}

- (void)removeShadow{
    self.layer.shadowOpacity = 0;
    self.layer.shadowRadius = 0;
}

- (UIView *)findAndResignFirstResponder{
    if (self.isFirstResponder) {
        return self;
    }
    for (UIView *subView in self.subviews) {
        UIView *temp = [subView findAndResignFirstResponder];
        if (temp!=nil) {
            return temp;
        }
    }
    return nil;
}

- (void)shake:(float)range{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.duration = 0.5;
    animation.values = @[ @(-range), @(range), @(-range/2), @(range/2), @(-range/5), @(range/5), @(0) ];
    [self.layer addAnimation:animation forKey:@"shake"];
}

- (void)shakeRepeat:(float)range{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.duration = 0.6;
    animation.values = @[ @(-range), @(range), @(-range/2), @(range/2), @(-range/5), @(range/5), @(0) ];
    animation.repeatCount = NSIntegerMax;
    [self.layer addAnimation:animation forKey:@"shake"];
}

- (void)shakeX:(float)range{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.duration = 0.6;
    animation.values = @[ @(-range), @(range), @(-range/2), @(range/2), @(-range/5), @(range/5), @(0) ];
    [self.layer addAnimation:animation forKey:@"shake"];
}

- (void)rasterize{
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [[UIScreen mainScreen] scale];
    
}

+ (void)vveboAnimations:(void (^)(void))animations{
    [UIView vveboAnimateWithDuration:.18 delay:0 animations:animations completion:nil];
}

+ (void)vveboAnimations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion{
    [UIView vveboAnimateWithDuration:.18 delay:0 animations:animations completion:completion];
}

+ (void)vveboAnimateWithDuration:(NSTimeInterval)duration animations:(void (^)(void))animations{
    [UIView vveboAnimateWithDuration:duration delay:0 animations:animations completion:nil];
}

+ (void)vveboAnimateWithDuration:(NSTimeInterval)duration animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion{
    [UIView vveboAnimateWithDuration:duration delay:0 animations:animations completion:completion];
}

+ (void)vveboAnimateWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion{
    [UIView vveboAnimateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveLinear animations:animations completion:completion];
}

+ (void)vveboAnimateWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(UIViewAnimationOptions)options animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion{
    if (![UIView areAnimationsEnabled]) {
        [UIView setAnimationsEnabled:YES];
    }
    [UIView animateWithDuration:duration delay:delay options:options animations:animations completion:completion];
}

- (UIView *)subviewWithTag:(NSInteger)tag{
    for (UIView *temp in self.subviews) {
        if (temp.tag==tag) {
            return temp;
        }
    }
    return nil;
}

- (UIImage *)snapshotImage {
    UIImage *image = nil;
    if ([self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 0);
        [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }else{
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0);
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
    }
    return image;
}

- (NSData *)snapshotPDF {
    CGRect bounds = self.bounds;
    NSMutableData* data = [NSMutableData data];
    CGDataConsumerRef consumer = CGDataConsumerCreateWithCFData((__bridge CFMutableDataRef)data);
    CGContextRef context = CGPDFContextCreate(consumer, &bounds, NULL);
    CGDataConsumerRelease(consumer);
    if (!context) return nil;
    CGPDFContextBeginPage(context, NULL);
    CGContextTranslateCTM(context, 0, bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    [self.layer renderInContext:context];
    CGPDFContextEndPage(context);
    CGPDFContextClose(context);
    CGContextRelease(context);
    return data;
}

- (void)setLayerShadow:(UIColor*)color offset:(CGSize)offset radius:(CGFloat)radius {
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowRadius = radius;
    self.layer.shadowOpacity = 1;
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

- (CGPoint)convertPoint:(CGPoint)point toViewOrWindow:(UIView *)view {
    if (!view) {
        if ([self isKindOfClass:[UIWindow class]]) {
            return [((UIWindow *)self) convertPoint:point toWindow:nil];
        } else {
            return [self convertPoint:point toView:nil];
        }
    }
    
    UIWindow *from = [self isKindOfClass:[UIWindow class]] ? (id)self : self.window;
    UIWindow *to = [view isKindOfClass:[UIWindow class]] ? (id)view : view.window;
    if ((!from || !to) || (from == to)) return [self convertPoint:point toView:view];
    point = [self convertPoint:point toView:from];
    point = [to convertPoint:point fromWindow:from];
    point = [view convertPoint:point fromView:to];
    return point;
}

- (CGPoint)convertPoint:(CGPoint)point fromViewOrWindow:(UIView *)view {
    if (!view) {
        if ([self isKindOfClass:[UIWindow class]]) {
            return [((UIWindow *)self) convertPoint:point fromWindow:nil];
        } else {
            return [self convertPoint:point fromView:nil];
        }
    }
    
    UIWindow *from = [view isKindOfClass:[UIWindow class]] ? (id)view : view.window;
    UIWindow *to = [self isKindOfClass:[UIWindow class]] ? (id)self : self.window;
    if ((!from || !to) || (from == to)) return [self convertPoint:point fromView:view];
    point = [from convertPoint:point fromView:view];
    point = [to convertPoint:point fromWindow:from];
    point = [self convertPoint:point fromView:to];
    return point;
}

- (CGRect)convertRect:(CGRect)rect toViewOrWindow:(UIView *)view {
    if (!view) {
        if ([self isKindOfClass:[UIWindow class]]) {
            return [((UIWindow *)self) convertRect:rect toWindow:nil];
        } else {
            return [self convertRect:rect toView:nil];
        }
    }
    
    UIWindow *from = [self isKindOfClass:[UIWindow class]] ? (id)self : self.window;
    UIWindow *to = [view isKindOfClass:[UIWindow class]] ? (id)view : view.window;
    if (!from || !to) return [self convertRect:rect toView:view];
    if (from == to) return [self convertRect:rect toView:view];
    rect = [self convertRect:rect toView:from];
    rect = [to convertRect:rect fromWindow:from];
    rect = [view convertRect:rect fromView:to];
    return rect;
}

- (CGRect)convertRect:(CGRect)rect fromViewOrWindow:(UIView *)view {
    if (!view) {
        if ([self isKindOfClass:[UIWindow class]]) {
            return [((UIWindow *)self) convertRect:rect fromWindow:nil];
        } else {
            return [self convertRect:rect fromView:nil];
        }
    }
    
    UIWindow *from = [view isKindOfClass:[UIWindow class]] ? (id)view : view.window;
    UIWindow *to = [self isKindOfClass:[UIWindow class]] ? (id)self : self.window;
    if ((!from || !to) || (from == to)) return [self convertRect:rect fromView:view];
    rect = [from convertRect:rect fromView:view];
    rect = [to convertRect:rect fromWindow:from];
    rect = [self convertRect:rect fromView:to];
    return rect;
}

- (nonnull id)viewControllerWithNeedViewOrViewController:(nullable Class)viewControllerCls
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = self;
    id nextResponse = [frontView nextResponder];
    Class cls = viewControllerCls?viewControllerCls:UIViewController.class;
    while (nextResponse) {
        if ([nextResponse isKindOfClass:cls]) {
            result = nextResponse;
            break;
        }
        nextResponse = [nextResponse nextResponder];
    }
    if(!result) result = window.rootViewController;
    
    return result;
}

- (void)clearScrollViewDelegate {
    if ([self isKindOfClass:[UIScrollView class]]) {
        ((UIScrollView *)self).delegate = nil;
        if ([self isKindOfClass:[UITableView class]]) {
            ((UITableView *)self).delegate = nil;
        }
    }
    for (UIView *sub in self.subviews) {
        [sub clearScrollViewDelegate];
    }
}

- (void)removeAllGestures {
    NSArray *gs = [self.gestureRecognizers copy];
    for (UIGestureRecognizer *g in gs) {
        [self removeGestureRecognizer:g];
    }
}

- (void)removeAllGesturesWithSubViews {
    [self removeAllGestures];
    for (UIView *v in self.subviews) {
        [v removeAllGesturesWithSubViews];
    }
    [UIView animateWithDuration:0 animations:^{
        
    }];
}

+ (void)disableAnimationWithBlock:(nullable void (^)(void))block {
    if (!block) return;
    BOOL aniEnabled = [CATransaction disableActions];
    [CATransaction setDisableActions:YES];
    block();
    [CATransaction setDisableActions:aniEnabled];
}
@end













@implementation UIView (Frame)

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (CGFloat)maxXOfFrame{
    return CGRectGetMaxX(self.frame);
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}
- (void)setSize:(CGSize)size {

    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}


@end
