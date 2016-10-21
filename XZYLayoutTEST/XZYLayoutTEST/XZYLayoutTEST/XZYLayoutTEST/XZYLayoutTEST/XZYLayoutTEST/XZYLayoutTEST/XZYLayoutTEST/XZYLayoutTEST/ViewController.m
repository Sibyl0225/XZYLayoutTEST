//
//  ViewController.m
//  XZYLayoutTEST
//
//  Created by MAC on 17/8/16.
//  Copyright © 2016年 Mac0225. All rights reserved.
//

#import "ViewController.h"
#import "OpinionAanSuggestionImageCell.h"
#import "MyLayout.h"

@interface ViewController ()<UITextViewDelegate ,UICollectionViewDataSource ,UICollectionViewDelegate ,UIImagePickerControllerDelegate ,UINavigationControllerDelegate ,UIActionSheetDelegate>{

    CGFloat textViewHeight;

}

@property (strong ,nonatomic) MyLinearLayout *tableHeaderViewLayout;

@property (strong ,nonatomic) UICollectionView *collecotionView;

@property (strong ,nonatomic) UIScrollView *scrollView;

@property (strong ,nonatomic) NSMutableArray *imageDataMuArray;

@property (strong, nonatomic)UIActionSheet * actionSheet;

@end

static NSString *collectonCellIndentifer = @"EmpowerOpinionAndSuggestionCellIndentifier";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIScrollView *scrollView = [UIScrollView new];
    scrollView.backgroundColor = [UIColor redColor];
    scrollView.frame = CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - 50 - 64);
    self.scrollView = scrollView;
    
    MyLinearLayout *headerViewLayout = [MyLinearLayout linearLayoutWithOrientation:MyLayoutViewOrientation_Vert];
    headerViewLayout.backgroundColor = [UIColor colorWithWhite:0.832 alpha:1];
    headerViewLayout.padding = UIEdgeInsetsMake(15, 15, 15, 15);
    headerViewLayout.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 0);
    headerViewLayout.myLeftMargin = headerViewLayout.myLeftMargin = 0;
    
    UILabel *subTitleLble = [UILabel new];
    subTitleLble.text = @"您反馈的意见、建议对我们有很大的帮助，我们将统一收集进一步改善工作。";
    subTitleLble.font = [UIFont systemFontOfSize:13];
    subTitleLble.textColor = [UIColor grayColor];
    subTitleLble.myLeftMargin = subTitleLble.myRightMargin = 0;
    subTitleLble.myTopMargin = 8;
    subTitleLble.numberOfLines = 0;
    subTitleLble.flexedHeight = YES;
    [subTitleLble sizeToFit];
    [headerViewLayout addSubview:subTitleLble];
    
    UITextView *textView = [UITextView new];
    textView.scrollEnabled = NO;
    textView.text = @"请填写你的意见建议";
    textView.textColor = [UIColor lightGrayColor];
    textView.myLeftMargin = textView.myRightMargin = 0;
    textView.myTopMargin = 10;
    textView.myHeight = 200;
    textView.delegate = self;
    textView.font = [UIFont systemFontOfSize:13];
    textView.layer.borderWidth = 0.5;
    textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [headerViewLayout addSubview:textView];
    
    [scrollView addSubview:headerViewLayout];
    self.tableHeaderViewLayout = headerViewLayout;
    
    
    [self.view addSubview:scrollView];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake( 70, 70);
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowLayout.minimumLineSpacing = 10;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor colorWithWhite:0.832 alpha:1];
    
    self.imageDataMuArray = [NSMutableArray array];
    [self.imageDataMuArray addObject:[UIImage imageNamed:@"add"]];
    
    collectionView.myRightMargin = collectionView.myLeftMargin = 0;
    collectionView.myTopMargin = 15;
    collectionView.heightDime.equalTo(@70);
    [headerViewLayout addSubview:collectionView];
    
    [collectionView registerClass:[OpinionAanSuggestionImageCell class] forCellWithReuseIdentifier:collectonCellIndentifer];
    
    self.collecotionView = collectionView;
    
    MyRelativeLayout *bottomRelativeLayout = [[MyRelativeLayout alloc]init];
    bottomRelativeLayout.backgroundColor = [UIColor whiteColor];
    bottomRelativeLayout.myWidth = CGRectGetWidth(self.view.bounds);
    bottomRelativeLayout.heightDime.equalTo(@50);
    bottomRelativeLayout.bottomPos.equalTo(self.view);
    
    UIView *cutLine = [[UIView alloc]init];
    cutLine.backgroundColor = [UIColor colorWithWhite:0.832 alpha:0.8];
    cutLine.myRightMargin = cutLine.myRightMargin = 0;
    cutLine.topPos.equalTo(@0);
    cutLine.heightDime.equalTo(@(0.5));
    [bottomRelativeLayout addSubview:cutLine];
    
    UILabel *submitLable = [UILabel new];
    submitLable.text = @"提交";
    submitLable.textColor = [UIColor colorWithRed:0 green:172 blue:215 alpha:1];
    submitLable.font = [UIFont systemFontOfSize:16];
    submitLable.myCenterXOffset = 0;
    submitLable.myCenterYOffset = 0;
    [submitLable sizeToFit];
    [bottomRelativeLayout addSubview:submitLable];
    
    [self.view addSubview:bottomRelativeLayout];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.imageDataMuArray.count;
}
#pragma mark CollectionCell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    OpinionAanSuggestionImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectonCellIndentifer forIndexPath:indexPath];
    
        NSInteger lastIndexPath = self.imageDataMuArray.count;
        if (indexPath.item + 1 == lastIndexPath) {
            cell.image = self.imageDataMuArray[indexPath.item];
            if (lastIndexPath == 4)  cell.alpha = 0;
           
        }else{
            cell.image = self.imageDataMuArray[indexPath.item];
        }

    return cell;
}
#pragma mark 点击方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger lastIndexPath = self.imageDataMuArray.count;
    if (indexPath.item + 1 == lastIndexPath)  //点击最后一个cell
    {
        if (lastIndexPath < 4)
        {
            [self selectPictureFromPhone];  //添加图片
        }else{
            return;
        }
        
    }else{
            [self deleteImage:indexPath];   //删除图片
    }
}

