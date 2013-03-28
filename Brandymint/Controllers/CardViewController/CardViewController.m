//
//  CardViewController.m
//  Brandymint
//
//  Created by denisdbv@gmail.com on 07.03.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import "CardViewController.h"
#import "UIImage+external.h"
#import <QuartzCore/QuartzCore.h>
#import "NMCustomLabel.h"
#import "WebViewController.h"
#import "AppDelegate.h"

@interface CardViewController ()

@end

@implementation CardViewController

@synthesize cardImageView;
@synthesize cardTitleLabel;
@synthesize cardSubtitleLabel;
@synthesize cardDescLabel;
@synthesize cardLinkButton;
@synthesize cardAppstoreButton;
@synthesize cardGoogleplayButton;
@synthesize card;

- (id)initCardController:(Card*)srcCard
{
    self = [super initWithNibName:@"CardViewController" bundle:[NSBundle mainBundle]];
    if (self) {
        self.card = srcCard;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // self.cardDescLabel = [[NMCustomLabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

-(void) viewWillAppear:(BOOL)animated
{
    [self setHookOnAppImageClick];
  
    self.view.backgroundColor = [UIColor clearColor];
    
    self.cardTitleLabel.font    = [UIFont fontWithName:@"Ubuntu-Bold" size:32];
    self.cardSubtitleLabel.font = [UIFont fontWithName:@"Ubuntu-Light" size:25];
    self.cardDescLabel.font     = [UIFont fontWithName:@"Ubuntu" size:20];
    self.cardDescLabel.textColor = [UIColor whiteColor];
  
    self.cardImageView.image    = card.image.data;
    self.cardTitleLabel.text    = card.title;
    self.cardSubtitleLabel.text = card.subtitle;
    self.cardDescLabel.text     = card.desc;

    //self.cardImageView.layer.cornerRadius = 4;
    //self.cardImageView.layer.masksToBounds = YES;
    [self.cardImageView.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.cardImageView.layer setShadowOpacity:0.3f];
    [self.cardImageView.layer setShadowOffset: CGSizeMake(0.0f, 5.0f)];
    [self.cardImageView.layer setShadowRadius:10];
    [self.cardImageView.layer setBorderColor:[UIColor colorWithWhite:1.0 alpha:0.5f].CGColor];
    [self.cardImageView.layer setBorderWidth:1.0f];
  
    if (card.url && [card.url length]!=0) {
      [cardLinkButton setTitle:NULL forState:UIControlStateNormal];
      [cardLinkButton setTitle:card.link forState:UIControlStateNormal];
      //cardLinkButton.titleLabel.font = [UIFont fontWithName:@"Ubuntu-Light" size:23];
      //cardLinkButton.titleLabel.textAlignment = UITextAlignmentLeft;
      //cardLinkButton.titleLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
      cardLinkButton.backgroundColor = [UIColor clearColor];
      UIImage *cardLinkIcon = [UIImage imageNamed:@"icon-link.png"];
      [cardLinkButton setImage:cardLinkIcon forState:UIControlStateNormal];
    }
    else
    {
      cardLinkButton.hidden = true;
    }
  
    //TODO if (card.appstore_url && [card.appstore_url length]!=0)
    [cardAppstoreButton setTitle:NULL forState:UIControlStateNormal];
    cardAppstoreButton.backgroundColor = [UIColor clearColor];
    UIImage *cardAppstoreBadge = [UIImage imageNamed:@"badge-appstore.png"];
    [cardAppstoreButton setImage:cardAppstoreBadge forState:UIControlStateNormal];
  
    //TODO if (card.googleplay_url && [card.googleplay_url length]!=0)
    [cardGoogleplayButton setTitle:NULL forState:UIControlStateNormal];
    cardGoogleplayButton.backgroundColor = [UIColor clearColor];
    UIImage *cardGoogleplayBadge = [UIImage imageNamed:@"badge-googleplay.png"];
    [cardGoogleplayButton setImage:cardGoogleplayBadge forState:UIControlStateNormal];

}

-(void) setHookOnAppImageClick
{
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openLinkInApp:)];
    singleTap.numberOfTapsRequired = 1;
    singleTap.numberOfTouchesRequired = 1;
    [self.cardImageView addGestureRecognizer:singleTap];
    [self.cardImageView setUserInteractionEnabled:YES];
}

-(IBAction) openLinkInApp:(id)sender
{
    WebViewController *webViewController = [[WebViewController alloc] initWithURL:card.url];
    [((AppDelegate*)[[UIApplication sharedApplication] delegate]) presentModalViewController:webViewController];
}

@end
