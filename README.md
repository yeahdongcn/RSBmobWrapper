BmobWrapper
===========

#突然发现AVOS[https://cn.avoscloud.com/]这些功能都实现了！！！


提供了新的基类和Bmob相关内容的封装，好处在于减少了UI层面key－value的操作，直接可以用property中定义的名字get/set值。

统一了存储和更新，因为存储和更新对我们来说都是存，区分这俩感觉有点外行，不过这接口和Parse的确实是一样，不管他们怎么想我需要的是统一的接口。

例子已经上传。

    // 0. SAVE
    __block RSGameScore *gs0 = [[RSGameScore alloc] init];
    gs0.score = 1200;
    gs0.userName = @"xiaoming";
    gs0.cheatMode = NO;
    gs0.age = 18;
    [gs0 saveWithCallback:^(BmobObject *bmobObject, BOOL succeeded, NSError *error) {
        if (bmobObject) {
            gs0 = [[RSGameScore alloc] initWithBmobObject:bmobObject];
            NSLog(@"gs0 save succeeded = %d, error = %@", succeeded, error);
            NSLog(@"gs0 score=%d", gs0.score);
            NSLog(@"gs0 userName=%@", gs0.userName);
            NSLog(@"gs0 cheatMode=%d", gs0.cheatMode);
            NSLog(@"gs0 age=%d", gs0.age);
        }
    }];
    
    // 1. SAVE THEN DELETE
    __block RSGameScore *gs1 = [[RSGameScore alloc] init];
    gs1.score = 1500;
    gs1.userName = @"xiaozhang";
    gs1.cheatMode = NO;
    gs1.age = 20;
    [gs1 saveWithCallback:^(BmobObject *bmobObject, BOOL succeeded, NSError *error) {
        if (bmobObject) {
            gs1 = [[RSGameScore alloc] initWithBmobObject:bmobObject];
            NSLog(@"gs1 save succeeded = %d, error = %@", succeeded, error);
            NSLog(@"gs1 score=%d", gs1.score);
            NSLog(@"gs1 userName=%@", gs1.userName);
            NSLog(@"gs1 cheatMode=%d", gs1.cheatMode);
            NSLog(@"gs1 age=%d", gs1.age);
            [gs1 deleteWithCallback:^(BOOL succeeded, NSError *error) {
                NSLog(@"gs1 delete succeeded = %d, error = %@", succeeded, error);
            }];
        }
    }];
    
    // 2. SAVE THEN UPDATE
    __block RSGameScore *gs2 = [[RSGameScore alloc] init];
    gs2.score = 1800;
    gs2.userName = @"xiaowang";
    gs2.cheatMode = NO;
    gs2.age = 22;
    [gs2 saveWithCallback:^(BmobObject *bmobObject, BOOL succeeded, NSError *error) {
        if (bmobObject) {
            gs2 = [[RSGameScore alloc] initWithBmobObject:bmobObject];
            NSLog(@"gs2 save succeeded = %d, error = %@", succeeded, error);
            NSLog(@"gs2 score=%d", gs2.score);
            NSLog(@"gs2 userName=%@", gs2.userName);
            NSLog(@"gs2 cheatMode=%d", gs2.cheatMode);
            NSLog(@"gs2 age=%d", gs2.age);
            gs2.age = 100;
            [gs2 saveWithCallback:^(BmobObject *bmobObject, BOOL succeeded, NSError *error) {
                gs2 = [[RSGameScore alloc] initWithBmobObject:bmobObject];
                NSLog(@"gs2 age=%d", gs2.age);
            }];
        }
    }];
    
    // 3. QUERY
    [RSBmobWrapper getObjectsWithClassName:kRSGameScoreClassName withPreparation:nil
                              withCallback:^(NSArray *list, NSError *error) {
                                  NSLog(@"QUERY>>>>>");
                                  for (BmobObject *object in list) {
                                      RSGameScore *gs = [[RSGameScore alloc] initWithBmobObject:object];
                                      NSLog(@"gs score=%d", gs.score);
                                      NSLog(@"gs userName=%@", gs.userName);
                                      NSLog(@"gs cheatMode=%d", gs.cheatMode);
                                      NSLog(@"gs age=%d", gs.age);
                                  }
                                  NSLog(@"<<<<<QUERY");
                              }];
    
    // 4. QUERY WITH CONDITIONS
    [RSBmobWrapper getObjectsWithClassName:kRSGameScoreClassName withPreparation:^(BmobQuery *bmobQuery) {
        [bmobQuery whereKey:@"age" lessThan:[NSNumber numberWithInt:20]];
    } withCallback:^(NSArray *list, NSError *error) {
        NSLog(@"QUERY WITH CONDITIONS>>>>>");
        for (BmobObject *object in list) {
            RSGameScore *gs = [[RSGameScore alloc] initWithBmobObject:object];
            NSLog(@"gs score=%d", gs.score);
            NSLog(@"gs userName=%@", gs.userName);
            NSLog(@"gs cheatMode=%d", gs.cheatMode);
            NSLog(@"gs age=%d", gs.age);
        }
        NSLog(@"<<<<<QUERY WITH CONDITIONS");
    }];
    
    // 5. SAVE OBJECT WITH DATA AND QUERY BACK WITH IDENTIFIER
    __block RSGameScore *gs3 = [[RSGameScore alloc] init];
    gs3.score = 2100;
    gs3.userName = @"xiaoli";
    gs3.cheatMode = NO;
    gs3.age = 25;
    gs3.avatar = [UIImage imageNamed:@"avatar"];
    [gs3 saveWithCallback:^(BmobObject *bmobObject, BOOL succeeded, NSError *error) {
        if (bmobObject) {
            gs3 = [[RSGameScore alloc] initWithBmobObject:bmobObject];
            [RSBmobWrapper getObjectWithClassName:gs3.className withObjectIdentifier:gs3.identifier withCallback:^(BmobObject *bmobObject, NSError *error) {
                gs3 = [[RSGameScore alloc] initWithBmobObject:bmobObject];
                NSLog(@"gs3 score=%d", gs3.score);
                NSLog(@"gs3 userName=%@", gs3.userName);
                NSLog(@"gs3 cheatMode=%d", gs3.cheatMode);
                NSLog(@"gs3 age=%d", gs3.age);
                [gs3 getAvatarWithCallback:^(UIImage *avatar) {
                    NSLog(@"gs3 avatar=%@", avatar);
                }];
            }];
        }
    }];
    
    // 6. USER
    __block RSUser *user0 = [[RSUser alloc] init];
    user0.username = @"R0CKSTAR";
    user0.mail = @"yeahdongcn@gmail.com";
    user0.password = @"12345678";
    [user0 signUpWithCallback:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [user0 signInWithCallback:^(RSUser *aUser, NSError *error) {
                user0 = aUser;
                NSLog(@"user0 username=%@", user0.username);
                NSLog(@"user0 mail=%@", user0.mail);
            }];
            
            __block RSUser *user1 = [RSUser getCurrentUser];
            [RSUser getUserByIdentifier:user1.identifier withCallback:^(RSUser *aUser) {
                user1 = aUser;
                NSLog(@"user1 username=%@", user1.username);
                NSLog(@"user1 mail=%@", user1.mail);
            }];
        } else {
            NSLog(@"%@", [error userInfo]);
        }
    }];

