//
//  BmobObject.h
//  BmobSDK
//
//  Created by donson on 13-8-1.
//  Copyright (c) 2013年 donson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BmobConfig.h"

@interface BmobObject : NSObject


/**
 *	 BmobObject对象的id
 */
@property(nonatomic,retain)NSString *objectId;

/**
 *	 BmobObject对象的最后更新时间
 */
@property(nonatomic,retain)NSDate *updatedAt;

/**
 *	 BmobObject对象的生成时间
 */
@property(nonatomic,retain)NSDate *createdAt;

/**
 *	创建一个带有className的BmobObject对象
 *
 *	@param	className	表示对象名称(类似数据库表名)
 *
 *	@return	BmobObject
 */
+(BmobObject*)objectWithClassName:(NSString*)className;

/**
 *	通过对象名称（类似数据库表名）初始化BmobObject对象
 *
 *	@param	className	表示对象名称(类似数据库表名)
 *
 *	@return	BmobObject
 */
-(id)initWithClassName:(NSString*)className;

/**
 *	向BmobObject对象添加数据
 *
 *	@param	obj	数据
 *	@param	aKey	键
 */
-(void)setObject:(id)obj forKey:(NSString*)aKey;



/**
 *  批量向BmobObject添加数据,可与 -(void)setObject:(id)obj forKey:(NSString*)aKey;一同使用
 *
 *  @param dic 数据
 */
-(void)saveAllWithDictionary:(NSDictionary*)dic;

/**
 *	得到BombObject对象某个键的值
 *
 *	@param	aKey	键
 *
 *	@return	该键的值
 */
-(id)objectForKey:(id)aKey;

/**
 *	后台保存BmobObject对象，没有返回结果
 */
-(void)saveInBackground;

/**
 *	后台保存BmobObject对象，返回保存的结果
 *
 *	@param	block	返回保存的结果是成功还是失败
 */
-(void)saveInBackgroundWithResultBlock:(BmobBooleanResultBlock)block;

/**
 *	后台更新BmobObject对象，没有返回结果
 */
-(void)updateInBackground;

/**
 *	后台更新BmobObject对象
 *
 *	@param	block	返回更新的结果是成功还是失败
 */
-(void)updateInBackgroundWithResultBlock:(BmobBooleanResultBlock)block;

/**
 *	后台删除BmobObject对象，没有返回结果
 */
-(void)deleteInBackground;

/**
 *	后台删除BmobObject对象
 *
 *	@param	block	返回删除的结果是成功还是失败
 */
-(void)deleteInBackgroundWithBlock:(BmobBooleanResultBlock)block;

@end
