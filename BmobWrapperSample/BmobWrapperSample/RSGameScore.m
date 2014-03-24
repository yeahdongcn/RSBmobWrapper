//
//  RSGameScore.m
//  BmobWrapperSample
//
//  Created by R0CKSTAR on 3/24/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

#import "RSGameScore.h"

#import <AFNetworking.h>

NSString *const kRSGameScoreClassName = @"GameScore";
NSString *const kRSGameScoreAvatarKey = @"avatar";

@implementation RSGameScore

- (id)initWithBmobObject:(BmobObject *)object
{
    return [self initWithClassName:kRSGameScoreClassName withBmobObject:object];
}

- (void)setScore:(NSUInteger)score
{
    (self.storage)[PropertyName(self.score)] = @(score);
}

- (NSUInteger)score
{
    if (self.bmobObject) {
        return [[self.bmobObject objectForKey:PropertyName(self.score)] unsignedIntegerValue];
    }
    return [(self.storage)[PropertyName(self.score)] unsignedIntegerValue];
}

- (void)setUserName:(NSString *)userName
{
    (self.storage)[PropertyName(self.userName)] = userName;
}

- (NSString *)userName
{
    if (self.bmobObject) {
        return [self.bmobObject objectForKey:PropertyName(self.userName)];
    }
    return (self.storage)[PropertyName(self.userName)];
}

- (void)setCheatMode:(BOOL)cheatMode
{
    (self.storage)[PropertyName(self.cheatMode)] = @(cheatMode);
}

- (BOOL)cheatMode
{
    if (self.bmobObject) {
        return [[self.bmobObject objectForKey:PropertyName(self.cheatMode)] boolValue];
    }
    return [(self.storage)[PropertyName(self.cheatMode)] boolValue];
}

- (void)setAge:(NSUInteger)age
{
    (self.storage)[PropertyName(self.age)] = @(age);
}

- (NSUInteger)age
{
    if (self.bmobObject) {
        return [[self.bmobObject objectForKey:PropertyName(self.age)] unsignedIntegerValue];
    }
    return [(self.storage)[PropertyName(self.age)] unsignedIntegerValue];
}

- (void)setAvatar:(UIImage *)avatar
{
    (self.storage)[kRSGameScoreAvatarKey] = UIImagePNGRepresentation(avatar);
}

- (void)getAvatarWithCallback:(void (^)(UIImage *))callback
{
    if (self.bmobObject) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            BmobFile *file = [self.bmobObject objectForKey:kRSGameScoreAvatarKey];
            NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kBmobFileURLPrefix, file.url]];
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
            [request addValue:@"image/*" forHTTPHeaderField:@"Accept"];
            AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
            requestOperation.responseSerializer = [AFImageResponseSerializer serializer];
            [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                if (callback) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        callback(responseObject);
                    });
                }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                if (callback) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        callback(nil);
                    });
                }
            }];
            [[AFHTTPRequestOperationManager manager].operationQueue addOperation:requestOperation];
        });
    } else if (callback) {
        callback([[UIImage alloc] initWithData:(self.storage)[kRSGameScoreAvatarKey]]);
    }
}

@end
