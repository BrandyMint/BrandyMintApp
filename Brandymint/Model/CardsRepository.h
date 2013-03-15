//
//  CardsRepository.h
//  Brandymint
//
//  Created by denisdbv@gmail.com on 13.03.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "BaseRepository.h"

@interface CardsRepository : BaseRepository

-(Card*) getFirstCard;
-(Card*) getNextCard:(Card*)prevCard;
-(Card*) getPreviousCard:(Card*)prevCard;
-(Card*) findCardByKey: (NSString *)key;


@end
