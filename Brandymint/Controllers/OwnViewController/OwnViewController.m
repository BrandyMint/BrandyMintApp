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

-(void) initScrollCards
{
    NSInteger scrollWidth = self.scrollCards.frame.size.width;
    NSInteger scrollHeight = self.scrollCards.frame.size.height;
    
    int cardsCount = [CardsRepository sharedRepository].entitiesBuffer.count;
    
    for(int loop = 0; loop < cardsCount; loop++)
    {
        UIImage *image = [[UIImage imageNamed:[imagesName objectAtIndex:loop]] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) ];
        int imgWidth = image.size.width;
        int imgHeight = image.size.height;

        int dx, dy = 0;
        int dWidth, dHeight = 0;
        if(imgWidth > scrollWidth)  {
            dx = 0;
            dWidth = scrollWidth;
        }
        else    {
            dx = (scrollWidth - imgWidth)/2;
            dWidth = imgWidth;
        }
        
        if(imgHeight > scrollHeight) {
            dy = 0;
            dHeight = scrollHeight;
        }
        else    {
            dy = (scrollHeight - imgHeight)/2;
            dHeight = imgHeight;
        }
        
        CGRect frame;
        frame.origin.x = (loop * scrollWidth) + dx;
        frame.origin.y = dy;
        frame.size.width = dWidth;
        frame.size.height = dHeight;
     
        Card *card = [[CardsRepository sharedRepository].entitiesBuffer objectAtIndex:loop];
        
        CardViewController *cardController = [[CardViewController alloc] initCardController:card];
        cardController.view.frame = frame;
        
        [self.scrollCards addSubview:cardController.view];
    }
    
    scrollCards.contentSize = CGSizeMake(scrollWidth * cardsCount, scrollHeight);
}

@end
