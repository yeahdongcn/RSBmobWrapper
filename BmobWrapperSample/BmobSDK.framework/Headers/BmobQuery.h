//
//  BmobQuery.h
//  BmobSDK
//
//  Created by donson on 13-8-1.
//  Copyright (c) 2013年 donson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BmobObject.h"
#import "BmobConfig.h"
#import "BmobGeoPoint.h"

@interface BmobQuery : NSObject





/**
 *	限制得到多少个结果
 */
@property (nonatomic) NSInteger limit;

/**
 *	查询结果跳到第几页
 */
@property (nonatomic) NSInteger skip;

/**
 *	缓存策略
 */
@property(assign)BmobCachePolicy cachePolicy;

/**
 *	缓存有效时间
 */
@property (readwrite, assign) NSTimeInterval maxCacheAge;




/**
 *	查询对象
 *
 *	@param	className	对象名称（数据库表名）
 *
 *	@return	BmobQuery查询对象
 */
+(BmobQuery*)queryWithClassName:(NSString *)className;

/**
 *  查询用户表
 *
 *  @return BmobQuery查询对象
 */
+(BmobQuery*)queryForUser;

/**
 *	通过className初始化BmobQuery对象
 *
 *	@param	className	对象名称（数据库表名）
 *
 *	@return	BmobQuery查询对象
 */
-(id)initWithClassName:(NSString *)className;


#pragma mark sort

/**
 *	按key进行升序排序
 *
 *	@param	key	键
 */
- (void)orderByAscending:(NSString *)key ;

/**
 *	按key进行降序排序
 *
 *	@param	key	键
 */
- (void)orderByDescending:(NSString *)key ;


#pragma mark == !=  > >= < <=  == in  notin

/**
 *	添加key的值等于object的约束条件
 *
 *	@param	key	键
 *	@param	object	提供的值
 */
- (void)whereKey:(NSString *)key equalTo:(id)object;

/**
 *	添加key的值不为object的约束条件
 *
 *	@param	key	键
 *	@param	object	提供的值
 */
- (void)whereKey:(NSString *)key notEqualTo:(id)object;


/**
 *	添加key的值大于object的约束条件
 *
 *	@param	key	键
 *	@param	object	提供的值
 */
- (void)whereKey:(NSString *)key greaterThan:(id)object;

/**
 *	添加key的值大于或等于提供的object的约束条件
 *
 *	@param	key	键
 *	@param	object	提供的值
 */
- (void)whereKey:(NSString *)key greaterThanOrEqualTo:(id)object;

/**
 *	添加key的值小于提供的object的约束条件
 *
 *	@param	key	键
 *	@param	object	提供的值
 */
- (void)whereKey:(NSString *)key lessThan:(id)object;

/**
 *	添加key的值小于或等于提供的object的约束条件
 *
 *	@param	key	键
 *	@param	object	提供的值
 */
- (void)whereKey:(NSString *)key lessThanOrEqualTo:(id)object;

/**
 *	添加key的值包含array的约束条件
 *
 *	@param	key	键
 *	@param	array	提供的数组
 */
- (void)whereKey:(NSString *)key containedIn:(NSArray *)array;

/**
 *	添加key的值不包含array的约束条件
 *
 *	@param	key	键
 *	@param	array	提供的数组
 */
- (void)whereKey:(NSString *)key notContainedIn:(NSArray *)array;

/**
 *	添加key的值符合提供的正则表达式的约束条件
 *
 *	@param	key	键
 *	@param	regex	提供的正则表达式
 */
-(void)whereKey:(NSString*)key matchesWithRegex:(NSString*)regex;

/**
 *	添加key的值是以提供的字符串开头的约束条件
 *
 *	@param	key	键
 *	@param	start	提供的字符串
 */
-(void)whereKey:(NSString *)key startWithString:(NSString*)start;

/**
 *	添加key的值是以提供的字符串结尾的约束条件
 *
 *	@param	key	键
 *	@param	end	提供的字符串
 */
-(void)whereKey:(NSString *)key endWithString:(NSString*)end;

/**
 *
 *
 *	@param	key	键
 *	@param	geopoint	位置信息
 */
- (void)whereKey:(NSString *)key nearGeoPoint:(BmobGeoPoint *)geopoint;

/**
 *
 *
 *	@param	key	键
 *	@param	geopoint	位置信息
 *	@param	maxDistance	最大长度（单位：英里）
 */
- (void)whereKey:(NSString *)key nearGeoPoint:(BmobGeoPoint *)geopoint withinMiles:(double)maxDistance;

/**
 *
 *
 *	@param	key	键
 *	@param	geopoint	位置信息
 *	@param	maxDistance	最大长度（单位：公里）
 */
- (void)whereKey:(NSString *)key nearGeoPoint:(BmobGeoPoint *)geopoint withinKilometers:(double)maxDistance;

/**
 *
 *  
 *	@param	key	键
 *	@param	geopoint	位置信息
 *	@param	maxDistance	最大半径
 */
- (void)whereKey:(NSString *)key nearGeoPoint:(BmobGeoPoint *)geopoint withinRadians:(double)maxDistance;


/**
 *
 *
 *	@param	key	键
 *	@param	southwest	西南方向位置
 *	@param	northeast	东北方向位置
 */
- (void)whereKey:(NSString *)key withinGeoBoxFromSouthwest:(BmobGeoPoint *)southwest toNortheast:(BmobGeoPoint *)northeast;

#pragma mark cache method


/**
 *	查看是否有查询的缓存
 *
 *	@return	查询结果 有为YES 没有为NO
 */
- (BOOL)hasCachedResult;

/**
 *	清理查询的缓存
 */
- (void)clearCachedResult;

/**
 *	清理所有查询的缓存
 */
+ (void)clearAllCachedResults;

#pragma mark getObject

/**
 *	通过id查找BmobObject对象
 *
 *	@param	objectId	BmobObject对象的id
 *	@param	block	得到的BmobObject对象
 */
- (void)getObjectInBackgroundWithId:(NSString *)objectId
                              block:(BmobObjectResultBlock)block;

/**
 *	查找BmobObject对象数组
 *
 *	@param	block	得到BmobObject对象数组
 */
- (void)findObjectsInBackgroundWithBlock:(BmobObjectArrayResultBlock)block;


/**
 *	查找表中符合条件的个数
 *
 *	@param	block	得到个数
 */
- (void)countObjectsInBackgroundWithBlock:(BmobIntegerResultBlock)block;


@end
