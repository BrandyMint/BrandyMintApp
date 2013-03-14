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

@property (retain, readonly) NSArray *cardsBuffer;

+(CardsRepository *) sharedRepository;

-(NSManagedObjectContext*) managerContext;

-(Card*) getFirstCard;
-(Card*) getNextCard:(Card*)prevCard;
-(Card*) getPreviousCard:(Card*)prevCard;

-(void) updateCards:(NSArray*)cardsArray;

@end
