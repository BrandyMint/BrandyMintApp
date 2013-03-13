//
//  CardsRepository.h
//  Brandymint
//
//  Created by denisdbv@gmail.com on 13.03.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface CardsRepository : NSObject
{
    NSArray *cardsBuffer;
}

@property (nonatomic, readonly) NSArray *cardsBuffer;

+(CardsRepository *) sharedRepository;

-(Card*) getFirstCard;

@end
