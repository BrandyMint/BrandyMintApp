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
    CGFloat scrollViewWidth;
  
    NSMutableArray *thumbsImageViewArray;
  
    NSUInteger lastActivePageIndex;
}

const int THUMB_MARGIN = 120;
const int CONTENT_MARGIN = 40;
const CGFloat THUMB_DIAMETER = 90;
const CGFloat THUMB_ALPHA = 0.4f;

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
    scrollViewWidth = 0;
  
    thumbsImageViewArray = [[NSMutableArray alloc] init];
  
    for (Card *card in [[CardsRepository sharedInstance] entitiesBuffer])
    {
      UIImageView *thumbImageView = [[UIImageView alloc] initWithImage:card.image.thumb];
      thumbImageView.bounds = CGRectMake(0, 0, THUMB_DIAMETER, THUMB_DIAMETER);
      thumbImageView.layer.cornerRadius = THUMB_DIAMETER/2;
      thumbImageView.contentMode = UIViewContentModeScaleAspectFill;
      thumbImageView.clipsToBounds = true;
      thumbImageView.tag = current_pos;
      thumbImageView.alpha = THUMB_ALPHA;
      
      [thumbsImageViewArray addObject:thumbImageView];
      
      [self addViewToIndexScrollView:thumbImageView position:current_pos++];
      
      [self setHookOnThumbClick:thumbImageView];
    }
  
    if([[CardsRepository sharedInstance] entitiesBuffer].count > 0)
      [self resizeAndCenterRootView];
}

-(void) addViewToIndexScrollView:(UIImageView*)imageView position:(NSUInteger)index
{
    scrollViewWidth += (imageView.frame.size.width + THUMB_MARGIN);
  
    CGRect frame;
    frame.origin.x = index * (imageView.frame.size.width + THUMB_MARGIN);
    frame.origin.y = 0;
    frame.size.width = imageView.frame.size.width;
    frame.size.height = imageView.frame.size.height;
    
    imageView.frame = frame;
    
    [thumbsScrollView addSubview:imageView];
}

-(void) resizeAndCenterRootView
{
    CGRect containerViewRect = self.frame;
    CGRect superViewRect = self.superview.frame;
  
    UIImageView *thumbImage = [thumbsImageViewArray objectAtIndex: [thumbsImageViewArray count]-1 ];
    CGFloat contentWidth = thumbImage.frame.origin.x+thumbImage.frame.size.width;
    thumbsScrollView.contentSize = CGSizeMake(contentWidth+1, thumbsScrollView.frame.size.height);
  
    if(contentWidth > superViewRect.size.width)
    {
        containerViewRect.size.width = superViewRect.size.width;
        containerViewRect.origin.x = 0;
    }
    else
    {
        containerViewRect.size.width = contentWidth;
        containerViewRect.origin.x = (superViewRect.size.width - containerViewRect.size.width)/2;
    }
  
    self.frame = containerViewRect;
}

-(void) setActivePage:(NSUInteger)pageIndex
{
    if(pageIndex < thumbsImageViewArray.count)
    {
        UIImageView *lastImageThumb = [thumbsImageViewArray objectAtIndex:lastActivePageIndex];
        lastImageThumb.alpha = THUMB_ALPHA;
      
        UIImageView *imageThumb = [thumbsImageViewArray objectAtIndex:pageIndex];
        imageThumb.alpha = 1.0f;
      
        lastActivePageIndex = pageIndex;
      
        [thumbsScrollView scrollRectToVisible:imageThumb.frame animated:YES];
      

  
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
  
    NSUInteger thumbIndex = (NSUInteger)thumbImageView.tag;
  
    [((OwnViewController*)self.delegate) setActivePage:thumbIndex];
  
    [self setActivePage:thumbIndex];
}

-(void) showThumbView
{
    [UIView animateWithDuration:0.2
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                       self.alpha = 1;
                     }
                     completion:^(BOOL finished){
                       //
                     }];
}

-(void) hideThumbView
{
    [UIView animateWithDuration:0.2
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                       self.alpha = 0;
                     }
                     completion:^(BOOL finished){
                       //
                     }];
}

@end
