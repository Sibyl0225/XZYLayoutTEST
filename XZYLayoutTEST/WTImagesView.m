//
//  WTImagesView.m
//  MeiJing
//
//  Created by mac on 16/8/31.
//  Copyright © 2016年 zte. All rights reserved.
//

#import "WTImagesView.h"
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
@interface WTImagesView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property ( nonatomic, strong)UICollectionView *collectionView;
@property ( nonatomic, strong)NSArray *imageArray;
@end
@implementation WTImagesView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {

        UICollectionViewFlowLayout * flowLayout=[[UICollectionViewFlowLayout alloc]init];
        
        flowLayout.itemSize = CGSizeMake(150,150);
        //两单元格之间的间隙
        flowLayout.minimumInteritemSpacing = 10.f;
        //两单元格行与行之间的最小距离
        flowLayout.minimumLineSpacing = 10.f;
        
        self.collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1000) collectionViewLayout:flowLayout];
        
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        
        self.collectionView.showsHorizontalScrollIndicator = NO;
        
        [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"haha"];
        [self addSubview:_collectionView];
        
    }

    return self;

}
#pragma mark--UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 40;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"haha" forIndexPath:indexPath];
    
    if (indexPath.item==1) {
        cell.backgroundColor=[UIColor greenColor];
    }else{
        cell.backgroundColor=[UIColor purpleColor];
    }
    return cell;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
