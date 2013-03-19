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
    NSUInteger linksCount = [LinksRepository sharedLinksRepository].entitiesBuffer.count;

    for(NSInteger loop = 0; loop < linksCount; loop++)
    {
        Link *link = [[LinksRepository sharedLinksRepository].entitiesBuffer objectAtIndex: (NSUInteger)loop ];
        
        UIButton * btnLink = (UIButton*)[buttonsContainer viewWithTag: loop+1 ];
        if([btnLink isKindOfClass:[UIButton class]])  {
            
            [btnLink setTitle:link.title forState:UIControlStateNormal];
            btnLink.titleLabel.font = [UIFont fontWithName:@"Ubuntu-Light" size:32];
            btnLink.titleLabel.textAlignment = UITextAlignmentLeft;
            btnLink.titleLabel.shadowColor = [UIColor blackColor];
            btnLink.titleLabel.shadowOffset = CGSizeMake(0.0f, -1.0f);
            btnLink.backgroundColor = [UIColor clearColor];
        }
    }
}

@end