- (void)selectPictureFromPhone
{
    [self callActionSheetFunc];
}

- (void)deleteImage:(NSIndexPath *)indexPath
{
    [self.imageDataMuArray removeObjectAtIndex:indexPath.item];
    [self.collecotionView reloadData];
}

//点击按钮添加本地图片方法
/**
 @ 调用ActionSheet
 */
- (void)callActionSheetFunc{
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        self.actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择图像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"相册", nil];
    }else{
        self.actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择图像" delegate:self cancelButtonTitle:@"取消"destructiveButtonTitle:nil otherButtonTitles:@"相册", nil];
    }
    
    self.actionSheet.tag = 1000;
    [self.actionSheet showInView:self.view];
}

// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag == 1000)
    {
        NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            switch (buttonIndex)
            {
                case 0:
                    //来源:相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                case 1:
                    //来源:相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
                case 2:
                    return;
            }
        }else{
            if (buttonIndex == 1)
            {
                return;
            }else{
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = sourceType;
        
        [self presentViewController:imagePickerController animated:YES completion:^{
            
        }];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self.imageDataMuArray insertObject:image atIndex:0];
    NSInteger lastIndexPath = self.imageDataMuArray.count;
    
    if(lastIndexPath != 4){
        
    }else{
//        [self.view showTipViewAtCenter:@"请点击图片以删除" timer:2];
        NSLog(@"请点击图片以删除");
    }
    
    [self.collecotionView reloadData];
}

