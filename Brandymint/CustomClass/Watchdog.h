//
//  Watchdog.h
//  Brandymint
//
//  Created by denisdbv@gmail.com on 29.03.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#define kApplicationTimeout 3

#define kApplicationDidTimeoutNotification @"AppTimeOut"

@interface Watchdog : UIApplication
{
    NSTimer     *myidleTimer;
}

-(void)resetIdleTimer;

@end