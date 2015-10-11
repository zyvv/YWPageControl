//
//  ViewController.m
//  YWPageControl
//
//  Created by 张洋威 on 15/10/10.
//  Copyright © 2015年 YangWei Zhang. All rights reserved.
//

#import "ViewController.h"
#import "YWPageControl.h"
@interface ViewController ()
{
    YWPageControl *pageControl;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    pageControl = [[YWPageControl alloc] initWithFrame:CGRectMake(10, 100, 230, 260)];
    self.view.backgroundColor = [UIColor grayColor];
    pageControl.backgroundColor = [UIColor grayColor];
    [self.view addSubview:pageControl];
    
    UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteButton.frame = CGRectMake(250, 50, 70, 50);
    [deleteButton setTitle:@"删除" forState:UIControlStateNormal];
    [deleteButton addTarget:self action:@selector(deleteButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:deleteButton];
    
    UIButton *renameButton = [UIButton buttonWithType:UIButtonTypeCustom];
    renameButton.frame = CGRectMake(250, 120, 70, 50);
    [renameButton setTitle:@"重命名" forState:UIControlStateNormal];
    [renameButton addTarget:self action:@selector(renameButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:renameButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 *  删除
 *
 *  @param button
 */
- (void)deleteButtonAction:(UIButton *)button
{
    [pageControl deleteCurrentPageView];
}

/**
 *  重命名
 *
 *  @param button
 */
- (void)renameButtonAction:(UIButton *)button
{
    [pageControl renameCurrentPageViewTitleWithTitle:@"你好漂亮"];
}

@end
