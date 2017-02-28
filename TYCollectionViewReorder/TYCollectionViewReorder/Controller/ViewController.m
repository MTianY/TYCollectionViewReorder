//
//  ViewController.m
//  TYCollectionViewReorder
//
//  Created by 马天野 on 2017/2/28.
//  Copyright © 2017年 MTY. All rights reserved.
//  collectionView拖拽重排demo

#import "ViewController.h"
#import "ClassifyItem.h"
#import "ClassifyDetailItem.h"
#import "ClassifyCell.h"
#import "headerView.h"

static NSString *const cellID = @"cell";

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *classifyArray;

@end

@implementation ViewController

- (NSMutableArray *)classifyArray {
    if (nil == _classifyArray) {
        _classifyArray = [ClassifyItem getClassifyData];
    }
    return _classifyArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置collectionView
    [self setUpCollectionView];
    // 添加长按手势
    [self setUpLongPressGes];

}

#pragma mark - 创建UICollectionView
- (void)setUpCollectionView {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    // 初始化collectionView的布局
    CGFloat margin = 10;
    // 假设一行展示3个cell
    CGFloat ScreenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat itemW = (ScreenW - 4 * margin) / 3;
    CGFloat itemH = 110;
    
    layout.itemSize = CGSizeMake(itemW, itemH);
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(margin, margin, margin, margin);
    // 头部视图的尺寸
    layout.headerReferenceSize = CGSizeMake(ScreenW, 60);
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.collectionView = collectionView;
    
    // 注册cell
    [collectionView registerNib:[UINib nibWithNibName:@"ClassifyCell" bundle:nil] forCellWithReuseIdentifier:@"ClassifyCell"];
    [collectionView registerClass:[headerView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headV"];
    
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:collectionView];
    
}

#pragma mark - 添加长按手势
- (void)setUpLongPressGes {
    
    UILongPressGestureRecognizer *longPresssGes = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressMethod:)];
    
    [self.collectionView addGestureRecognizer:longPresssGes];
    
}

// 监听长按手势
- (void)longPressMethod:(UILongPressGestureRecognizer *)longPressGes {
    
    // 判断手势状态
    switch (longPressGes.state) {
            
        case UIGestureRecognizerStateBegan: {
            
            // 判断手势落点位置是否在路径上(长按cell时,显示对应cell的位置,如path = 1 - 0,即表示长按的是第1组第0个cell). 点击除了cell的其他地方皆显示为null
            NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:[longPressGes locationInView:self.collectionView]];
            // 如果点击的位置不是cell,break
            if (nil == indexPath) {
                break;
            }
            NSLog(@"%@",indexPath);
            // 在路径上则开始移动该路径上的cell
            [self.collectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
        }
            break;
            
        case UIGestureRecognizerStateChanged:
            // 移动过程当中随时更新cell位置
            [self.collectionView updateInteractiveMovementTargetPosition:[longPressGes locationInView:self.collectionView]];
            break;
            
        case UIGestureRecognizerStateEnded:
            // 移动结束后关闭cell移动
            [self.collectionView endInteractiveMovement];
            break;
        default:
            [self.collectionView cancelInteractiveMovement];
            break;
    }
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    // 返回YES允许其item移动
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    // 取出来源组
    ClassifyItem *sourceItem = self.classifyArray[sourceIndexPath.section];
    // 取出item数据
    ClassifyDetailItem *detailItem = [sourceItem.tags objectAtIndex:sourceIndexPath.row];
    // 从资源数组中移除该数据
    [sourceItem.tags removeObject:detailItem];
    
    // 取出目标组
    ClassifyItem *destinationItem = self.classifyArray[destinationIndexPath.section];
    // 将数据插入到资源数组中的目标位置上
    [destinationItem.tags insertObject:detailItem atIndex:destinationIndexPath.row];
    
}

#pragma mark  -  UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.classifyArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    ClassifyItem *item = self.classifyArray[section];
    return item.tags.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ClassifyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ClassifyCell" forIndexPath:indexPath];
    ClassifyItem *item = self.classifyArray[indexPath.section];
    
    if (indexPath.row > item.tags.count - 1) {
        return cell;
    }
    
    ClassifyDetailItem *detailItem = item.tags[indexPath.row];
    cell.cellDetailItem = detailItem;
    return cell;
    
}

// 添加头部视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        headerView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headV" forIndexPath:indexPath];
        ClassifyItem *item = self.classifyArray[indexPath.section];
        headView.titleName = item.title;
        return headView;
    }else {
        return nil;
    }
}

@end
