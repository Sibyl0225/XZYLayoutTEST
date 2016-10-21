//
//  MainViewCtrl.m
//  XZYLayoutTEST
//
//  Created by MAC on 31/8/16.
//  Copyright © 2016年 Mac0225. All rights reserved.
//

#import "MainViewCtrl.h"
#import "MyLayout.h"
#import "UIImage+Extension.h"

@interface MainViewCtrl ()<UICollectionViewDataSource ,UICollectionViewDelegate ,UITableViewDelegate ,UITableViewDataSource>

@property (strong ,nonatomic) UIScrollView *scrollView;

@end

static NSString *cellIndentifier = @"CollectionCellIndentifier";

@implementation MainViewCtrl

- (void)viewDidLoad{
    

    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
//    self.navigationController.navigationBar.translucent = NO;
    
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.view.backgroundColor = [UIColor blackColor];
    
//    UIImage *barBackGroundColor = [UIImage imageWithColor:[UIColor clearColor] withSize:CGSizeMake(CGRectGetWidth(self.view.bounds), 64)];
    
    UIImage *barBackGroundColor = [UIImage new];
    
    [self.navigationController.navigationBar setBackgroundImage:barBackGroundColor forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setShadowImage:barBackGroundColor];
    
//    [self.navigationController.navigationBar.layer setMasksToBounds:YES];
    
    UIButton *pushBut = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    pushBut.titleLabel.font = [UIFont systemFontOfSize:12];
    [pushBut setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    [pushBut setTitle:@"psuh" forState:UIControlStateNormal];
    [pushBut addTarget:self action:@selector(useLessClik) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *collectionBtn = [[UIButton alloc]initWithFrame:CGRectMake(50, 0, 50, 30)];
    collectionBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [collectionBtn setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    [collectionBtn setTitle:@"collecte" forState:UIControlStateNormal];
    [collectionBtn addTarget:self action:@selector(useLessClik) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *navRightBtnView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    [navRightBtnView addSubview:collectionBtn];
    [navRightBtnView addSubview:pushBut];
    
    
    UIBarButtonItem *pushItem = [[UIBarButtonItem alloc]initWithCustomView:navRightBtnView];
    self.navigationItem.rightBarButtonItem = pushItem;
    
    
    MyLinearLayout *backGroundView = [[MyLinearLayout alloc]initWithOrientation:MyLayoutViewOrientation_Vert];
    backGroundView.backgroundColor = [UIColor colorWithWhite:0.832 alpha:1];
    backGroundView.myLeftMargin = backGroundView.myRightMargin = 0;
    backGroundView.padding = UIEdgeInsetsMake(0, 0, 0, 0);
//    backGroundView.widthDime.equalTo(@(CGRectGetWidth([UIScreen mainScreen].bounds)));
    [self.view addSubview:backGroundView];
    
    
    UICollectionViewFlowLayout *flowLyout = [[UICollectionViewFlowLayout alloc]init];
    flowLyout.itemSize = CGSizeMake(CGRectGetWidth(self.view.bounds), 230);

    flowLyout.minimumLineSpacing = 0;
    flowLyout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLyout];
    collectionView.widthDime.equalTo(@(CGRectGetWidth([UIScreen mainScreen].bounds)));
    collectionView.heightDime.equalTo(@230);
    collectionView.backgroundColor = [UIColor orangeColor];
    collectionView.pagingEnabled = YES;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.showsHorizontalScrollIndicator = NO;
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellIndentifier];
    [backGroundView addSubview:collectionView];
    
    UITableView *tableView = [UITableView new];
    tableView.myLeftMargin = tableView.myRightMargin = 0;
    tableView.heightDime.equalTo(@(CGRectGetHeight([UIScreen mainScreen].bounds) - 230));
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableHeaderView = [self creatTableHeaderView];
    tableView.tableFooterView = [self creatTableFooterView];
    [backGroundView addSubview:tableView];
    [tableView layoutIfNeeded];
    
    [backGroundView layoutIfNeeded];

};

- (UIColor *)randomColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

- (MyLinearLayout *)creatTableHeaderView{
    
    MyLinearLayout *headerLinearLayout = [[MyLinearLayout alloc] initWithOrientation:MyLayoutViewOrientation_Horz];
    headerLinearLayout.widthDime.equalTo(@(CGRectGetWidth(self.view.bounds)));
    headerLinearLayout.heightDime.equalTo(@(65));
    
    UIButton *voiceBtn = [UIButton new];
    
    voiceBtn.widthDime.equalTo(@(CGRectGetWidth([UIScreen mainScreen].bounds)/2));
    voiceBtn.heightDime.equalTo(@(65));
    
    [voiceBtn setContentMode:UIViewContentModeScaleAspectFit];
    [voiceBtn setTitle:@"语音导航" forState:UIControlStateNormal];
    [voiceBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    voiceBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [voiceBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -20)];
    [headerLinearLayout addSubview:voiceBtn];
    
    UIImageView *voiceImageView = [UIImageView new];
    voiceImageView.frame = CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)/4 - 55, (65 - 30)/2, 30, 30);
    voiceImageView.contentMode = UIViewContentModeScaleToFill;
    voiceImageView.image = [UIImage imageNamed:@"scenic_voice"];

    [voiceBtn addSubview:voiceImageView];
    
    UIButton *videoBtn = [UIButton new];
    
    videoBtn.widthDime.equalTo(@(CGRectGetWidth([UIScreen mainScreen].bounds)/2));
    videoBtn.heightDime.equalTo(@(65));
    
    [videoBtn setContentMode:UIViewContentModeScaleAspectFit];
    [videoBtn setTitle:@"视频欣赏" forState:UIControlStateNormal];
    [videoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    videoBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [videoBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -20)];
    [headerLinearLayout addSubview:videoBtn];
    
    UIImageView *videoimageView = [UIImageView new];
    videoimageView.frame = CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)/4 - 55, (65 - 30)/2, 30, 30);
    videoimageView.contentMode = UIViewContentModeScaleToFill;
    videoimageView.image = [UIImage imageNamed:@"scenic_video"];
    
    [videoBtn addSubview:videoimageView];
    
    return headerLinearLayout;
}

