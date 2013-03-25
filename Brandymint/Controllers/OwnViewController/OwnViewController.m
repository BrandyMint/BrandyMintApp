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

@interface OwnViewController ()

@end

@implementation OwnViewController
{
    NSArray *imagesName;
    
    UIImage *btnImageDefault;
    UIImage *btnImageHighlighted;
}

static AboutViewController *aboutController = nil;

@synthesize contextContainerView;
@synthesize cardsScrollView;
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
    
    for (Card *card in [[CardsRepository sharedInstance] entitiesBuffer])
    {
        CardViewController *cardController = [[CardViewController alloc] initCardController:card];
        
        [self addViewToIndexScrollView:cardController.view position:current_pos++];
    }
    
    cardsScrollView.contentSize = CGSizeMake(scrollWidth * current_pos, scrollHeight);
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
    cloudBtn.selected = !cloudBtn.selected;
    cloudBtn.highlighted = !cloudBtn.highlighted;
    
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
    self.cardsScrollView.alpha = 0.0f;

    aboutController = [[AboutViewController alloc] initWithView:self.contextContainerView above:self.cardsScrollView];
    aboutController.delegate = self;
    [aboutController showAboutView];
}

-(void) hideAboutController
{
    [aboutController hideAboutView];
    aboutController = nil;
  
    [self willAboutViewHide];
}

-(void) willAboutViewHide
{
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
