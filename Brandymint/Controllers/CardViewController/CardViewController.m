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

const int MARGIN_LINK = 18;

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
    self.cardImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.cardImageView.clipsToBounds = true;
  
    CGFloat offsetXFromLinksContainer = 0;
    CGRect rectLinkBtn;
  
    if (card.url && [card.url length]!=0 && card.url!=card.itunes_url && card.url!=card.gplay_url) {
      offsetXFromLinksContainer += cardLinkButton.frame.size.width + MARGIN_LINK;
    }
    else
    {
      cardLinkButton.hidden = true;
    }
  
    if (card.itunes_url && [card.itunes_url length]!=0) {
      rectLinkBtn = cardAppstoreButton.frame;
      rectLinkBtn.origin.x = offsetXFromLinksContainer;
      cardAppstoreButton.frame = rectLinkBtn;
      
      offsetXFromLinksContainer += cardAppstoreButton.frame.size.width + MARGIN_LINK;
    }
    else {
      cardAppstoreButton.hidden = true;
    }
    if (card.gplay_url && [card.gplay_url length]!=0) {
      rectLinkBtn = cardGoogleplayButton.frame;
      rectLinkBtn.origin.x = offsetXFromLinksContainer;
      cardGoogleplayButton.frame = rectLinkBtn;
      
      offsetXFromLinksContainer += cardGoogleplayButton.frame.size.width;
    }
    else{
      cardGoogleplayButton.hidden = true;
    }
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
  if (card.url && [card.url length]!=0) {
    WebViewController *webViewController = [[WebViewController alloc] initWithURL:card.url];
    [((AppDelegate*)[[UIApplication sharedApplication] delegate]) presentModalViewController:webViewController];
  }
}

@end
