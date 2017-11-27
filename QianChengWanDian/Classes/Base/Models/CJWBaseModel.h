//
//  CJWBaseModel.h
//  QianChengWanDian
//
//  Created by Fireloli on 2017/11/24.
//  Copyright © 2017年 Fireloli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CJWBaseModel : NSObject


/** 对应的ID id -> ID */
@property (nonatomic, copy) NSString *ID;

//模型转字典
- (NSDictionary *)dictionaryFromModel;


- (instancetype)initWithDict:(NSDictionary *)dict;

/** 通过数组对象来创建一个对象数组 */
+ (NSArray *)objectsArrayWithKeyValuesArray:(NSArray *)valuesArray;

@end
