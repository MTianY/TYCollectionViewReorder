//
//  ClassifyItem.m
//  cell的移动效果
//
//  Created by 马天野 on 2017/2/26.
//  Copyright © 2017年 MTY. All rights reserved.
//

#import "ClassifyItem.h"
#import "ClassifyDetailItem.h"

@implementation ClassifyItem

+ (NSMutableArray *)getClassifyData {
    // plist文件全路径
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Classify.plist" ofType:nil];
    // 根据plist文件内容创建并返回一个数组(这里数组里面包括2个字典)
    NSArray *array = [NSArray arrayWithContentsOfFile:filePath];
    // 创建临时可变数组
    NSMutableArray *tempArray = [NSMutableArray array];
    // 遍历数组里面的字典,字典转模型,将模型存放到临时可变数组内
    for (NSDictionary *dict in array) {
        ClassifyItem *item = [[self alloc] init];
        [item setValuesForKeysWithDictionary:dict];
        [tempArray addObject:item];
    }
    // 返回一个存储模型的数组
    return tempArray;
}

+ (instancetype)itemWithDict:(NSDictionary *)dict {
    ClassifyItem *item = [[self alloc] init];
    [item setValuesForKeysWithDictionary:dict];
    return item;
}

- (void)setValue:(id)value forKey:(NSString *)key {
    
    if ([key isEqualToString:@"tags"]) {
        
        NSMutableArray *arrM = [NSMutableArray array];
        
        for (NSDictionary *dict in (NSArray *)value) {
            
            ClassifyDetailItem *model = [ClassifyDetailItem itemWithDict:dict];
            [arrM addObject:model];

        }
//        self.tags = [arrM copy];
        self.tags = arrM;
        return;
    }
    [super setValue:value forKey:key];
    
}

@end
