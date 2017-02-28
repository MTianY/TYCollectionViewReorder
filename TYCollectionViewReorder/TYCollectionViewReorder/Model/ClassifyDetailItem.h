//
//  ClassifyDetailItem.h
//  cell的移动效果
//
//  Created by 马天野 on 2017/2/27.
//  Copyright © 2017年 MTY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClassifyDetailItem : NSObject

@property (nonatomic, assign) int ev_count;
@property (nonatomic, assign) int ID;
@property (nonatomic, strong) NSString *img;
@property (nonatomic, strong) NSString *name;

/** 字典转模型 */
+ (instancetype)itemWithDict:(NSDictionary *)dict;

@end
