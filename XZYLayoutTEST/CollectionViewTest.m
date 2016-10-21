//
//  CollectionViewTest.m
//  XZYLayoutTEST
//
//  Created by MAC on 31/8/16.
//  Copyright © 2016年 Mac0225. All rights reserved.
//

#import "CollectionViewTest.h"

#import "MainViewCtrl.h"

@implementation CollectionViewTest

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor redColor];
    
    UIButton *pushBut = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 30)];
    pushBut.titleLabel.font = [UIFont systemFontOfSize:14];
    [pushBut setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    [pushBut setTitle:@"psuh" forState:UIControlStateNormal];
    [pushBut addTarget:self action:@selector(pushToMainViewController) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *pushItem = [[UIBarButtonItem alloc]initWithCustomView:pushBut];
    self.navigationItem.rightBarButtonItem = pushItem;
    
    
    
    
//    WTImagesView *collectionView = [[WTImagesView alloc]initWithFrame:[UIScreen mainScreen].bounds];
//    
//    [self.view addSubview:collectionView];
}

-(void)pushToMainViewController{
   
    MainViewCtrl *mainCtrl = [[MainViewCtrl alloc]init];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIControlStateNormal target:nil action:nil];
    [self.navigationController pushViewController:mainCtrl animated:YES];
}
@end
