//
//  CardViewController.m
//  Brandymint
//
//  Created by denisdbv@gmail.com on 07.03.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import "CardViewController.h"
#import "UIImage+external.h"
#import "NMCustomLabel.h"

@interface CardViewController ()

@end

@implementation CardViewController

@synthesize cardImageView;
@synthesize cardTitleLabel;
@synthesize cardSubtitleLabel;
@synthesize cardDescLabel;
@synthesize cardLinkLabel;
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
    self.view.backgroundColor = [UIColor clearColor];
    
    self.cardTitleLabel.font    = [[ThemeProvider sharedThemeProvider] boldFont:32];
    self.cardSubtitleLabel.font = [[ThemeProvider sharedThemeProvider] lightFont:25];
    self.cardDescLabel.font     = [[ThemeProvider sharedThemeProvider] condensedRegularFont:20];
    self.cardLinkLabel.font     = [[ThemeProvider sharedThemeProvider] lightFont:23];
    
    self.cardImageView.image    = card.image.data;
    self.cardTitleLabel.text    = card.title;
    self.cardSubtitleLabel.text = card.subtitle;
    self.cardDescLabel.text     = card.desc;
    self.cardLinkLabel.text     = card.link;
}

@end
