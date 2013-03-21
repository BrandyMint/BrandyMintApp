//
//  LinksView.m
//  Brandymint
//
//  Created by DenisDbv on 19.03.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import "LinksView.h"
#import "Link.h"

@implementation LinksView

@synthesize icon;
@synthesize buttonsContainer;

@synthesize btn1, btn2, btn3, btn4;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // init
    }
    return self;
}

-(void) layoutSubviews
{
    for (Link *link in [[LinksRepository sharedLinksRepository] entitiesBuffer])
    {
        UIButton * btnLink = (UIButton*)[buttonsContainer viewWithTag: link.position.integerValue ];
        if([btnLink isKindOfClass:[UIButton class]])  {
            
            [btnLink setTitle:link.title forState:UIControlStateNormal];
            btnLink.titleLabel.font = [[ThemeProvider sharedThemeProvider] lightFont:32];
            btnLink.titleLabel.textAlignment = UITextAlignmentLeft;
            btnLink.titleLabel.shadowColor = [UIColor blackColor];
            btnLink.titleLabel.shadowOffset = CGSizeMake(0.0f, -1.0f);
            btnLink.backgroundColor = [UIColor clearColor];
        }
    }
}

@end
