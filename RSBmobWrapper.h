//
//  RSBmobWrapper.h
//  Property of R0CKSTAR
//
//  Created by R0CKSTAR on 14-2-27.
//  Copyright (c) 2014年 P.D.Q. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <BmobSDK/Bmob.h>
#import <BmobSDK/BmobObject.h>
#import <BmobSDK/BmobFile.h>
#import <BmobSDK/BmobQuery.h>
#import <BmobSDK/BmobUser.h>

extern NSString *const kBmobObjectIdentifier;
extern NSString *const kBmobObjectCreatedAt;
extern NSString *const kBmobObjectUpdatedAt;
extern NSString *const kBmobFileURLPrefix;

extern NSString *const kBWObjectClassNameKey;
extern NSString *const kBWObjectKey;

extern NSString *const kBWUserKey;
extern NSString *const kBWUserClassName;
extern NSString *const kBWUsernameKey;
extern NSString *const kBWPasswordKey;
extern NSString *const kBWMailKey;

/**
 *  RSBmobWrapper provides basic functions wrappers for Bmob SDK
 */
@interface RSBmobWrapper : NSObject

#pragma mark - Register

+ (void)registerBmobWithAppKey:(NSString *)appKey;

#pragma mark - User

+ (BmobUser *)getCurrentUser;

+ (void)signUpWithUserInfo:(NSDictionary *)userInfo
              withCallback:(void(^)(BOOL, NSError *))callback;

+ (void)signInWithUserInfo:(NSDictionary *)userInfo
              withCallback:(void(^)(BmobUser *, NSError *))callback;

+ (void)updateWithUserInfo:(NSDictionary *)userInfo
              withCallback:(void(^)(BOOL, NSError *))callback;

+ (void)resetPasswordWithUserInfo:(NSDictionary *)userInfo;

+ (void)signOutCurrentUser;

#pragma mark - Query

/**
 *  Get a single object by given class name and object identifier
 *
 *  @param className        Given class name
 *  @param objectIdentifier Given object identifier
 *  @param callback         Callback for received data or error
 */
+ (void)getObjectWithClassName:(NSString *)className
          withObjectIdentifier:(NSString *)objectIdentifier
                  withCallback:(void(^)(BmobObject *, NSError *))callback;

/**
 *  Get a set of objects by given class name and preparation block
 *
 *  @param className   Given class name
 *  @param preparation Preparation block for setup the query
 *  @param callback    Callback for received data or error
 */
+ (void)getObjectsWithClassName:(NSString *)className
                withPreparation:(void(^)(BmobQuery *))preparation
                   withCallback:(void(^)(NSArray *, NSError *))callback;

#pragma mark - Save&update

/**
 *  Save or update one Bmob object
 *
 *  @param info     Dictionary of object information
 *  @param callback Finished callback
 */
+ (void)saveObjectWithInfo:(NSDictionary *)info
              withCallback:(void(^)(BmobObject *, BOOL, NSError *))callback;

#pragma mark - Delete

/**
 *  Delete one Bmob object
 *
 *  @param object   The Bmob object to be deleted
 *  @param callback Finished callback
 */
+ (void)deleteObject:(BmobObject *)object
        withCallback:(void(^)(BOOL, NSError *))callback;

@end
