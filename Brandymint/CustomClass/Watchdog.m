//
//  Watchdog.m
//  Brandymint
//
//  Created by denisdbv@gmail.com on 29.03.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import "Watchdog.h"

@implementation Watchdog

-(void)sendEvent:(UIEvent *)event
{
    [super sendEvent:event];
  
    if (!myidleTimer)
    {
        [self resetIdleTimer];
    }
    
    NSSet *allTouches = [event allTouches];
    if ([allTouches count] > 0)
    {
        UITouchPhase phase = ((UITouch *)[allTouches anyObject]).phase;
        if (phase == UITouchPhaseBegan)
        {
            [self resetIdleTimer];
        }
    }
}

-(void)resetIdleTimer
{
    if(myidleTimer)
    {
        [myidleTimer invalidate];
    }
    
    myidleTimer = [NSTimer scheduledTimerWithTimeInterval:kApplicationTimeout target:self selector:@selector(idleTimerExceeded) userInfo:nil repeats:YES];
}

-(void)idleTimerExceeded
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kApplicationDidTimeoutNotification object:nil];
}

@end
