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
}

@synthesize scrollCards;

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
    self.scrollCards.backgroundColor = [UIColor clearColor];
    
    [self.view showBrandymintLogo];
    [self.view showDevelopersLogo];
    [self.view showTopLine];
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

-(void) initScrollCards
{
    NSInteger scrollWidth = (NSInteger)self.scrollCards.frame.size.width;
    NSInteger scrollHeight = (NSInteger)self.scrollCards.frame.size.height;
    
    NSUInteger cardsCount = [CardsRepository sharedCardsRepository].entitiesBuffer.count;
    
    NSUInteger current_pos = 0;
    
    for(NSUInteger loop = 0; loop < cardsCount; loop++, current_pos++)
    {
        Card *card = [[CardsRepository sharedCardsRepository].entitiesBuffer objectAtIndex:loop];
        CardViewController *cardController = [[CardViewController alloc] initCardController:card];
        
        [self addViewToIndexScrollView:cardController.view position:current_pos];
    }
    
    /*AboutViewController *aboutController = [[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:[NSBundle mainBundle]];
    [self addViewToIndexScrollView:aboutController.view position:current_pos];
    current_pos++;*/

    scrollCards.contentSize = CGSizeMake(scrollWidth * current_pos, scrollHeight);
}

-(void) addViewToIndexScrollView:(UIView*)view position:(NSUInteger)index
{
    CGRect frame;
    frame.origin.x = (index * view.frame.size.width);
    frame.origin.y = 0;
    frame.size.width = view.frame.size.width;
    frame.size.height = view.frame.size.height;
    
    view.frame = frame;
    
    [self.scrollCards addSubview:view];
}

-(void) onCloudClick:(id)sender
{
    static AboutViewController *aboutController = nil;
    
    UIButton *cloudBtn = (UIButton*)sender;
    
    if(aboutController == nil)  {
        cloudBtn.highlighted = YES;
        
        self.scrollCards.alpha = 0.0f;
        
        [self.view hideBottomLine:^(BOOL finished)  {
           aboutController = [[AboutViewController alloc] initWithView:self.view above:self.scrollCards];
            
            [aboutController showAboutView];
        }];
    }
    else    {
        cloudBtn.highlighted = NO;
        
        self.scrollCards.alpha = 0.0f;
        
        [aboutController hideAboutView];
        aboutController = nil;
        
        [UIView animateWithDuration:0.4 animations:^(void)  {
            self.scrollCards.alpha = 1.0f;
        }];
        
        [self.view showBottomLine];
    }
}



@end
