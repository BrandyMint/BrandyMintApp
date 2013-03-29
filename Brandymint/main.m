//
//  main.m
//  Brandymint
//
//  Created by denisdbv@gmail.com on 07.03.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"
#import "Watchdog.h"

int main(int argc, char *argv[])
{
    @autoreleasepool {
        //[NUISettings init];
        return UIApplicationMain(argc, argv, NSStringFromClass([Watchdog class]), NSStringFromClass([AppDelegate class]));
    }
}
