//
//  RSGameScore.h
//  BmobWrapperSample
//
//  Created by R0CKSTAR on 3/24/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

#import "RSObject.h"

extern NSString *const kRSGameScoreClassName;

@interface RSGameScore : RSObject

@property (nonatomic) NSUInteger score;

@property (nonatomic, strong) NSString *userName;

@property (nonatomic) BOOL cheatMode;

@property (nonatomic) NSUInteger age;

- (void)setAvatar:(UIImage *)avatar;

- (void)getAvatarWithCallback:(void(^)(UIImage *))callback;

@end
