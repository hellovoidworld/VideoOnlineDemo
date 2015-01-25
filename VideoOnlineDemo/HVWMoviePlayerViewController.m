//
//  HVWMoviePlayerViewController.m
//  VideoOnlineDemo
//
//  Created by hellovoidworld on 15/1/25.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "HVWMoviePlayerViewController.h"

@interface HVWMoviePlayerViewController ()

@end

@implementation HVWMoviePlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 取消接收程序进入后台的通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
}

/** 重写屏幕方向方法 */
- (NSUInteger)supportedInterfaceOrientations {
    // 横屏，向左/右
    return UIInterfaceOrientationMaskLandscape;
}

@end
