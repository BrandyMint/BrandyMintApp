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

@synthesize scrollContainer;
@synthesize scrollCards;
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
    
    self.scrollCards.backgroundColor = [UIColor clearColor];
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
    NSInteger scrollWidth = (NSInteger)self.scrollCards.frame.size.width;
    NSInteger scrollHeight = (NSInteger)self.scrollCards.frame.size.height;
    
    unsigned int current_pos = 0;
    
    for (Card *card in [[CardsRepository sharedInstance] entitiesBuffer])
    {
        CardViewController *cardController = [[CardViewController alloc] initCardController:card];
        
        [self addViewToIndexScrollView:cardController.view position:current_pos++];
    }
    
    /*AboutViewController *aboutController = [[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:[NSBundle mainBundle]];
    [self addViewToIndexScrollView:aboutController.view position:current_pos];
    current_pos++;*/
    scrollCards.contentSize = CGSizeMake(scrollWidth * current_pos, scrollHeight);
}

-(void) addViewToIndexScrollView:(UIView*)view position:(NSUInteger)index
{
    CGRect frame;
    frame.origin.x = (index * self.scrollCards.frame.size.width);
    frame.origin.y = 0;
    frame.size.width = view.frame.size.width;
    frame.size.height = view.frame.size.height;
    
    view.frame = frame;
    
    [self.scrollCards addSubview:view];
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

-(void) showAboutController
{
    self.scrollCards.alpha = 0.0f;

    aboutController = [[AboutViewController alloc] initWithView:self.scrollContainer above:self.scrollCards];

    [aboutController showAboutView];
}

-(void) hideAboutController
{
    self.scrollCards.alpha = 0.0f;

    [aboutController hideAboutView];

    aboutController = nil;

    [UIView animateWithDuration:0.4 animations:^(void)  {
           self.scrollCards.alpha = 1.0f;
    }];
}

-(void) logoTaped:(id)sender
{
    if(aboutController != nil)
    {
        cloudBtn.highlighted = !cloudBtn.highlighted;
        [self hideAboutController];
        [self scrollToFirstPage];
    }
}

-(void) scrollToFirstPage
{
    CGRect scrollRect = self.scrollCards.frame;

    [self.scrollCards scrollRectToVisible:CGRectMake(0,0, scrollRect.size.width,scrollRect.size.height) animated:YES];
}

@end
