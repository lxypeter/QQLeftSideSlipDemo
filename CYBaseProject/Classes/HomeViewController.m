//
//  HomeViewController.m
//  QQLeftSideSlipDemo
//
//  Created by Peter Lee on 16/8/16.
//  Copyright © 2016年 CY.Lee. All rights reserved.
//

#import "HomeViewController.h"
#import "LeftSideViewController.h"
#import "MessageViewController.h"

@interface HomeViewController ()

@property (nonatomic, strong) UITabBarController *tabBarController;
@property (nonatomic, strong) LeftSideViewController *leftSideViewController;
@property (nonatomic, strong) UIView *coverView;
@property (nonatomic, assign, getter=isValidPan) BOOL validPan;

@end

@implementation HomeViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureSubViews];
}

#pragma mark - configure subViews
- (void)configureSubViews{
    
    //主页面
    UITabBarController *mainController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"TabBarController"];
    self.tabBarController = mainController;
    [self.view addSubview:mainController.view];
    
    //主页面手势
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panTabBarControllerView:)];
    [self.tabBarController.view addGestureRecognizer:panGesture];
    
    UINavigationController *firstNaviCtrl = [mainController.viewControllers firstObject];
    UIButton *headerButton = [[UIButton alloc] init];
    [headerButton setImage:[UIImage imageNamed:@"header"] forState:UIControlStateNormal];
    headerButton.bounds = CGRectMake(0, 0, 30, 30);
    headerButton.layer.masksToBounds = YES;
    headerButton.layer.cornerRadius = 15;
    [headerButton addTarget:self action:@selector(clickLeftNavigationButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:headerButton];
    [firstNaviCtrl.viewControllers firstObject].navigationItem.leftBarButtonItem = backItem;
    
    //遮盖层
    UIView *coverView = [[UIView alloc]initWithFrame:mainController.view.frame];
    coverView.backgroundColor = [UIColor clearColor];
    coverView.hidden = YES;
    [mainController.view addSubview:coverView];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickCoverView:)];
    [coverView addGestureRecognizer:tapGesture];
    self.coverView = coverView;
    
    //左边侧滑栏
    LeftSideViewController *leftSideViewController = [[LeftSideViewController alloc]init];
    leftSideViewController.view.frame = CGRectMake(-ScreenWidth*0.8, 0, ScreenWidth*0.8, ScreenHeight);
    __weak typeof(self) weakSelf = self;
    leftSideViewController.leftSideOptionBlock = ^(LeftSideViewOption *option){
        
        [UIView animateWithDuration:0.25 animations:^{
            [weakSelf slipViewWithDistance:-(ScreenWidth*0.8)];
        }];
        
        UIViewController *targetController = [[NSClassFromString(option.className) alloc]init];
        targetController.title = option.title;
        
        UINavigationController *selectedViewController = weakSelf.tabBarController.selectedViewController;
        [selectedViewController pushViewController:targetController animated:YES];
    };
    self.leftSideViewController = leftSideViewController;
    [self.view addSubview:leftSideViewController.view];
    
}

#pragma mark - event method
- (void)clickCoverView:(UITapGestureRecognizer *)tapGest{
    [UIView animateWithDuration:0.25 animations:^{
        [self slipViewWithDistance:-(ScreenWidth*0.8)];
    }completion:^(BOOL finished) {
        self.coverView.hidden = YES;
    }];
}

- (void)panTabBarControllerView:(UIPanGestureRecognizer *)panGest{
    
    //开始时
    if(panGest.state == UIGestureRecognizerStateBegan){
        CGPoint beginPoint = [panGest locationInView:panGest.view];
        if (beginPoint.x>panGest.view.frame.size.width/5) {
            self.validPan = NO;
        }else{
            self.validPan = YES;
        }
    }
    
    if (!self.isValidPan) return;
    
    CGPoint trans = [panGest translationInView:panGest.view];
    [self slipViewWithDistance:trans.x];
    [panGest setTranslation:CGPointZero inView:panGest.view];
    
    //结束时
    if(panGest.state == UIGestureRecognizerStateEnded){
        if(fabs(panGest.view.frame.origin.x)>self.leftSideViewController.view.frame.size.width/2){
            [UIView animateWithDuration:0.1 animations:^{
                [self slipViewWithDistance:ScreenWidth*0.8 - panGest.view.frame.origin.x];
            }completion:^(BOOL finished) {
                self.coverView.hidden = NO;
            }];
        }else{
            [UIView animateWithDuration:0.1 animations:^{
                [self slipViewWithDistance:-panGest.view.frame.origin.x];
            }completion:^(BOOL finished) {
                self.coverView.hidden = YES;
            }];
        }
    }
}

- (void)clickLeftNavigationButton{
    [UIView animateWithDuration:0.25 animations:^{
        [self slipViewWithDistance:ScreenWidth*0.8];
    }completion:^(BOOL finished) {
        self.coverView.hidden = NO;
    }];
}

- (void)slipViewWithDistance:(NSInteger)moveDistance{
    
    if (self.leftSideViewController.view.frame.origin.x+moveDistance<-(ScreenWidth*0.8)) {
        moveDistance = -(ScreenWidth*0.8) - self.leftSideViewController.view.frame.origin.x;
    }
    
    CGRect tempFrame = self.leftSideViewController.view.frame;
    tempFrame.origin.x = tempFrame.origin.x + moveDistance;
    self.leftSideViewController.view.frame = tempFrame;
    
    tempFrame = self.tabBarController.view.frame;
    tempFrame.origin.x = tempFrame.origin.x + moveDistance;
    self.tabBarController.view.frame = tempFrame;
   
}

@end
