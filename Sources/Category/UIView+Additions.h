//
//  UIView+Additions.h
//  YiYuanYunGou
//
//  Created by 范李林 on 16/9/1.
//  Copyright © 2016年 LC. All rights reserved.
//

#import <UIKit/UIKit.h>
//NS_ASSUME_NONNULL_BEGIN


@interface UIView (Additions)

/*&* 增加梯度渐变颜色*/
- (void)addGradientLayerWithColors:(nullable NSArray *)cgColorArray;
/*&* Same as above*/
- (void)addGradientLayerWithColors:(nonnull NSArray *)cgColorArray locations:(nullable NSArray *)floatNumArray startPoint:(CGPoint )aPoint endPoint:(CGPoint)endPoint;
/*&* 根据TAG removeView*/
- (void)removeViewWithTag:(NSInteger)tag;
/*&* 输出子视图的目录树*/
- (void)outputSubviewTree;
/*&* 输出某个View的subview目录*/
+ (void)outputTreeInView:(nonnull UIView *)view withSeparatorCount:(NSInteger)count;
/*&* 水平居中*/
- (void)alignHorizontal;
/*&* 垂直居中*/
- (void)alignVertical;
/*&* view是否可见*/
- (BOOL)visible;
/*&* 判断是否显示在主窗口上面*/
- (BOOL)isShowOnWindow;
/*&* 设置圆角*/
- (void)setCornerRadius:(CGFloat)cornerRadius;
/**
 *  设置圆角
 *
 *  @param width 边角宽
 *  @param color 边角颜色
 */
- (void)setBorderWidth:(CGFloat)width andColor:(nonnull UIColor *)color;
/*&* 渐显*/
- (void)fadeIn;
/*&* 渐隐*/
- (void)fadeOut;
/*&* 渐显*/
- (void)fadeInOnComplet:(nullable void(^)(BOOL f))complet;
/*&* 渐显 to alpha*/
- (void)fadeInOnAlpha:(CGFloat)alpha complet:(nullable void(^)(BOOL finished))complet;
/*&* 渐隐*/
- (void)fadeOutOnComplet:(nullable void(^)(BOOL f))complet;
/*&* 渐显 to view*/
- (void)fadeInAddView:(nonnull UIView *)view duration:(NSTimeInterval)duration;
/*&* 渐隐 并移除*/
- (void)fadeOutAndRemove;
/*&* 渐隐 并移除*/
- (void)fadeOutAndRemoveOnComplet:(nullable void(^)(BOOL f))complet;

/*&* remove all Subview*/
- (void)removeAllSubviews;
/*&* remove TAG View*/
- (void)removeSubviewWithTag:(NSInteger)tag;
/*&* remove Subview 除了标记tag值外的所有视图*/
- (void)removeSubviewExceptTag:(NSInteger)tag;
- (void)removeSubviewExceptClass:(nonnull Class)class_a;

/*&* 当前视图渲染返回一个真实的iamge（透明的）*/
- (nullable UIImage *)toAlphaRetinaImageRealTime;
- (nullable UIImage *)toRetinaImage;
- (nullable UIImage *)toAlphaRetinaImage;
- (nullable UIImage *)toRetinaImageRealTime;
- (nullable UIImage *)toImageWithRect:(CGRect)frame;
- (nullable UIImage *)toImageWithRect:(CGRect)frame withAlpha:(BOOL)alpha;
- (nullable UIImage *)visbleToImage;

/*&* 添加阴影*/
- (void)addShadowWithColor:(nonnull UIColor *)color;
- (void)addShadow;
- (void)addShadowWithAlpha:(float)alpha;
- (void)removeShadow;
- (nullable UIView *)findAndResignFirstResponder;
/*&* 添加动画  移动*/
- (void)shake:(float)range;
- (void)shakeRepeat:(float)range;
- (void)shakeX:(float)range;
- (void)rasterize;

+ (void)vveboAnimations:(nullable void (^)(void))animations;
+ (void)vveboAnimations:(nullable void (^)(void))animations completion:(nullable void (^)(BOOL finished))completion;
+ (void)vveboAnimateWithDuration:(NSTimeInterval)duration animations:(nullable void (^)(void))animations;
+ (void)vveboAnimateWithDuration:(NSTimeInterval)duration animations:(nullable void (^)(void))animations completion:(nullable void (^)(BOOL finished))completion;
+ (void)vveboAnimateWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay animations:(nullable void (^)(void))animations completion:(nullable void (^)(BOOL finished))completion;
+ (void)vveboAnimateWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(UIViewAnimationOptions)options animations:(nullable void (^)(void))animations completion:(nullable void (^)(BOOL finished))completion;

