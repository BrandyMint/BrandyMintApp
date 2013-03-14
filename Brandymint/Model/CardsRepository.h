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
    NSMutableArray *cardsBuffer;
}

@property (retain, readonly) NSMutableArray *cardsBuffer;

+(CardsRepository *) sharedRepository;

-(NSManagedObjectContext*) managerContext;

-(Card*) getFirstCard;
-(Card*) getNextCard:(Card*)prevCard;
-(Card*) getPreviousCard:(Card*)prevCard;
-(Card*) findCardByKey: (NSString *)key;
-(void) deleteCard:(Card*)card;
-(BOOL)saveData;
-(NSArray*) getAllCards;

@end
