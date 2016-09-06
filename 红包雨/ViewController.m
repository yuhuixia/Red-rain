//
//  ViewController.m
//  红包雨
//
//  Created by 于慧霞 on 16/9/6.
//  Copyright © 2016年 yuhuixia. All rights reserved.
//

#import "ViewController.h"
#import "YHXAnimationV.h"

@interface ViewController ()

{
    YHXAnimationV *endView;
    
}

@property (nonatomic, strong) UILabel *countLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)clickBeginAnimation:(id)sender {
    
    
    [endView removeFromSuperview];
    
    endView = [[YHXAnimationV alloc] initWithFrame:[UIScreen mainScreen].bounds];
    endView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"wodebeijn"]];
    
    
    //    endView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    [self.view addSubview:endView];
    
    NSArray *array = @[@"hb",@"snow",@"hb",@"snow",@"snow",@"snow",@"snow",@"snow",@"snow",@"hb",@"hb",@"hb"];
    
    endView.dataArr = array;
    endView.zhongjianArr = @[@(0),@(1),@(2),@(3),@(4),@(5),@(6),@(7)];//假设0 1 2 3 4 5 6 7是有奖的
    [endView animationBegin];
    
    [endView setSucessEndBlock:^(NSArray *seleArr) {
        NSLog(@"%@", seleArr);
        for (NSNumber *num in seleArr) {
            NSLog(@"sele -- %@", num);
        }
    }];
    
    self.countLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 400, 120, 40)];
    self.countLabel.backgroundColor = [UIColor grayColor];
    __weak typeof (self) mySelf = self;
    __block NSInteger nunber = 1;
    [endView setClickCountBlock:^(NSInteger cout) {
        NSLog(@"********%ld", (long)cout);
        
        mySelf.countLabel.text = [NSString stringWithFormat:@"点中个数%ld", (long)nunber];
        nunber++;
    }];
    [self.view addSubview:self.countLabel];
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
