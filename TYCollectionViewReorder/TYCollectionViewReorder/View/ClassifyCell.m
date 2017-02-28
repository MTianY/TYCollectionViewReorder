//
//  ClassifyCell.m
//  cell的移动效果
//
//  Created by 马天野 on 2017/2/27.
//  Copyright © 2017年 MTY. All rights reserved.
//

#import "ClassifyCell.h"
#import "ClassifyDetailItem.h"
#import <UIImageView+WebCache.h>

@interface ClassifyCell ()

@property (weak, nonatomic) IBOutlet UIImageView *classImageView;
@property (weak, nonatomic) IBOutlet UILabel *classTitleLabel;

@end

@implementation ClassifyCell

- (void)setCellDetailItem:(ClassifyDetailItem *)cellDetailItem {
    _cellDetailItem = cellDetailItem;
    
    self.classTitleLabel.text = cellDetailItem.name;
    [self.classImageView sd_setImageWithURL:[NSURL URLWithString:cellDetailItem.img] placeholderImage:[UIImage imageNamed:@"quesheng"]];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
