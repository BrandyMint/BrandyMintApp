//
//  BMLinkButton.m
//  Brandymint
//
//  Created by denisdbv@gmail.com on 26.03.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import "BMLinkButton.h"

@implementation BMLinkButton

-(id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if(self){
    [self initialize];
  }
  return self;
}

-(void)initialize
{
    self.titleLabel.font = [UIFont fontWithName:@"Ubuntu" size:30];
    self.titleLabel.textAlignment = UITextAlignmentLeft;
    self.titleLabel.shadowColor = [UIColor blackColor];
    self.titleLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
    self.backgroundColor = [UIColor clearColor];
    
    UIImage * rightIcon = [UIImage imageNamed:@"icon-right.png"];
    UIImageView *rightIconView = [[UIImageView alloc] initWithFrame:CGRectMake(312,18,7,12)];
    rightIconView.alpha = 0.7f;
    [rightIconView setImage:rightIcon];
    UIView * separator = [[UIView alloc] initWithFrame:CGRectMake(0, 48, 320, 1)];
    separator.backgroundColor = [UIColor colorWithWhite:1 alpha:0.1];
    [self addSubview:separator];
    [self addSubview:rightIconView];
}
@end
