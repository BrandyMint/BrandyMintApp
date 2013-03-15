//
//  CardViewController.m
//  Brandymint
//
//  Created by denisdbv@gmail.com on 07.03.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import "CardViewController.h"
#import "UIImage+external.h"

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
    
    cardTitleLabel.font = [UIFont fontWithName:@"Ubuntu-Bold" size:32];
    cardSubtitleLabel.font = [UIFont fontWithName:@"Ubuntu-Light" size:25];
    cardDescLabel.font = [UIFont fontWithName:@"UbuntuCondensed-Regular" size:20];
    cardLinkLabel.font = [UIFont fontWithName:@"Ubuntu-Light" size:23];
    
    cardDescLabel.linkColor = [UIColor colorWithRed:0 green:102/255.0 blue:153/255.0 alpha:1];
    [cardDescLabel setDefaultStyle:[NMCustomLabelStyle styleWithFont:[UIFont fontWithName:@"UbuntuCondensed-Regular" size:20] color:[UIColor whiteColor]]];
	[cardDescLabel setStyle:[NMCustomLabelStyle styleWithFont:[UIFont fontWithName:@"Ubuntu-Bold" size:20] color:[UIColor whiteColor]] forKey:@"bold_style"];
	[cardDescLabel setStyle:[NMCustomLabelStyle styleWithFont:[UIFont fontWithName:@"Ubuntu-Italic" size:20] color:[UIColor whiteColor]] forKey:@"ital_style"];
    [cardDescLabel setStyle:[NMCustomLabelStyle styleWithFont:[UIFont fontWithName:@"UbuntuCondensed-Regular" size:20] color:[UIColor redColor]]forKey:@"color_red"];
    [cardDescLabel setStyle:[NMCustomLabelStyle styleWithFont:[UIFont fontWithName:@"UbuntuCondensed-Regular" size:20] color:[UIColor greenColor]]forKey:@"color_green"];
    
    cardImageView.image = card.image;
    cardTitleLabel.text = card.title;
    cardSubtitleLabel.text = card.subtitle;
    cardDescLabel.text = card.desc;
    cardLinkLabel.text = card.link;
}

@end
