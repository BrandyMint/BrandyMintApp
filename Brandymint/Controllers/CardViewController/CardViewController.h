//
//  CardViewController.h
//  Brandymint
//
//  Created by denisdbv@gmail.com on 07.03.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Card.h"

@interface CardViewController : UIViewController
{
    Card *card;
}

@property (nonatomic, assign) IBOutlet UIImageView *cardImageView;
@property (nonatomic, assign) IBOutlet UILabel *cardTitleLabel;
@property (nonatomic, assign) IBOutlet UILabel *cardSubtitleLabel;
@property (nonatomic, assign) IBOutlet UILabel *cardDescLabel;
@property (nonatomic, assign) IBOutlet UILabel *cardLinkLabel;

@property (nonatomic, retain) Card *card;

- (id)initCardController:(Card*)srcCard;

-(void) buildView;

@end
