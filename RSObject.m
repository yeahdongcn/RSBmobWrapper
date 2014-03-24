//
//  RSObject.m
//  Property of R0CKSTAR
//
//  Created by R0CKSTAR on 14-2-27.
//  Copyright (c) 2014年 P.D.Q. All rights reserved.
//

#import "RSObject.h"

@interface RSObject ()

@property (nonatomic, strong) NSMutableDictionary *storage;

@end

NSString *const kRSObjectClassName = @"Object";

@implementation RSObject

- (id)init
{
    return [self initWithBmobObject:nil];
}

- (id)initWithBmobObject:(BmobObject *)object
{
    return [self initWithClassName:kRSObjectClassName withBmobObject:object];
}

- (id)initWithClassName:(NSString *)className withBmobObject:(BmobObject *)object
{
    self = [super init];
    if (self) {
        self.storage = [[NSMutableDictionary alloc] init];
        if (object) {
            [self.storage setObject:object forKey:kBWObjectKey];
        }
        [self.storage setObject:className forKey:kBWObjectClassNameKey];
    }
    return self;
}

- (NSString *)identifier
{
    if (self.bmobObject) {
        return self.bmobObject.objectId;
    }
    return nil;
}

- (NSString *)className
{
    return [self.storage objectForKey:kBWObjectClassNameKey];
}

- (void)setBmobObject:(BmobObject *)bmobObject
{
    [self.storage setObject:bmobObject forKey:kBWObjectKey];
}

- (BmobObject *)bmobObject
{
    return [self.storage objectForKey:kBWObjectKey];
}

- (void)saveWithCallback:(void(^)(BmobObject *, BOOL, NSError *))callback
{
    [RSBmobWrapper saveObjectWithInfo:self.storage withCallback:^(BmobObject *object, BOOL succeeded, NSError *error) {
        if (callback) {
            callback(object, succeeded, error);
        }
    }];
}

- (void)deleteWithCallback:(void(^)(BOOL, NSError *))callback
{
    [RSBmobWrapper deleteObject:self.bmobObject withCallback:^(BOOL succeeded, NSError *error) {
        if (callback) {
            callback(succeeded, error);
        }
    }];
}

@end
