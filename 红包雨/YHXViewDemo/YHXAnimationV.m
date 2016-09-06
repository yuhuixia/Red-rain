//
//  YHXAnimationV.m
//  红包雨
//
//  Created by 于慧霞 on 16/9/6.
//  Copyright © 2016年 yuhuixia. All rights reserved.
//

#import "YHXAnimationV.h"
#import "YHXItemView.h"

#define KSCReenWidth  [UIScreen mainScreen].bounds.size.width
#define KSCReenHeight  [UIScreen mainScreen].bounds.size.height

@interface YHXAnimationV ()

//@property (nonatomic, strong) NSArray *selectArray;
@property (nonatomic, assign) BOOL canRemove;// 是否能移除,默认不能移除 当所有动画结束的时候点击 view 就移除
@end
@implementation YHXAnimationV

- (void)animationBegin
{
    
    if (!self.dataArr || self.dataArr.count == 0) {
        return;
    }
    _canRemove = NO;
    // 总时间
    CGFloat totalTime = self.duration ? self.duration : 3;
    // 飘下来多少个
    NSInteger count = self.dataArr.count;
    // 几秒钟飘下来一个
    CGFloat itemTime = totalTime / count;
    
    // 每个小 view 下落的时间
    CGFloat itemDur = self.itemDuration ? self.itemDuration : 1.5;
    // 宽高等属性
    CGFloat itemW = 50;
    CGFloat itemH = 50;
    CGFloat y = 0- itemH;
    CGFloat x;
    __block NSInteger theCount  = 0;//记录走过了多少个红包.当 theCount =self.dataArr.count时,证明动画完成
    NSMutableArray *array = [NSMutableArray array];// 点中 && 中奖
    for (int i = 0; i < count; i++) {
        // x 从 一半宽度 到 (屏幕宽度 - 宽度 - 一半宽度)
        //        NSInteger fromX = (NSInteger)itemW / 2;
        //        NSInteger toX = (NSInteger)(KSCReenWidth - itemW * 1.5);
        NSInteger fromX = 0;
        NSInteger toX = (NSInteger)(KSCReenWidth - itemW);
        // 随机出来的 x
        x = arc4random() % (toX - fromX) + fromX;
        YHXItemView *snowView = [[YHXItemView alloc] initWithFrame:CGRectMake(x, y, itemW, itemH)];
        
        //        snowView.imageView1.image = [UIImage imageNamed:self.dataArr[i]];
        
        [snowView setClickBlock:^(NSInteger tag) {
            
            for (NSNumber *num in self.zhongjianArr) {
                if ([num integerValue] == tag) {//判断点击的是不是 有奖 并回调出去
                    [array addObject:num];
                    if (self.clickCountBlock) {
                        self.clickCountBlock(tag);
                    }
                }
            }
            theCount ++;
            if (theCount == count) {
                if (self.sucessEndBlock) {
                    self.sucessEndBlock(array);
                    _canRemove = YES;
                }
            }
        }];
        snowView.tag = i;
        [self addSubview:snowView];
        
        if (i == 0) {//第一个不延迟
            [snowView startAnimationDuration:itemDur];
        }else{// 否则每个 view 有一定的间隔飘下来
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(itemTime *i * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [snowView startAnimationDuration:itemDur];
            });
        }
        
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (_canRemove == YES) {
        [self removeFromSuperview];
    }
}


@end
