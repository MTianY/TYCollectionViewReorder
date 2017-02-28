//
//  ClassifyItem.h
//  cell的移动效果
//
//  Created by 马天野 on 2017/2/26.
//  Copyright © 2017年 MTY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ClassifyItem : NSObject

@property (nonatomic, assign) int ID;
@property (nonatomic, strong) NSMutableArray *tags;
@property (nonatomic, strong) NSString *title;

/** 字典转模型 */
+ (instancetype)itemWithDict:(NSDictionary *)dict;
/** 获取一个存储模型的可变数组 */
+ (NSMutableArray *)getClassifyData;

@end