- (nullable UIView *)subviewWithTag:(NSInteger)tag;
/*&* 创建一个快照*/
- (nullable UIImage *)snapshotImage;
/**
 Create a snapshot PDF of the complete view hierarchy.
 This method should be called in main thread.
 */
- (nullable NSData *)snapshotPDF;
/**
 Shortcut to set the view.layer's shadow
 
 @param color  Shadow Color
 @param offset Shadow offset
 @param radius Shadow radius
 */
- (void)setLayerShadow:(nonnull UIColor*)color offset:(CGSize)offset radius:(CGFloat)radius;
/**
 *  将接收一个点的坐标系统指定的视图或窗口
 *
 *  @param point 指定的视图point
 *  @param view  视图或者窗口的坐标转换。如果视图是nil,这种方法不是转换窗口基础坐标
 *
 *  @return 转换为指定视图的坐标
 */
- (CGPoint)convertPoint:(CGPoint)point toViewOrWindow:(nullable UIView *)view;
/**
 *  <#Description#>
 *
 *  @param point 指定的视图point
 *  @param view  视图或者窗口。如果视图是nil,这个方法不是从窗口基础坐标转换
 *
 *  @return 点转换为self的坐标系(
 */
- (CGPoint)convertPoint:(CGPoint)point fromViewOrWindow:(nullable UIView *)view;
/**
 Converts a rectangle from the receiver's coordinate system to that of another view or window.
 
 @param rect A rectangle specified in the local coordinate system (bounds) of the receiver.
 @param view The view or window that is the target of the conversion operation. If view is nil, this method instead converts to window base coordinates.
 @return The converted rectangle.
 */
- (CGRect)convertRect:(CGRect)rect toViewOrWindow:(nullable UIView *)view;

/**
 Converts a rectangle from the coordinate system of another view or window to that of the receiver.
 
 @param rect A rectangle specified in the local coordinate system (bounds) of view.
 @param view The view or window with rect in its coordinate system.
 If view is nil, this method instead converts from window base coordinates.
 @return The converted rectangle.
 */
- (CGRect)convertRect:(CGRect)rect fromViewOrWindow:(nullable UIView *)view;
/**
 *  返回响应者链上的任意Objc
 *
 *  @param viewControllerCls 需要返回的Obj的类名,为nil时默认返回当前控制器
 *
 *  @return viewController Or needCls
 */
- (nonnull id)viewControllerWithNeedViewOrViewController:(nullable Class)viewControllerCls;

/*&* 移除所有子视图中 tableview、scrollview 的 delegate、datasource*/
- (void)clearScrollViewDelegate;
/*&* 移除self 的所有手势*/
- (void)removeAllGestures;
/*&* self SubView 的所有手势*/
- (void)removeAllGesturesWithSubViews;
/*&* 在 block 内禁用动画*/
+ (void)disableAnimationWithBlock:(nullable void (^)(void))block;
//NS_ASSUME_NONNULL_END

@end




@interface UIView (Frame)
/*&* frame-x*/
@property (nonatomic, assign) CGFloat  x;
/*&* frame-y*/
@property (nonatomic, assign) CGFloat  y;
/*&* frame-width*/
@property (nonatomic, assign) CGFloat  width;
/*&* frame-height*/
@property (nonatomic, assign) CGFloat  height;
/*&* frame-origin*/
@property (nonatomic, assign) CGPoint  origin;
/*&* frame-centerX*/
@property (nonatomic, assign) CGFloat  centerX;
/*&* frame-centerY*/
@property (nonatomic, assign) CGFloat  centerY;
/*&* frame-size*/
@property (nonatomic, assign) CGSize size;
/*&* frame*/
- (CGFloat)maxXOfFrame;
/*&* Shortcut for frame.origin.x*/
@property (nonatomic) CGFloat left;
/*&* Shortcut for frame.origin.y*/
@property (nonatomic) CGFloat top;
/*&* Shortcut for frame.origin.x + frame.size.width*/
@property (nonatomic) CGFloat right;
/*&* < Shortcut for frame.origin.y + frame.size.height*/
@property (nonatomic) CGFloat bottom;

@end
