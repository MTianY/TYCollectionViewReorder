# TYCollectionViewReorder
collectionView拖拽重排效果
## UICollectionView的cell的拖拽重排



### 一.效果图

![效果图](/Users/Maty/Desktop/collectionView的cell重排效果.gif)

### 二.核心方法

1.在iOS 9之后系统提供了一套API用于实现重排

```objc
// Support for reordering
- (BOOL)beginInteractiveMovementForItemAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(9_0); // returns NO if reordering was prevented from beginning - otherwise YES
- (void)updateInteractiveMovementTargetPosition:(CGPoint)targetPosition NS_AVAILABLE_IOS(9_0);
- (void)endInteractiveMovement NS_AVAILABLE_IOS(9_0);
- (void)cancelInteractiveMovement NS_AVAILABLE_IOS(9_0);
```

2.这里采用给UICollectionView添加`长按手势`,结合系统API实现拖拽重排

- 给collectionView添加长按手势

```objc
#pragma mark - 添加长按手势
- (void)setUpLongPressGes {
    UILongPressGestureRecognizer *longPresssGes = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressMethod:)];
    [self.collectionView addGestureRecognizer:longPresssGes]; 
}
```

- 监听长按手势,根据长按手势状态实现collectionView的重排方法

```objc
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
```

- 移动cell

```objc
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

```

