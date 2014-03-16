//
//  RSObject.h
//  Property of R0CKSTAR
//
//  Created by R0CKSTAR on 14-2-27.
//  Copyright (c) 2014年 P.D.Q. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  Basic class for all kinds of data object
 */
@interface RSObject : NSObject

- (id)initWithBmobObject:(BmobObject *)object;

- (id)initWithClassName:(NSString *)className withBmobObject:(BmobObject *)object;

@property (nonatomic, readonly) NSMutableDictionary *storage;

@property (nonatomic, readonly) BmobObject *bmobObject;

@property (nonatomic, readonly) NSString *identifier;

- (void)saveWithCallback:(void(^)(BmobObject *, BOOL, NSError *))callback;

- (void)deleteWithCallback:(void(^)(BOOL, NSError *))callback;

@end
