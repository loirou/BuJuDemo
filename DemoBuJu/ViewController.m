//
//  ViewController.m
//  DemoBuJu
//
//  Created by 刘东 on 15/7/27.
//  Copyright (c) 2015年 刘东. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self demo1];
    //[self demo2];
    //[self demo3];
    //[self demo4];
    //[self demo5];
    //[self demo6];
    //[self demo7];
}


-(void)demo1{
    
    UIView *sv = [UIView new];
    //在做autoLayout之前 一定要先将view添加到superview上 否则会报错
    
    sv.backgroundColor=[UIColor yellowColor];
    
    [self.view addSubview:sv];
    
    //mas_makeConstraints就是Masonry的autolayout添加函数 将所需的约束添加到block中行了
    
    [sv mas_makeConstraints:^(MASConstraintMaker *make) {
        
        //将sv居中(很容易理解吧?)
        
        make.center.equalTo(self.view);
        
        //将size设置成(300,300)
        
        make.size.mas_equalTo(CGSizeMake(300, 300));
        
    }];
    
    UIView *sv1 = [UIView new];
    
    sv1.backgroundColor = [UIColor redColor];
    
    [sv addSubview:sv1];
    
    [sv1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(sv).with.insets(UIEdgeInsetsMake(10, 10, 10, 10));
        
    }];
    
    
    
    UIView *sv2 = [UIView new];
    
    UIView *sv3 = [UIView new];
    
    sv2.backgroundColor = [UIColor greenColor];
    
    sv3.backgroundColor = [UIColor blueColor];
    
    [sv addSubview:sv2];
    
    [sv addSubview:sv3];
    
    int padding1 = 10;
    
    [sv2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.mas_equalTo(sv.mas_centerY);
        
        make.left.equalTo(sv.mas_left).with.offset(padding1);
        
        make.right.equalTo(sv3.mas_left).with.offset(-padding1);
        
        make.height.mas_equalTo(@150);
        
        make.width.equalTo(sv3);
        
    }];
    
    [sv3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.mas_equalTo(sv.mas_centerY);
        
        make.left.equalTo(sv2.mas_right).with.offset(padding1);
        
        make.right.equalTo(sv.mas_right).with.offset(-padding1);
        
        make.height.mas_equalTo(@150);
        
        make.width.equalTo(sv2);
        
    }];
}
-(void)demo2{
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor lightGrayColor];
    label.textColor = [UIColor whiteColor];
    label.text = @"纯代码自动布局";
    /* 要实现自动布局，必须把该属性设置为NO */
    label.translatesAutoresizingMaskIntoConstraints = NO;
    /* 添加约束条件前一定要先将控件添加到superView上 */
    [self.view addSubview:label];
    /* 水平方向约束条件 */
    NSArray *constraints1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[label]-|"
                                                                    options:0
                                                                    metrics:@{@"margin":@60}
                                                                      views:NSDictionaryOfVariableBindings(label)];
    /* 垂直方向约束条件 */
    NSArray *constraints2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-60-[label(==30)]|"
                                                                    options:0
                                                                    metrics:@{@"heigth":@40}
                                                                      views:NSDictionaryOfVariableBindings(label)];
    [self.view addConstraints:constraints1];
    [self.view addConstraints:constraints2];
}
-(void)demo3{
    __weak typeof(self) weakSelf = self;
    
    UIView * tempView = [[UIView alloc]init];
    NSInteger count = 10;//设置一排view的个数
    NSInteger margin = 10;//设置相隔距离
    NSInteger height = 50;//设置view的高度
    for (int i = 0; i < count; i ++) {
        UIView * view = [[UIView alloc]init];
        view.backgroundColor = [UIColor brownColor];
        [self.view addSubview:view];
        if (i == 0) {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(weakSelf.view).offset(margin);
                make.centerY.equalTo(weakSelf.view);
                make.height.mas_equalTo(height);
            }];
        }
        else if (i == count-1){
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(weakSelf.view).offset(-margin);
                make.left.equalTo(tempView.mas_right).offset(margin);
                make.centerY.equalTo(tempView);
                make.height.equalTo(tempView);
                make.width.equalTo(tempView);
            }];
        }
        else{
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(tempView.mas_right).offset(margin);
                make.centerY.equalTo(tempView);
                make.height.equalTo(tempView);
                make.width.equalTo(tempView);
            }];
        }
        tempView = view;
        [view layoutIfNeeded];
    }
}

-(void)demo4{
    UIView *superview = self.view;
    
    UIView *view1 = [[UIView alloc] init];
    view1.translatesAutoresizingMaskIntoConstraints = NO;
    view1.backgroundColor = [UIColor greenColor];
    [superview addSubview:view1];
    UIEdgeInsets padding = UIEdgeInsetsMake(10, 10, 10, 10);
    
    //    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.equalTo(superview.mas_top).with.offset(padding.top); //with is an optional semantic filler
    //        make.left.equalTo(superview.mas_left).with.offset(padding.left);
    //        make.bottom.equalTo(superview.mas_bottom).with.offset(-padding.bottom);
    //        make.right.equalTo(superview.mas_right).with.offset(-padding.right);
    //    }];
    
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(superview).with.insets(padding);
    }];
    
}

