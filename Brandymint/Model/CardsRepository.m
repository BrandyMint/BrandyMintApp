//
//  CardsRepository.m
//  Brandymint
//
//  Created by denisdbv@gmail.com on 13.03.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import "CardsRepository.h"

@implementation CardsRepository


#pragma mark -
#pragma mark find card by key

-(Card *) findCardByKey: (NSString *)key
{
    NSFetchRequest * fetch = [[NSFetchRequest alloc] init];
    [fetch setEntity:[NSEntityDescription entityForName:@"Card" inManagedObjectContext:[self managerContext]]];
    
    NSPredicate* pred = [NSPredicate predicateWithFormat:@"key == %@", key];
    [fetch setPredicate:pred];
    
    NSArray * found_cards = [[self managerContext] executeFetchRequest:fetch error:nil];
    
    if(found_cards.count > 0)
    {
        return [found_cards objectAtIndex:0];
    }
    
    return nil;
}

#pragma mark create new card



@end
