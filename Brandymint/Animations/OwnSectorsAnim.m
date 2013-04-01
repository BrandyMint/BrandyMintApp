//
//  OwnSectorsAnim.m
//  Brandymint
//
//  Created by denisdbv@gmail.com on 12.03.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import "OwnSectorsAnim.h"

const int TAG_BOTTOM_LINE = 100;

const int  OFFSET_X_FROM_LEFT_SIDE = 70;
const int  OFFSET_Y_FROM_TOP_SIDE = 50;

@implementation UIView (OwnSectorsAnim)

-(void) showTopLine
{
    UILabel *devLabel = (UILabel*)[self viewWithTag:2];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0,0, 1,1)];
    line.backgroundColor = [UIColor whiteColor];
    line.alpha = 0.6f;
    [self insertSubview:line atIndex:1];
    
    CGRect rc = line.frame;
    rc.origin.x = devLabel.frame.origin.x + devLabel.frame.size.width + 25;
    rc.origin.y = devLabel.frame.origin.y + (devLabel.frame.size.height/2);
    line.frame = rc;
    
    CGRect rcEnd = rc;
    rcEnd.size.width = self.frame.size.height - OFFSET_X_FROM_LEFT_SIDE - rc.origin.x;
    
    [UIView animateWithDuration:0.7
                          delay:0.1
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         line.frame = rcEnd;
                     }
                     completion:^(BOOL finished){
                        //
                     }];
}


@end
