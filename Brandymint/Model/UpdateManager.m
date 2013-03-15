//
//  UpdateManager.m
//  Brandymint
//
//  Created by denisdbv@gmail.com on 13.03.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import "UpdateManager.h"
#import "CardsRepository.h"
#import "AFJSONRequestOperation.h"
#import "AFHTTPClient.h"
#import "NSDate+external.h"

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

@implementation UpdateManager

static UpdateManager *sharedSingleton = NULL;

+(UpdateManager *) updateManager
{
    @synchronized(self) {
        if(sharedSingleton == NULL) {
            NSLog(@"UpdateManager init");
            sharedSingleton = [[self alloc] init];
        }
    }
    return (sharedSingleton);
}

-(void) updateData
{
    NSLog(@"start connecting to server...");
    [self receiveJSONFromUrl:@"http://brandymint.ru/api/v1/app.json"];
}

-(UIImage *) downloadImageByUrl: (NSString *)image_url
{
    return [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:image_url]]];
}

-(void) updateCards:(id)cardsArray  
{
    //NSLog(@"%@", cardsArray);
    
    CardsRepository* repo = (CardsRepository*)CardsRepository.sharedRepository;
    
    NSMutableArray *cardsToDelete = [[NSMutableArray alloc]init];
    [cardsToDelete addObjectsFromArray:repo.entitiesBuffer];
    
    [cardsArray enumerateObjectsUsingBlock:^(id card_dict, NSUInteger idx, BOOL *stop) {
        
        NSString *card_key = [card_dict objectForKey:@"key"];
        NSString *image_url = [card_dict objectForKey:@"image_url"];
        NSDate *updated_at = [NSDate parseDateFromString:[card_dict objectForKey:@"updated_at"]];
        
        Card *existen_card = [repo findCardByKey: card_key];
        
        if (existen_card) {
            [cardsToDelete removeObjectIdenticalTo:existen_card];
  
            if (![existen_card.updated_at isEqualToDate:updated_at]) {
                Card *card = [Card createFromDictionary:card_dict];
                
                if (![existen_card.image_url isEqualToString:image_url]) {
                    card.image = [self downloadImageByUrl:image_url];
                } else {
                    card.image = existen_card.image;
                }
                // Карточка existen замещается с card
                existen_card = card;
            }
        } else {
            // Создается новая карточка
            Card *card = [Card createFromDictionary:card_dict];
            card.image = [self downloadImageByUrl:card.image_url];
        }
    }];
    
    // Удалить все что остались в cardsBuffer
    for (Card *card in cardsToDelete) {
        [repo deleteEntity: card];
    }
    
    [repo saveData];
    
    [repo getAllEntities];
}


#pragma mark -
#pragma mark Load JSON file from web

-(void) receiveJSONFromUrl:(NSString*)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    /*dispatch_async(kBgQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL:url];
        [self performSelectorOnMainThread:@selector(fetchedData:) withObject:data waitUntilDone:YES];
    });*/
    
    dispatch_sync(kBgQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL:url];
        [self performSelectorOnMainThread:@selector(fetchedData:) withObject:data waitUntilDone:YES];
    });
}

- (void)fetchedData:(NSData *)responseData {
    
    NSError* error;
    NSDictionary* jsonData = [NSJSONSerialization
                          JSONObjectWithData:responseData
                          options:kNilOptions
                          error:&error];
    
    if (jsonData != nil)
    {
        NSArray *cardsArray = [jsonData objectForKey:@"cards"];
        if(cardsArray != nil)
        {
            NSLog(@"JSON read from server");
            [self updateCards:cardsArray];
        }
    }
}

@end