-(void)demo5{
    
    //居中显示视图
    UIView *myView = [[UIView alloc] init];
    myView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:myView];
    
    [myView mas_makeConstraints:^(MASConstraintMaker *make) {
        // 设置当前center和父视图的center一样
        make.center.mas_equalTo(self.view);
        // 设置当前视图的大小
        make.size.mas_equalTo(CGSizeMake(300, 300));
    }];
    
#if 0
    //设置视图并排
    UIView *view1 = [[UIView alloc] init];
    view1.backgroundColor = [UIColor redColor];
    [myView addSubview:view1];
    
    UIView *view2 = [[UIView alloc] init];
    view2.backgroundColor = [UIColor yellowColor];
    [myView addSubview:view2];
    
    
    int padding = 10;
    
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        // 设置其位于父视图的Y的中心位置
        make.centerY.mas_equalTo(myView.mas_centerY);
        // 设置其左侧和父视图偏移10个像素
        make.left.equalTo(myView).with.offset(padding);
        // 设置其右侧和view2偏移10个像素
        make.right.equalTo(view2.mas_left).with.offset(-padding);
        // 设置高度
        make.height.mas_equalTo(@120);
        // 设置其宽度
        make.width.equalTo(view2);
    }];
    
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        // 设置其位于父视图的Y的中心位置
        make.centerY.mas_equalTo(myView.mas_centerY);
        // 设置其左侧和View1偏移10个像素
        make.left.equalTo(view1.mas_right).with.offset(padding);
        // 设置其右侧和父视图偏移10个像素
        make.right.equalTo(myView).with.offset(-padding);
        // 与view1等高
        make.height.mas_equalTo(view1);
        // 与view1等宽
        make.width.equalTo(view1);
    }];
    
#else
    //多个视图间隔相同
    UIView *view1 = [[UIView alloc] init];
    view1.backgroundColor = [UIColor redColor];
    [myView addSubview:view1];
    
    UIView *view2 = [[UIView alloc] init];
    view2.backgroundColor = [UIColor yellowColor];
    [myView addSubview:view2];
    
    UIView *view3 = [[UIView alloc] init];
    view3.backgroundColor = [UIColor greenColor];
    [self.view addSubview:view3];
    
    
    int padding = 10;
    
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        // 设置中心点
        make.centerY.mas_equalTo(myView);
        // 设置左侧距离父视图10
        make.left.equalTo(myView).with.offset(padding);
        // 设置右侧距离和view2的左侧相隔10
        make.right.equalTo(view2.mas_left).with.offset(-padding);
        // 设置高度
        make.height.mas_equalTo(@150);
        // 宽度设置和view2以及view3相同
        make.width.equalTo(@[view2, view3]);
    }];
    
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(myView);
        make.height.mas_equalTo(view1);
        make.width.equalTo(@[view1, view3]);
    }];
    
    [view3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(myView);
        make.left.equalTo(view2.mas_right).with.offset(padding);
        make.right.equalTo(myView).with.offset(-padding);
        make.height.mas_equalTo(view1);
        make.width.equalTo(@[view2, view1]);
    }];
    
#endif
    
    
}

-(void)demo6{
    //居中显示一个view
    UIView *sv = [UIView new];
    //[sv showPlaceHolder];
    sv.backgroundColor = [UIColor blackColor];
    [self.view addSubview:sv];
    [sv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(300, 300));
    }];

    
    //让一个view略小于其superView(边距为10)
    UIView *sv1 = [UIView new];
    //[sv1 showPlaceHolder];
    sv1.backgroundColor = [UIColor redColor];
    [sv addSubview:sv1];
    [sv1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(sv).with.insets(UIEdgeInsetsMake(10, 10, 10, 10));
        
        /* 等价于
         make.top.equalTo(sv).with.offset(10);
         make.left.equalTo(sv).with.offset(10);
         make.bottom.equalTo(sv).with.offset(-10);
         make.right.equalTo(sv).with.offset(-10);
         */
        
        /* 也等价于
         make.top.left.bottom.and.right.equalTo(sv).with.insets(UIEdgeInsetsMake(10, 10, 10, 10));
         */
    }];
}

-(void)demo7{
    
    
    UIView *sv = [UIView new];
    //[sv showPlaceHolder];
    sv.backgroundColor = [UIColor blackColor];
    [self.view addSubview:sv];
    [sv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(300, 300));
    }];

    
    UIScrollView *scrollView = [UIScrollView new];
    scrollView.backgroundColor = [UIColor whiteColor];
    [sv addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(sv).with.insets(UIEdgeInsetsMake(5,5,5,5));
    }];
    
    UIView *container = [UIView new];
    [scrollView addSubview:container];
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.width.equalTo(scrollView);
    }];
    
    int count = 10;
    
    UIView *lastView = nil;
    
    for ( int i = 1 ; i <= count ; ++i )
    {
        UIView *subv = [UIView new];
        [container addSubview:subv];
        subv.backgroundColor = [UIColor colorWithHue:( arc4random() % 256 / 256.0 )
                                          saturation:( arc4random() % 128 / 256.0 ) + 0.5
                                          brightness:( arc4random() % 128 / 256.0 ) + 0.5
                                               alpha:1];
        
        [subv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(container);
            make.height.mas_equalTo(@(20*i));
            
            if ( lastView )
            {
                make.top.mas_equalTo(lastView.mas_bottom);
            }
            else
            {
                make.top.mas_equalTo(container.mas_top);
            }
        }];
        
        lastView = subv;
    }
    
    
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lastView.mas_bottom);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
