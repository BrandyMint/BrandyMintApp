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
    
    imagesName = [[NSArray alloc] initWithObjects:@"brandymint_2013_redesign_fnl.jpg", @"brandymint_2013_redesign_fnl2.jpg", @"brandymint_2013_redesign_fnl3.jpg",
                  @"brandymint_2013_redesign_fnl.jpg", @"brandymint_2013_redesign_fnl.jpg", @"brandymint_2013_redesign_fnl.jpg", @"brandymint_2013_redesign_fnl.jpg",
                  @"brandymint_2013_redesign_fnl.jpg", @"brandymint_2013_redesign_fnl.jpg", @"brandymint_2013_redesign_fnl.jpg", @"brandymint_2013_redesign_fnl.jpg",
                  @"brandymint_2013_redesign_fnl.jpg", @"brandymint_2013_redesign_fnl.jpg", @"brandymint_2013_redesign_fnl.jpg", @"brandymint_2013_redesign_fnl.jpg", nil];
    
    [self performSelector:@selector(initScrollCards) withObject:nil afterDelay:0];
}

-(void) viewWillAppear:(BOOL)animated
{
    backgroundImage.image = [UIImage imageNamed:@"background.jpg"];
    self.scrollCards.backgroundColor = [UIColor clearColor];
    
    [self.view showBrandymintLogo];
    [self.view showTopLine];
    
    [[UpdateManager updateManager] readJsonFromFile];
    
    Card *card1 = [[CardsRepository sharedRepository] getFirstCard];
    NSLog(@"%@", card1);
    Card *card2 = [[CardsRepository sharedRepository] getNextCard:card1];
    NSLog(@"%@", card2);
    Card *card3 = [[CardsRepository sharedRepository] getPreviousCard:card2];
    NSLog(@"%@", card3);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void) initScrollCards
{
    NSInteger scrollWidth = self.scrollCards.frame.size.width;
    NSInteger scrollHeight = self.scrollCards.frame.size.height;
    
    int cardsCount = imagesName.count;
    
    for(int loop = 0; loop < cardsCount; loop++)
    {
        UIImage *image = [[UIImage imageNamed:[imagesName objectAtIndex:loop]] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) ];
        int imgWidth = image.size.width;
        int imgHeight = image.size.height;
        
        //NSLog(@"%@",[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"OWNTEST"]);
        //image = [UIImage imageNamed:@"OWNTEST/1.jpg"];
        //image = [UIImage imageWithContentsOfFile:GetFullPath(@"OWNTEST/1.jpg")];
        
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
     
        CardViewController *card = [[CardViewController alloc]
                                                initWithNibName:@"CardViewController" bundle:[NSBundle mainBundle]];
        card.view.frame = frame;
        
        //[self.scrollCards addSubview:card.view];
        
        [card reconfigurationView:image];
    }
    
    scrollCards.contentSize = CGSizeMake(scrollWidth * cardsCount, scrollHeight);
}

@end
