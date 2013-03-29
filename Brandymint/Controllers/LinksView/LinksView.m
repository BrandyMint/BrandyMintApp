//
//  LinksView.m
//  Brandymint
//
//  Created by DenisDbv on 19.03.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import "LinksView.h"
#import "Link.h"
#import "AppDelegate.h"
#import "WebViewController.h"

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
    icon.alpha = 0.7;
    for (Link *link in [[LinksRepository sharedInstance] entitiesBuffer])
    {
        UIButton * btnLink = (UIButton*)[buttonsContainer viewWithTag: link.position.integerValue ];
        if([btnLink isKindOfClass:[UIButton class]])  {
          
            [btnLink setTitle:link.title forState:UIControlStateNormal];
            btnLink.tag = [link.position integerValue];
            [btnLink addTarget:self action:@selector(onClickLink:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
}

-(void) onClickLink:(id)sender
{
    UIButton *btnLink = (UIButton*)sender;
  
    NSPredicate* searchPredicate = [NSPredicate predicateWithFormat:@"position == %i", btnLink.tag];
    NSArray *linkArray = [[[LinksRepository sharedInstance] entitiesBuffer] filteredArrayUsingPredicate: searchPredicate];
    if(linkArray.count > 0)
    {
        Link *link = [linkArray objectAtIndex:0];
        WebViewController *webViewController = [[WebViewController alloc] initWithURL:link.url];
        [((AppDelegate*)[[UIApplication sharedApplication] delegate]) presentModalViewController:webViewController];
    }
}

@end
