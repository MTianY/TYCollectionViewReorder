//
//  ClassifyDetailItem.m
//  cell的移动效果
//
//  Created by 马天野 on 2017/2/27.
//  Copyright © 2017年 MTY. All rights reserved.
//

#import "ClassifyDetailItem.h"

@implementation ClassifyDetailItem

+ (instancetype)itemWithDict:(NSDictionary *)dict {
    ClassifyDetailItem *item = [[self alloc] init];
    [item setValuesForKeysWithDictionary:dict];
    return item;
}

- (void)setValue:(id)value forKey:(NSString *)key {
    
    if ([key isEqualToString:@"id"]) {
        self.ID = (int)value;
        return;
    }
    [super setValue:value forKey:key];
    
}

@end
