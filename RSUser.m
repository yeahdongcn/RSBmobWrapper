//
//  RSUser.m
//  BmobWrapperSample
//
//  Created by R0CKSTAR on 3/24/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

#import "RSUser.h"

@interface RSUser ()

@property (nonatomic, strong) NSMutableDictionary *storage;

@end

@implementation RSUser

- (id)init
{
    return [self initWithBmobUser:nil];
}

- (id)initWithBmobUser:(BmobUser *)user
{
    self = [super init];
    if (self) {
        self.storage = [[NSMutableDictionary alloc] init];
        if (user) {
            (self.storage)[kBWUserKey] = user;
        }
    }
    return self;
}

- (void)setBmobUser:(BmobUser *)bmobUser
{
    (self.storage)[kBWUserKey] = bmobUser;
}

- (BmobUser *)bmobUser
{
    return (self.storage)[kBWUserKey];
}

- (NSString *)identifier
{
    return self.bmobUser.objectId;
}

- (void)setUsername:(NSString *)username
{
    (self.storage)[kBWUsernameKey] = username;
}

- (NSString *)username
{
    if (self.bmobUser) {
        return [self.bmobUser objectForKey:kBWUsernameKey];
    }
    return (self.storage)[kBWUsernameKey];
}

- (void)setPassword:(NSString *)password
{
    (self.storage)[kBWPasswordKey] = password;
}

- (NSString *)password
{
    if (self.bmobUser) {
        return [self.bmobUser objectForKey:kBWPasswordKey];
    }
    return (self.storage)[kBWPasswordKey];
}

- (void)setMail:(NSString *)mail
{
    (self.storage)[kBWMailKey] = mail;
}

- (NSString *)mail
{
    if (self.bmobUser) {
        return [self.bmobUser objectForKey:kBWMailKey];
    }
    return (self.storage)[kBWMailKey];
}

- (void)signUpWithCallback:(void(^)(BOOL, NSError *))callback
{
    [RSBmobWrapper signUpWithUserInfo:self.storage withCallback:^(BOOL succeeded, NSError *error) {
        if (callback) {
            callback(succeeded, error);
        }
    }];
}

- (void)signInWithCallback:(void(^)(RSUser *, NSError *))callback
{
    [RSBmobWrapper signInWithUserInfo:self.storage withCallback:^(BmobUser *bmobUser, NSError *error) {
        if (callback) {
            RSUser *user = [[RSUser alloc] initWithBmobUser:bmobUser];
            callback(user, error);
        }
    }];
}

- (void)updateWithCallback:(void(^)(BOOL, NSError *))callback
{
    [RSBmobWrapper updateWithUserInfo:self.storage withCallback:^(BOOL succeeded, NSError *error) {
        if (callback) {
            callback(succeeded, error);
        }
    }];
}

- (void)signOut
{
    [RSBmobWrapper signOutCurrentUser];
}

+ (instancetype)getCurrentUser
{
    BmobUser *user = [RSBmobWrapper getCurrentUser];
    if (user) {
        return [[RSUser alloc] initWithBmobUser:[RSBmobWrapper getCurrentUser]];
    } else {
        return nil;
    }
}

+ (void)resetPasswordByMail:(NSString *)mail
{
    [RSBmobWrapper resetPasswordWithUserInfo:@{kBWMailKey: mail}];
}

+ (void)getUserByIdentifier:(NSString *)identifier
               withCallback:(void (^)(RSUser *))callback;
{
    [RSBmobWrapper getObjectWithClassName:kBWUserClassName withObjectIdentifier:identifier withCallback:^(BmobObject *object, NSError *error) {
        if (callback) {
            BmobUser *bmobUser = (BmobUser *)object;
            if (bmobUser) {
                RSUser *user = [[RSUser alloc] initWithBmobUser:bmobUser];
                callback(user);
            } else {
                callback(nil);
            }
        }
    }];
}

@end
