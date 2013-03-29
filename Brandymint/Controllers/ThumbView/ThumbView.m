//
//  ThumbView.m
//  Brandymint
//
//  Created by denisdbv@gmail.com on 28.03.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import "ThumbView.h"
#import "OwnViewController.h"

@implementation ThumbView
{
    NSMutableArray *thumbsImageViewArray;
  
    NSUInteger lastActivePageIndex;
}

const int MARGIN_THUMB = 25;

@synthesize thumbsScrollView;

-(id)initWithCoder:(NSCoder *)aDecoder{
  if ((self = [super initWithCoder:aDecoder])){
      
  }
  return self;
}

-(void) layoutSubviews
{
    [self fillContent];
}

-(void) fillContent
{
    unsigned int current_pos = 0;
  
    thumbsImageViewArray = [[NSMutableArray alloc] init];
  
    for (Card *card in [[CardsRepository sharedInstance] entitiesBuffer])
    {
      UIImageView *thumbImageView = [[UIImageView alloc] initWithImage:card.image.thumb];
      thumbImageView.tag = current_pos;
      thumbImageView.alpha = 0.7f;
      
      [thumbsImageViewArray addObject:thumbImageView];
      
      [self addViewToIndexScrollView:thumbImageView position:current_pos++];
      
      [self setHookOnThumbClick:thumbImageView];
    }
}

-(void) addViewToIndexScrollView:(UIImageView*)imageView position:(NSUInteger)index
{
    CGRect frame;
    frame.origin.x = index * (imageView.frame.size.width + MARGIN_THUMB);
    frame.origin.y = 0;
    frame.size.width = imageView.frame.size.width;
    frame.size.height = imageView.frame.size.height;
    
    imageView.frame = frame;
    
    [self.thumbsScrollView addSubview:imageView];
}

-(void) setActivePage:(NSUInteger)pageIndex
{
    if(pageIndex < thumbsImageViewArray.count)
    {
        UIImageView *lastImageThumb = [thumbsImageViewArray objectAtIndex:lastActivePageIndex];
        lastImageThumb.alpha = 0.7f;
      
        UIImageView *imageThumb = [thumbsImageViewArray objectAtIndex:pageIndex];
        imageThumb.alpha = 1.0f;
      
        lastActivePageIndex = pageIndex;
    }
}

-(void) setHookOnThumbClick:(UIImageView*)thumbImage
{
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(thumbTaped:)];
    singleTap.numberOfTapsRequired = 1;
  
    singleTap.numberOfTouchesRequired = 1;
    
    [thumbImage addGestureRecognizer:singleTap];
    
    [thumbImage setUserInteractionEnabled:YES];
}

-(void) thumbTaped:(UITapGestureRecognizer *)gestureRecognizer
{
    UIImageView *thumbImageView = (UIImageView*)gestureRecognizer.view;
  
    NSUInteger thumbIndex = thumbImageView.tag;
  
    [((OwnViewController*)self.delegate) setActivePage:thumbIndex];
  
    [self setActivePage:thumbIndex];
}

@end
