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

-(void) showBrandymintLogo
{
    UIImage *imgLogo = [UIImage imageNamed:@"brandymint_logo_white.png"];
    UIImageView *logo = [[UIImageView alloc] initWithImage:imgLogo];
    logo.alpha = 0.0;
    CGRect rc = logo.frame;
    rc.origin.x = OFFSET_X_FROM_LEFT_SIDE;
    rc.origin.y = OFFSET_Y_FROM_TOP_SIDE;
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
    UIImage *imgLogo = [UIImage imageNamed:@"brandymint_logo_white.png"];
    
    UILabel *devLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    devLabel.tag = 2;
    devLabel.font = [[ThemeProvider sharedThemeProvider] lightFont:15];
    devLabel.textColor = [UIColor whiteColor];
    devLabel.backgroundColor = [UIColor clearColor];
    devLabel.text = @"DEVELOPERS";
    [devLabel sizeToFit];
    devLabel.alpha = 0.0;
    devLabel.frame = CGRectMake(OFFSET_X_FROM_LEFT_SIDE + imgLogo.size.width + 10, (OFFSET_Y_FROM_TOP_SIDE + imgLogo.size.height) - devLabel.frame.size.height - 3, devLabel.frame.size.width, devLabel.frame.size.height);
    [self insertSubview:devLabel atIndex:1];
    
    [UIView animateWithDuration:1.0
                          delay:0.2
                        options: 0
                     animations:^{
                         devLabel.alpha = 0.8;
                     }
                     completion:^(BOOL finished){
                         //
                     }];
}

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
                         [self showBottomLine];
                     }];
}

-(void) showBottomLine
{
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0,0, 1,1)];
    line.backgroundColor = [UIColor whiteColor];
    line.alpha = 0.6f;
    line.tag = TAG_BOTTOM_LINE;
    [self insertSubview:line atIndex:1];
    
    CGRect rc = line.frame;
    rc.origin.x = self.frame.size.height - OFFSET_X_FROM_LEFT_SIDE - rc.origin.x;
    rc.origin.y = self.frame.size.width - OFFSET_Y_FROM_TOP_SIDE;
    line.frame = rc;
    
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         CGRect rcEnd = rc;
                         rcEnd.origin.x = OFFSET_X_FROM_LEFT_SIDE;
                         rcEnd.size.width = self.frame.size.height - OFFSET_Y_FROM_TOP_SIDE*2;
                         line.frame = rcEnd;
                     }
                     completion:^(BOOL finished){
                         //
                     }];
}

-(void) hideBottomLine:(void(^)(BOOL finished))finishBlock
{
    UIView *line = [self viewWithTag:TAG_BOTTOM_LINE];
    
    if(line != nil)
    {
        CGRect rc = line.frame;
        
        [UIView animateWithDuration:0.2
                              delay:0.0
                            options: UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             CGRect rcEnd = rc;
                             rcEnd.origin.x = self.frame.size.height - OFFSET_X_FROM_LEFT_SIDE - rc.origin.x;
                             rcEnd.size.width = 0;
                             line.frame = rcEnd;
                         }
                         completion:^(BOOL finished){
                             [line removeFromSuperview];
                             
                             finishBlock(finished);
                         }];
    }
}

@end
