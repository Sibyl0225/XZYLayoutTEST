//
//  OpinionAanSuggestionImageCell.m
//  XZYLayoutTEST
//
//  Created by MAC on 26/8/16.
//  Copyright © 2016年 Mac0225. All rights reserved.
//

#import "OpinionAanSuggestionImageCell.h"

@interface OpinionAanSuggestionImageCell ()

@property (nonatomic ,strong) UIImageView *imageView;

@end

@implementation OpinionAanSuggestionImageCell

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubView];

    }
    return self;
}

-(void)initSubView{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.bounds];
    [self addSubview:imageView];
    self.imageView = imageView;
}

-(void)setImage:(UIImage *)image{
    _imageView.image = image;
}
@end
