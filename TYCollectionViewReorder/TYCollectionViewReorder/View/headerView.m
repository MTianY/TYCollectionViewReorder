//
//  headerView.m
//  UICollectionView
//
//  Created by 马天野 on 2017/2/27.
//  Copyright © 2017年 MTY. All rights reserved.
//

#import "headerView.h"

@interface headerView ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation headerView

- (instancetype)initWithFrame:(CGRect)frame {
   
    self = [super initWithFrame:frame];
    if (self) {
        // 设置UI
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.font = [UIFont systemFontOfSize:20];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleLabel.frame = self.bounds;
}

- (void)setTitleName:(NSString *)titleName {
    _titleName = titleName;
    self.titleLabel.text = titleName;
}

@end
