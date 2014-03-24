//
//  main.m
//  BmobWrapperSample
//
//  Created by R0CKSTAR on 3/24/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RSAppDelegate.h"

#import "RSBmobWrapper.h"

int main(int argc, char * argv[])
{
    // TODO: Replace the application key with your own.
    [RSBmobWrapper registerBmobWithAppKey:@"5334e9c33ced5740f1328a30c8f3f75b"];
    
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([RSAppDelegate class]));
    }
}
