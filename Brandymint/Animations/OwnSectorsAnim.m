//
//  OwnSectorsAnim.m
//  Brandymint
//
//  Created by denisdbv@gmail.com on 12.03.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import "OwnSectorsAnim.h"

@implementation UIView (OwnSectorsAnim)

-(void) showBrandymintLogo
{
    UIImage *imgLogo = [UIImage imageNamed:@"brandymint_logo_white.png"];
    UIImageView *logo = [[UIImageView alloc] initWithImage:imgLogo];
    logo.alpha = 0.0;
    CGRect rc = logo.frame;
    rc.origin.x = OFFSET_X;
    rc.origin.y = OFFSET_Y;
    logo.frame = rc;
    [self insertSubview:logo atIndex:1];
    
    [UIView animateWithDuration:2.0 animations:^(void)
    {
        logo.alpha = 1.0;
        
    } completion:^(BOOL finished)
    {
        //
    }];
}

-(void) showDevelopersLogo
{
    
}

-(void) showTopLine
{
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0,0, 1,1)];
    line.backgroundColor = [UIColor whiteColor];
    line.alpha = 0.6f;
    [self insertSubview:line atIndex:1];
    
    CGRect rc = line.frame;
    rc.origin.x = OFFSET_X;
    rc.origin.y = OFFSET_Y;
    line.frame = rc;
    
    CGRect rcEnd = rc;
    rcEnd.size.width = self.frame.size.height - OFFSET_X - rc.origin.x;
    
    [UIView animateWithDuration:0.7
                          delay:0.1
                        options: UIViewAnimationCurveEaseOut
                     animations:^{
                         line.frame = rcEnd;
                     }
                     completion:^(BOOL finished){
                         [self showBottomLine];
                     }];
}

-(void) showBottomLine
{
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0,0, 1,1)];
    line.backgroundColor = [UIColor whiteColor];
    line.alpha = 0.6f;
    [self insertSubview:line atIndex:1];
    
    CGRect rc = line.frame;
    rc.origin.x = self.frame.size.height - OFFSET_X - rc.origin.x;
    rc.origin.y = self.frame.size.width - OFFSET_Y;
    line.frame = rc;
    
    [UIView animateWithDuration:0.7
                          delay:0.0
                        options: UIViewAnimationCurveEaseIn
                     animations:^{
                         CGRect rcEnd = rc;
                         rcEnd.origin.x = OFFSET_X;
                         rcEnd.size.width = self.frame.size.height - OFFSET_X*2;
                         line.frame = rcEnd;
                     }
                     completion:^(BOOL finished){
                         //
                     }];
}

@end
