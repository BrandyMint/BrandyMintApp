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
@synthesize titleLabel;
@synthesize contentLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // init
    }
    return self;
}

-(void) fillView:(Bloc*)bloc
{
    icon.image = bloc.icon.data;
    titleLabel.text = bloc.title;
    contentLabel.text = bloc.content;
}

@end
