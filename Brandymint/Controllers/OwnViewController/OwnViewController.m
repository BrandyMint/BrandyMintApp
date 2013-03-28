//
//  OwnViewController.m
//  Brandymint
//
//  Created by denisdbv@gmail.com on 07.03.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import "OwnViewController.h"
#import "CardViewController.h"
#import "AboutViewController.h"
#import "OwnSectorsAnim.h"
#import "Card.h"
#import "CardsRepository.h"
#import "Bloc.h"

//
//
#define GetFullPath(_filePath_) [[NSBundle mainBundle] pathForResource:[_filePath_ lastPathComponent] ofType:nil inDirectory:[_filePath_ stringByDeletingLastPathComponent]]
//
//

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

@interface OwnViewController ()

@end

@implementation OwnViewController
{
    NSArray *imagesName;
    
    UIImage *btnImageDefault;
    UIImage *btnImageHighlighted;
  
    NSMutableArray *cardControllersArray;
}

static AboutViewController *aboutController = nil;

@synthesize contextContainerView;
@synthesize cardsScrollView;
@synthesize pageControl;
@synthesize cloudBtn;
@synthesize logo;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self performSelector:@selector(initScrollCards) withObject:nil afterDelay:0];
}

-(void) viewWillAppear:(BOOL)animated
{
    [self setHookOnLogoClick];
  
    pageControl.alpha = 0.0f;
  
    btnImageDefault = [cloudBtn backgroundImageForState:UIControlStateNormal];
    btnImageHighlighted = [cloudBtn backgroundImageForState:UIControlStateHighlighted];
    
    self.cardsScrollView.backgroundColor = [UIColor clearColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

-(void) setHookOnLogoClick
{
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(logoTaped:)];
    singleTap.numberOfTapsRequired = 1;

    singleTap.numberOfTouchesRequired = 1;

    [self.logo addGestureRecognizer:singleTap];

    [self.logo setUserInteractionEnabled:YES];
}

-(void) initScrollCards
{
    NSInteger scrollWidth = (NSInteger)self.cardsScrollView.frame.size.width;
    NSInteger scrollHeight = (NSInteger)self.cardsScrollView.frame.size.height;
    
    unsigned int current_pos = 0;
    cardControllersArray = [[NSMutableArray alloc] init];
    
    for (Card *card in [[CardsRepository sharedInstance] entitiesBuffer])
    {
        CardViewController *cardController = [[CardViewController alloc] initCardController:card];
        [cardControllersArray addObject:cardController];
        
        [self addViewToIndexScrollView:cardController.view position:current_pos++];
    }
    
    cardsScrollView.contentSize = CGSizeMake(scrollWidth * current_pos, scrollHeight);
  
    pageControl.currentPage = 0;
    pageControl.numberOfPages = current_pos;
  
    [self updatePageAlpha:0];
}

- (void)scrollViewDidScroll:(UIScrollView *)sender
{  
    CGFloat pageWidth = self.cardsScrollView.frame.size.width;
    CGFloat scrollOfs = self.cardsScrollView.contentOffset.x;
    
    NSInteger curPageIndex = (NSInteger)(floor(scrollOfs/pageWidth - 0.5) + 1);
  
    pageControl.currentPage = curPageIndex;
    
    CGFloat pageOfs = scrollOfs/pageWidth - curPageIndex; // -0.5..0.5
    
    CardViewController *cardController = [cardControllersArray objectAtIndex:(NSUInteger)curPageIndex];
    cardController.view.alpha = 1.0 - fabs(pageOfs);
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
      //show page control
      [self pageControlAlphaShow];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
      //hide page control
      [self pageControlAlphaHide];
}

-(void) pageControlAlphaShow
{
    CGFloat timeElapsed = 0.8f * pageControl.alpha;
  
    [UIView animateWithDuration:timeElapsed
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                        pageControl.alpha = 1.0;
                     }
                     completion:^(BOOL finished){
                       
                     }];
}

-(void) pageControlAlphaHide
{
  CGFloat timeElapsed = 0.5f * pageControl.alpha;
  
  [UIView animateWithDuration:timeElapsed
                        delay:0.4
                      options: UIViewAnimationOptionCurveEaseIn
                   animations:^{
                     pageControl.alpha = 0.0;
                   }
                   completion:^(BOOL finished){
                     
                   }];
}

-(void)updatePageAlpha:(NSUInteger)pageIndex
{
    if (pageIndex > 0){
        CardViewController *cardController = [cardControllersArray objectAtIndex: pageIndex-1];
        cardController.view.alpha = 0.5;
    }
    if (pageIndex < cardsScrollView.subviews.count-1){
        CardViewController *cardController = [cardControllersArray objectAtIndex: pageIndex+1];
        cardController.view.alpha = 0.5;
    }
}


-(void) addViewToIndexScrollView:(UIView*)view position:(NSUInteger)index
{
    CGRect frame;
    frame.origin.x = (index * self.cardsScrollView.frame.size.width);
    frame.origin.y = 0;
    frame.size.width = view.frame.size.width;
    frame.size.height = view.frame.size.height;
    
    view.frame = frame;
    
    [self.cardsScrollView addSubview:view];
}

-(void) onCloudClick:(id)sender
{
    if(aboutController == nil)  {
        [self showAboutController];
    }
    else    {
        [self hideAboutController];
    }
}

-(void) logoTaped:(id)sender
{
    if(aboutController != nil)
    {
        [self hideAboutController];
        [self scrollToFirstPage];
    }
}

-(void) showAboutController
{
    [cloudBtn setImage:[UIImage imageNamed:@"icon-cloud-tap.png"] forState:UIControlStateNormal];
  
    self.cardsScrollView.alpha = 0.0f;

    aboutController = [[AboutViewController alloc] initWithView:self.contextContainerView above:self.cardsScrollView];
    aboutController.delegate = self;
    [aboutController showAboutView];
}

-(void) hideAboutController
{
    [aboutController hideAboutView];
    aboutController = nil;
}

-(void) willAboutViewHide
{
    [cloudBtn setImage:[UIImage imageNamed:@"icon-cloud.png"] forState:UIControlStateNormal];
  
    aboutController = nil;
  
    self.cardsScrollView.alpha = 0.0f;
    
    [UIView animateWithDuration:0.4 animations:^(void)  {
      self.cardsScrollView.alpha = 1.0f;
    }];
}

-(void) scrollToFirstPage
{
    CGRect scrollRect = self.cardsScrollView.frame;

    [self.cardsScrollView scrollRectToVisible:CGRectMake(0,0, scrollRect.size.width,scrollRect.size.height) animated:YES];
}

@end