//- (void)creatTestView
//{
//    
//    //这个例子用来构建一个动态高度的头部布局视图。
//    MyLinearLayout *tableHeaderViewLayout = [MyLinearLayout linearLayoutWithOrientation:MyLayoutViewOrientation_Vert];
//    tableHeaderViewLayout.backgroundColor = [UIColor colorWithWhite:0.832 alpha:1];
//    tableHeaderViewLayout.padding = UIEdgeInsetsMake(10, 10, 10, 10);
//    tableHeaderViewLayout.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 0);
//    tableHeaderViewLayout.myLeftMargin = tableHeaderViewLayout.myLeftMargin = 0;
//    [tableHeaderViewLayout setTarget:self action:@selector(changeFram)];
//    [self.view addSubview:tableHeaderViewLayout];
//    
//    UILabel *titleLble = [UILabel new];
//    titleLble.text = @"这是标题，不会很长的";
//    titleLble.font = [UIFont systemFontOfSize:16];
//    titleLble.myCenterXOffset = 0;
//    titleLble.myTopMargin = 24;
//    [titleLble sizeToFit];
//    [tableHeaderViewLayout addSubview:titleLble];
//    
//    UILabel *subTitleLble = [UILabel new];
//    subTitleLble.text = @" if you use layout view to realize the dynamic height tableHeaderView, please use frame to set view's width and use wrapContentHeight to set view's height. the layoutIfNeeded method is needed to call before the layout view assignment to the UITableview's tableHeaderView.";
//    subTitleLble.font = [UIFont systemFontOfSize:14];
//    subTitleLble.textColor = [UIColor grayColor];
//    subTitleLble.myLeftMargin = subTitleLble.myRightMargin = 0;
//    subTitleLble.myTopMargin = 8;
//    subTitleLble.numberOfLines = 0;
//    subTitleLble.flexedHeight = YES;
//    [subTitleLble sizeToFit];
//    [tableHeaderViewLayout addSubview:subTitleLble];
//    
//    UITextView *textView = [UITextView new];
//    textView.scrollEnabled = NO;
//    textView.text = @"请输入文字……";
//    textView.myLeftMargin = textView.myRightMargin = 0;
//    textView.myTopMargin = 10;
//    textView.myHeight = 56;
//    textView.delegate = self;
//    textView.font = [UIFont systemFontOfSize:16];
//    textView.layer.borderWidth = 1;
//    textView.layer.borderColor = [UIColor redColor].CGColor;
//    [tableHeaderViewLayout addSubview:textView];
//    
//    MyRelativeLayout *relativeLayout = [[MyRelativeLayout alloc] init];
//    relativeLayout.backgroundColor = [UIColor purpleColor];
//    relativeLayout.topPos.equalTo(textView.bottomPos).offset(8);
//    relativeLayout.padding = UIEdgeInsetsMake(24, 10, 10, 10);
//    relativeLayout.wrapContentHeight = YES;
//    relativeLayout.myWidth = CGRectGetWidth(self.view.bounds) - 20;
//    [tableHeaderViewLayout addSubview:relativeLayout];
//    
//    UIImageView *picImageView = [[UIImageView alloc]init];
//    picImageView.backgroundColor = [UIColor blueColor];
//    picImageView.widthDime.equalTo(@40);
//    picImageView.heightDime.equalTo(@40);
//    picImageView.leftPos.equalTo(@10);
//    picImageView.topPos.equalTo(relativeLayout).offset(3);
//    [relativeLayout addSubview:picImageView];
//    
//    UILabel *titleLable = [[UILabel alloc]init];
//    titleLable.font = [UIFont systemFontOfSize:16];
//    titleLable.text = @"谈谈销售之道";
//    titleLable.topPos.equalTo(relativeLayout).offset(0);
//    titleLable.leftPos.equalTo(picImageView.rightPos).offset(10);
//    [titleLable sizeToFit];
//    [relativeLayout addSubview:titleLable];
//    
//    
//    UILabel *subTitleLable = [[UILabel alloc]init];
//    subTitleLable.font = [UIFont systemFontOfSize:14];
//    subTitleLable.text = @"还剩 0天24小时58分 结束";
//    subTitleLable.topPos.equalTo(titleLable.bottomPos).offset(10);
//    subTitleLable.leftPos.equalTo(picImageView.rightPos).offset(10);
//    [subTitleLable sizeToFit];
//    [relativeLayout addSubview:subTitleLable];
//    
//    UILabel *detailLable = [[UILabel alloc]init];
//    detailLable.topPos.equalTo(picImageView.bottomPos).offset(10);
//    detailLable.widthDime.equalTo(@(CGRectGetWidth(self.view.bounds) - 34));
//    detailLable.myCenterXOffset = 0;
//    detailLable.numberOfLines = 0;
//    detailLable.flexedHeight = YES;
//    detailLable.font = [UIFont systemFontOfSize:12];
//    detailLable.textColor = [UIColor lightGrayColor];
//    detailLable.text = @"相对布局是一种里面的子视图通过相互之间的约束和依赖来进行布局和定位的布局视图。相对布局里面的子视图的布局位置和添加的顺序无关，而是通过设置子视图的相对依赖关系来进行定位和布局的。";
//    [detailLable sizeToFit];
//    [relativeLayout addSubview:detailLable];
//    
//    MyFrameLayout *rootLayout = [MyFrameLayout new];
//    rootLayout.widthDime.equalTo(@(CGRectGetWidth(self.view.bounds) - 20));
//    rootLayout.heightDime.equalTo(@250);
//    //    rootLayout.wrapContentHeight = YES;
//    rootLayout.padding = UIEdgeInsetsMake(10, 10, 10, 10);
//    rootLayout.backgroundColor = [UIColor greenColor];
//    rootLayout.topPos.equalTo(relativeLayout.bottomPos).offset(10);
//    [tableHeaderViewLayout addSubview:rootLayout];
//    
//    UIView *A = [UIView new];
//    A.mySize = CGSizeMake(40,40);
//    A.backgroundColor = [UIColor orangeColor];
//    A.marginGravity = MyMarginGravity_Horz_Left | MyMarginGravity_Vert_Top;
//    [rootLayout addSubview:A];
//    
//    UIView *B = [UIView new];
//    B.mySize = CGSizeMake(40,40);
//    B.backgroundColor = [UIColor orangeColor];
//    B.marginGravity = MyMarginGravity_Horz_Right | MyMarginGravity_Vert_Top;
//    [rootLayout addSubview:B];
//    
//    UIView *C = [UIView new];
//    C.mySize = CGSizeMake(40,40);
//    C.backgroundColor = [UIColor orangeColor];
//    C.marginGravity = MyMarginGravity_Horz_Left | MyMarginGravity_Vert_Bottom;
//    [rootLayout addSubview:C];
//    
//    UIView *D = [UIView new];
//    D.mySize = CGSizeMake(40,40);
//    D.backgroundColor = [UIColor orangeColor];
//    D.marginGravity = MyMarginGravity_Horz_Center | MyMarginGravity_Vert_Center;
//    [rootLayout addSubview:D];
//    
//    UIView *E = [UIView new];
//    E.mySize = CGSizeMake(40,40);
//    E.backgroundColor = [UIColor orangeColor];
//    E.marginGravity = MyMarginGravity_Horz_Right | MyMarginGravity_Vert_Bottom;
//    [rootLayout addSubview:E];
//    
//    [tableHeaderViewLayout layoutIfNeeded];
//    
//    NSLog(@"headerViewLayout.height %f",CGRectGetMaxY(tableHeaderViewLayout.bounds));
//
//}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    if ([textView.text isEqualToString:@"请填写你的意见建议"]) textView.text = @"";
    
}

- (void)textViewDidChange:(UITextView *)textView{
    
    UITextView *templeTextView = [UITextView new];
    templeTextView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds) - 30, 0);
    templeTextView.font = [UIFont systemFontOfSize:13];
    templeTextView.text = textView.text;
    [templeTextView sizeToFit];
    
    if (templeTextView.bounds.size.height > 200 && textViewHeight != templeTextView.bounds.size.height) {
        textView.myHeight = templeTextView.bounds.size.height;
        textViewHeight = templeTextView.bounds.size.height;
        [self.tableHeaderViewLayout layoutIfNeeded];
    }
}

- (void)changeFram{
    NSLog(@"将该变fram");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
