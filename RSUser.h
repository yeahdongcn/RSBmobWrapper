//
//  RSUser.h
//  BmobWrapperSample
//
//  Created by R0CKSTAR on 3/24/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RSBmobWrapper.h"

/**
 *  Basic class for all kinds of user
 */
@interface RSUser : NSObject

@property (nonatomic, readonly) NSMutableDictionary *storage;

@property (nonatomic, readonly) BmobUser *bmobUser;

@property (nonatomic, readonly) NSString *identifier;

@property (nonatomic, strong) NSString *username;

@property (nonatomic, strong) NSString *password;

@property (nonatomic, strong) NSString *mail;

- (id)initWithBmobUser:(BmobUser *)user;

- (void)signUpWithCallback:(void(^)(BOOL, NSError *))callback;

- (void)signInWithCallback:(void(^)(RSUser *, NSError *))callback;

- (void)updateWithCallback:(void(^)(BOOL, NSError *))callback;

/**
 *  No callback. Do alert user after calling this
 */
- (void)signOut;

+ (instancetype)getCurrentUser;

/**
 *  No callback. Do alert user after calling this
 */
+ (void)resetPasswordByMail:(NSString *)mail;

/**
 *  Get user object by given identifier, this should be used to get other users' info
 *
 *  @param identifier User identifier
 *  @param user       Callback
 */
+ (void)getUserByIdentifier:(NSString *)identifier
               withCallback:(void (^)(RSUser *))callback;

@end
