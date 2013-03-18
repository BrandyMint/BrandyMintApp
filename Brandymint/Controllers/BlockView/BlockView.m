//
//  BlockView.m
//  Brandymint
//
//  Created by DenisDbv on 18.03.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import "BlockView.h"

@implementation BlockView

@synthesize icon;
@synthesize title;
@synthesize content;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void) fillView:(Bloc*)bloc
{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView = (UIImageView*)[self viewWithTag:IMAGETAG];
    UILabel *titleLabel = (UILabel*)[self viewWithTag:TITLETAG];
    UILabel *contentLabel = (UILabel*)[self viewWithTag:CONTENTTAG];
    
    imageView.image = bloc.icon.data;
    titleLabel.text = bloc.title;
    contentLabel.text = bloc.content;
}

@end
