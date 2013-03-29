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

-(id)initWithCoder:(NSCoder *)aDecoder{
    if ((self = [super initWithCoder:aDecoder])){
        
    }
    return self;
}

-(void) fillView:(Bloc*)bloc
{
    icon.image = bloc.icon.data;
    icon.alpha = 0.7;
    titleLabel.text = bloc.title;
    titleLabel.font = [UIFont fontWithName:@"Ubuntu-Bold" size:32];
    titleLabel.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    titleLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
    contentLabel.text = bloc.content;
    contentLabel.font = [UIFont fontWithName:@"Ubuntu" size:17];
    contentLabel.numberOfLines = 0;
    [contentLabel sizeToFit];
}

@end
