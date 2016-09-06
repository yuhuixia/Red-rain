//
//  YHXItemView.h
//  红包雨
//
//  Created by 于慧霞 on 16/9/6.
//  Copyright © 2016年 yuhuixia. All rights reserved.
//

#import <UIKit/UIKit.h>

// view 的点击
typedef void(^AnimationViewClickBlock)(NSInteger tag);// tag= -1时正常走完 没有点击
@interface YHXItemView : UIView




// 图片
@property (nonatomic, strong) UIImageView *imageView1;

// 开始动画 时间
- (void)startAnimationDuration:(CGFloat)duration;

/**  */
@property (nonatomic, copy) AnimationViewClickBlock  clickBlock;
- (void)setClickBlock:(AnimationViewClickBlock)clickBlock;

@end
