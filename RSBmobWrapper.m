//
//  RSBmobWrapper.m
//  Property of R0CKSTAR
//
//  Created by R0CKSTAR on 14-2-27.
//  Copyright (c) 2014年 P.D.Q. All rights reserved.
//

#import "RSBmobWrapper.h"

NSString *const kBmobObjectIdentifier  = @"objectId";
NSString *const kBmobObjectCreatedAt   = @"createdAt";
NSString *const kBmobObjectUpdatedAt   = @"updatedAt";
NSString *const kBmobFilePrefix        = @"http://file.bmob.cn/";

NSString *const kBWObjectClassNameKey  = @"ObjectClassName";
NSString *const kBWObjectKey           = @"Object";
NSString *const kBWFileClassNameKey    = @"File";

NSString *const kBWUserKey             = @"User";
NSString *const kBWUserClassName       = @"User";
NSString *const kBWUsernameKey         = @"username";
NSString *const kBWPasswordKey         = @"password";
NSString *const kBWMailKey             = @"email";

@implementation RSBmobWrapper

+ (instancetype)defaultBmobWrapper
{
    static RSBmobWrapper *defaultBmobWrapper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultBmobWrapper = [[self alloc] init];
    });
    return defaultBmobWrapper;
}

#pragma mark - Register

- (void)registerBmobWithAppKey:(NSString *)appKey
{
    [Bmob registerWithAppKey:appKey];
}

#pragma mark - User

- (BmobUser *)getCurrentUser
{
    return [BmobUser getCurrentObject];
}

- (void)updateBmobUser:(BmobUser *)bmobUser withUserInfo:(NSDictionary *)userInfo
{
    [userInfo enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([key isEqualToString:kBWUsernameKey]) {
            [bmobUser setUserName:obj];
        } else if ([key isEqualToString:kBWPasswordKey]) {
            [bmobUser setPassword:obj];
        } else if ([key isEqualToString:kBWMailKey]) {
            [bmobUser setEamil:obj];
        } else if ([obj isKindOfClass:[NSData class]]) {
            BmobFile *file = [[BmobFile alloc] initWithClassName:kBWFileClassNameKey
                                                    withFileName:key
                                                    withFileData:obj];
            if ([file save]) {
                [bmobUser setObject:file forKey:key];
            }
        } else {
            [bmobUser setObject:obj forKey:key];
        }
    }];
}

- (void)signUpWithUserInfo:(NSDictionary *)userInfo
              withCallback:(void(^)(BOOL, NSError *))callback
{
    BmobUser *user = [[BmobUser alloc] init];
    [self updateBmobUser:user withUserInfo:userInfo];
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (callback) {
            callback(succeeded, error);
        }
    }];
}

- (void)signInWithUserInfo:(NSDictionary *)userInfo
              withCallback:(void(^)(BmobUser *, NSError *))callback
{
    [BmobUser logInWithUsernameInBackground:userInfo[kBWUsernameKey]
                                   password:userInfo[kBWPasswordKey]
                                      block:^(BmobUser *user, NSError *error) {
                                          if (callback) {
                                              callback(user, error);
                                          }
                                      }];
}

- (void)updateWithUserInfo:(NSDictionary *)userInfo
              withCallback:(void(^)(BOOL, NSError *))callback
{
    BmobUser *user = [userInfo objectForKey:kBWUserKey];
    [self updateBmobUser:user withUserInfo:userInfo];
    [user updateInBackgroundWithResultBlock:^(BOOL succeeded, NSError *error) {
        if (callback) {
            callback(succeeded, error);
        }
    }];
}

- (void)resetPasswordWithUserInfo:(NSDictionary *)userInfo
{
    [BmobUser requestPasswordResetInBackgroundWithEmail:userInfo[kBWMailKey]];
}

- (void)signOutCurrentUser
{
    [BmobUser logout];
}

#pragma mark - Query

- (void)getObjectWithClassName:(NSString *)className
          withObjectIdentifier:(NSString *)objectIdentifier
                  withCallback:(void(^)(BmobObject *, NSError *))callback
{
    BmobQuery *query = [BmobQuery queryWithClassName:className];
    [query getObjectInBackgroundWithId:objectIdentifier block:^(BmobObject *object, NSError *error) {
        if (callback) {
            callback(object, error);
        }
    }];
}

- (void)getObjectsWithClassName:(NSString *)className
                withPreparation:(void(^)(BmobQuery *))preparation
                   withCallback:(void(^)(NSArray *, NSError *))callback
{
    BmobQuery *query = [BmobQuery queryWithClassName:className];
    if (preparation) {
        preparation(query);
    }
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (callback) {
            callback(array, error);
        }
    }];
}

#pragma mark - Save&update

- (void)saveObjectWithInfo:(NSDictionary *)info
              withCallback:(void(^)(BmobObject *, BOOL, NSError *))callback
{
    BOOL isUpdate = NO;
    BmobObject *object = [info objectForKey:kBWObjectKey];
    if (object) {  // We have the object itself, update it
        isUpdate = YES;
    } else { // This is a pretty new object, save it
        NSString *className = [info objectForKey:kBWObjectClassNameKey];
        object = [[BmobObject alloc] initWithClassName:className];
    }
    // Go through every key-value pair except BWObject and BWObjectClassName
    [info enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if (!([key isEqualToString:kBWObjectKey] || [key isEqualToString:kBWObjectClassNameKey])) {
            
            if ([obj isKindOfClass:[NSData class]]) {
                BmobFile *file = [[BmobFile alloc] initWithClassName:kBWFileClassNameKey
                                                        withFileName:key
                                                        withFileData:obj];
                if ([file save]) {
                    [object setObject:file forKey:key];
                }
            } else {
                [object setObject:obj forKey:key];
            }
        }
    }];
    
    if (isUpdate) {
        [object updateInBackgroundWithResultBlock:^(BOOL succeeded, NSError *error) {
            if (callback) {
                callback(object, succeeded, error);
            }
        }];
    } else {
        [object saveInBackgroundWithResultBlock:^(BOOL succeeded, NSError *error) {
            if (callback) {
                callback(object, succeeded, error);
            }
        }];
    }
}

#pragma mark - Delete

- (void)deleteObject:(BmobObject *)object
        withCallback:(void(^)(BOOL, NSError *))callback
{
    [object deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (callback) {
            callback(succeeded, error);
        }
    }];
}

@end
