//
//  OwnViewController.m
//  Brandymint
//
//  Created by denisdbv@gmail.com on 07.03.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import "OwnViewController.h"
#import "CardViewController.h"
#import "OwnSectorsAnim.h"
#import "Card.h"

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
@synthesize backgroundImage;

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
    backgroundImage.image = [UIImage imageNamed:@"background.jpg"];
    self.scrollCards.backgroundColor = [UIColor clearColor];
    
    [self.view showBrandymintLogo];
    [self.view showDevelopersLogo];
    [self.view showTopLine];
    
    [[UpdateManager updateManager] updateData];
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
    NSInteger scrollWidth = self.scrollCards.frame.size.width;
    NSInteger scrollHeight = self.scrollCards.frame.size.height;
    
    int cardsCount = [CardsRepository sharedRepository].entitiesBuffer.count;
    
    for(int loop = 0; loop < cardsCount; loop++)
    {
        Card *card = [[CardsRepository sharedRepository].entitiesBuffer objectAtIndex:loop];
        CardViewController *cardController = [[CardViewController alloc] initCardController:card];
        
        CGRect frame;
        frame.origin.x = (loop * cardController.view.frame.size.width);
        frame.origin.y = 0;
        frame.size.width = cardController.view.frame.size.width;
        frame.size.height = cardController.view.frame.size.height;
        
        cardController.view.frame = frame;
        
        [self.scrollCards addSubview:cardController.view];
    }
    
    scrollCards.contentSize = CGSizeMake(scrollWidth * cardsCount, scrollHeight);
}

@end