- (UIView *)creatTableFooterView{
    
    UIView *cutLine = [UIView new];
    cutLine.backgroundColor =  [UIColor colorWithWhite:0.823 alpha:1.000];
    cutLine.frame = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 0.35);
    
    UILabel *detailLable = [UILabel new];
    detailLable.frame = CGRectMake(10, 10, CGRectGetWidth([UIScreen mainScreen].bounds) - 20, 0);
    detailLable.font = [UIFont systemFontOfSize:14];
    detailLable.textColor = [UIColor blackColor];
    detailLable.numberOfLines = 0;
    detailLable.text = @"景点详情：\n相对布局是一种里面的子视图通过相互之间的约束和依赖来进行布局和定位的布局视图。相对布局里面的子视图的布局位置和添加的顺序无关，而是通过设置子视图的相对依赖关系来进行定位和布局的。";
    [detailLable sizeToFit];
    
    //分割线
    UIView *separatorLine = [UIView new];
    separatorLine.backgroundColor =  [UIColor colorWithWhite:0.823 alpha:1.000];
    separatorLine.frame = CGRectMake(0, 10 + detailLable.bounds.size.height + 10 , CGRectGetWidth([UIScreen mainScreen].bounds), 0.35);

    
    
    UIButton *showMoreBut = [UIButton new];
    showMoreBut.frame = CGRectMake(0, 10 + detailLable.bounds.size.height + 10,CGRectGetWidth([UIScreen mainScreen].bounds), 50);
    [showMoreBut setTitle:@"查看完整图文详情" forState:UIControlStateNormal];
    [showMoreBut setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    showMoreBut.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    showMoreBut.titleLabel.font = [UIFont systemFontOfSize:16];
    
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), detailLable.bounds.size.height + 50 + 10 + 10)];
    [footerView addSubview:cutLine];
    [footerView addSubview:detailLable];
    [footerView addSubview:separatorLine];
    [footerView addSubview:showMoreBut];
    
    return footerView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 38;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 3) {
        return 10;
    }
    return 40;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIndentifier forIndexPath:indexPath];
    cell.backgroundColor = [self randomColor];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
        return 4;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:@"tableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tableViewCell"];
    }
    return cell;
}

- (void)useLessClik{
    NSLog(@"虽然你点了，但是我告诉你，你做的是无用功！！！");
}

@end
