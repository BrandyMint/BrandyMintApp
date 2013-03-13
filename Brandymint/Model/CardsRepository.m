//
//  CardsRepository.m
//  Brandymint
//
//  Created by denisdbv@gmail.com on 13.03.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import "CardsRepository.h"
#import "AppDelegate.h"

@implementation CardsRepository

@synthesize cardsBuffer;

static CardsRepository *sharedSingleton = NULL;

+(CardsRepository *) sharedData
{
    @synchronized(self) {
        if(sharedSingleton == NULL) {
            NSLog(@"CardsRepository init");
            sharedSingleton = [[self alloc] init];
        }
    }
    return (sharedSingleton);
}

-(id) init
{
    self = [super init];
    if(self)
    {
        cardsBuffer = [self getAllCards];
    }
    return self;
}

#pragma mark -
#pragma mark Get database manager context
-(NSManagedObjectContext*) managerContext
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    return [appDelegate managedObjectContext];
}

#pragma mark -
#pragma mark Methods for get cards from repository

-(NSArray*) getAllCards
{
    NSManagedObjectContext *context = [self managerContext];
    
    NSEntityDescription *entityDescriptor = [NSEntityDescription entityForName:@"Card" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescriptor];
    
    //NSPredicate* pred = [NSPredicate predicateWithFormat:@"order == 1"];
    //[request setPredicate:pred];
    
    NSError *error;
    NSArray *cards = [context executeFetchRequest:request error:&error];
    
    if(cards == nil)
    {
        NSLog(@"Error while reading %@", ([error localizedDescription] != nil) ? [error localizedDescription] : @"Unknown Error");
        return nil;
    }
    
    return cards;
}

#pragma mark Methods for get first cards from repository

-(Card*) getFirstCard
{
    if( cardsBuffer == nil) {
        NSLog(@"Error in CardsRepository. cardsBuffer = nil");
        return nil;
    }
    
    return [cardsBuffer objectAtIndex:0];
}

#pragma mark Methods for get next cards from repository

-(Card*) getNextCard:(Card*)prevCard
{
    if( cardsBuffer == nil) {
        NSLog(@"Error in CardsRepository (getNextCard). cardsBuffer = nil");
        return nil;
    }
    
    NSInteger index = [cardsBuffer indexOfObject:prevCard];
    if(index == NSNotFound) {
        NSLog(@"Error in CardsRepository (getNextCard). indexOfObject = nil");
        return nil;
    }
    
    index += 1;
    if( index >= cardsBuffer.count )  {
        NSLog(@"Warning in CardsRepository (getNextCard). index out of range");
        return nil;
    }
    
    return [cardsBuffer objectAtIndex:index];
}

#pragma mark Methods for get previous cards from repository

-(Card*) getPreviousCard:(Card*)prevCard
{
    if( cardsBuffer == nil) {
        NSLog(@"Error in CardsRepository (getPreviousCard). cardsBuffer = nil");
        return nil;
    }
    
    NSInteger index = [cardsBuffer indexOfObject:prevCard];
    if(index == NSNotFound) {
        NSLog(@"Error in CardsRepository (getPreviousCard). indexOfObject = nil");
        return nil;
    }
    
    index -= 1;
    if( index <= 0 )  {
        NSLog(@"Warning in CardsRepository (getPreviousCard). index out of range");
        return nil;
    }
    
    return [cardsBuffer objectAtIndex:index];
}

@end
