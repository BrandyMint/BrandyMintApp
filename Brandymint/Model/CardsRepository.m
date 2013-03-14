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

+(CardsRepository *) sharedRepository
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
        [self getAllCards];
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
#pragma mark Save context
- (BOOL)saveData {
    NSError *error;
    if (![[self managerContext] save:&error]) {
        
        NSString *message = nil;
        if ([[error domain] isEqualToString:@"NSCocoaErrorDomain"]) {
            
            NSDictionary *userInfo = [error userInfo];
            if ([userInfo valueForKey:@"NSDetailedErrors"] != nil) {
                
                NSArray *errors = [userInfo valueForKey:@"NSDetailedErrors"];
                for (NSError *anError in errors) {
                    
                    NSDictionary *subUserInfo = [anError userInfo];
                    subUserInfo = [anError userInfo];
                    
                    NSLog(@"Core Data Save Error\n\n \
                          NSValidationErrorKey\n%@\n\n \
                          NSValidationErrorPredicate\n%@\n\n \
                          NSValidationErrorObject\n%@\n\n \
                          NSLocalizedDescription\n%@",
                          [subUserInfo valueForKey:@"NSValidationErrorKey"],
                          [subUserInfo valueForKey:@"NSValidationErrorPredicate"],
                          [subUserInfo valueForKey:@"NSValidationErrorObject"],
                          [subUserInfo valueForKey:@"NSLocalizedDescription"]);
                }
            }
            
            else {
                NSLog(@"Core Data Save Error\n\n \
                      NSValidationErrorKey\n%@\n\n \
                      NSValidationErrorPredicate\n%@\n\n \
                      NSValidationErrorObject\n%@\n\n \
                      NSLocalizedDescription\n%@",
                      [userInfo valueForKey:@"NSValidationErrorKey"],
                      [userInfo valueForKey:@"NSValidationErrorPredicate"],
                      [userInfo valueForKey:@"NSValidationErrorObject"],
                      [userInfo valueForKey:@"NSLocalizedDescription"]);
                
            }
        }
        else {
            NSLog(@"Custom Error: %@", [error localizedDescription]);
        }
        return NO;
    }
    return YES;
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
    cardsBuffer = [context executeFetchRequest:request error:&error];
    
    if(cardsBuffer == nil)
    {
        NSLog(@"Error while reading %@", ([error localizedDescription] != nil) ? [error localizedDescription] : @"Unknown Error");
        return nil;
    }
    
    NSLog(@"cards count = %i", cardsBuffer.count);
 
    return cardsBuffer;
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
    if( index < 0 )  {
        NSLog(@"Warning in CardsRepository (getPreviousCard). index out of range");
        return nil;
    }
    
    return [cardsBuffer objectAtIndex:index];
}

/*

#pragma mark -
#pragma mark Delete all cards

-(void) deleteCard:(Card *)card
{
    NSManagedObjectContext * context = [self managerContext];
    NSFetchRequest * fetch = [[NSFetchRequest alloc] init];
    [fetch setEntity:[NSEntityDescription entityForName:@"Card" inManagedObjectContext:context]];
    NSArray * result = [context executeFetchRequest:fetch error:nil];
    for (id card in result) {
        [context deleteObject:card];
        
    }
    
    [self saveData];
}
 
 */

-(UIImage *) downloadImageByUrl: (NSString *)image_url
{
    UIImage* image = [UIImage imageNamed:@"icon-cloud.png"]; //[[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:image_url]]];
    
    return image;
}

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

-(void) updateCards:(id)cardsArray
{
    NSMutableArray *existenCards = [cardsBuffer copy];
        
    [cardsArray enumerateObjectsUsingBlock:^(id card_dictionary, NSUInteger idx, BOOL *stop) {
        
        //TODO: ПО ОПИСАНИЮ APPLE ПОИСК И СОЗДАНИЕ ДЕЛАЮТСЯ В ОДНОМ КОНТЕКСТЕ ПАМЯТИ, ПОЭТОМУ
        // СНАЧАЛО НУЖНО ИСКАТЬ, А ПОТОМ СОЗДАВАТЬ. (ПОМЕНЯТЬ МЕТОДЫ МЕСТАМИ)
        Card *card = [Card createFromDictionary:card_dictionary];
        Card *existen_card = [self findCardByKey: card.key];
                
        if (existen_card) {
            if ([existen_card.updated_at isEqualToDate:card.updated_at]) {
                card = nil;
            } else {
                if (![existen_card.image_url isEqualToString:card.image_url]) {
                 card.image = [self downloadImageByUrl:card.image_url];                    
                }
                // Карточка existen замещается с card
                existen_card = card;
                
                // Удалять из cardsBuffer
                [existenCards removeObject:existen_card];
            }
        } else {
            // Создается новая карточка
            card.image = [self downloadImageByUrl:card.image_url];
            [existenCards removeObject:existen_card];
        }
    }];

    // Удалить все что остались в cardsBuffer
    for (Card *card in existenCards) {
        [[self managerContext] deleteObject:card];
    }
    
    [self saveData];
    
    [self getAllCards];
}

@end
