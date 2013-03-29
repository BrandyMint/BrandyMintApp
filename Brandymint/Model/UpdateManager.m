//
//  UpdateManager.m
//  Brandymint
//
//  Created by denisdbv@gmail.com on 13.03.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import "UpdateManager.h"
#import "CardsRepository.h"
#import "BlocsRepository.h"
#import "LinksRepository.h"

#import "AFJSONRequestOperation.h"
#import "AFHTTPClient.h"
#import "NSDate+external.h"
#import "Entity.h"

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

@implementation UpdateManager

+ (id)sharedInstance
{
    return [ABMultiton sharedInstanceOfClass:[self class]];
}

-(void) updateData
{
    NSLog(@"start connecting to server...");
    [self receiveJSONFromUrl:@"http://brandymint.ru/api/v1/app.json"];
}


-(void) updateEnities:(NSArray *)entities withRepo:(BaseRepository*)repo
{
    
    NSMutableArray *entitiesToDelete = [[NSMutableArray alloc]init];
    [repo getAllEntities];
    [entitiesToDelete addObjectsFromArray: repo.entitiesBuffer];
    
    for (NSDictionary *entity_dict in entities) {
        Entity *entity = [repo findOrCreateEntityByKey: [entity_dict objectForKey:@"key"]];
        
        [entitiesToDelete removeObjectIdenticalTo:entity];
        
        [entity updateFromDict: entity_dict];
        
    };
    
    // Удалить все что остались
    for (Entity *entity in entitiesToDelete) {
        [repo deleteEntity: entity];
    }
    
    [repo saveData];
    [repo getAllEntities];
}


#pragma mark -
#pragma mark Load JSON file from web

-(void) receiveJSONFromUrl:(NSString*)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    dispatch_sync(kBgQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL:url];
        [self performSelectorOnMainThread: @selector(fetchedData:)
                               withObject: data
                            waitUntilDone: YES];
    });
}

- (void)fetchedData:(NSData *)responseData {
    
    NSLog(@"JSON read from server");
    NSError* error;
    NSDictionary* jsonData = [NSJSONSerialization
                              JSONObjectWithData:responseData
                              options:kNilOptions
                              error:&error];
  NSLog(@"%@", jsonData);
    if (jsonData != nil)
    {
        [self updateEnities:[jsonData objectForKey:@"cards"] withRepo: CardsRepository.sharedInstance];
        [self updateEnities:[jsonData objectForKey:@"blocs"] withRepo: BlocsRepository.sharedInstance];
        [self updateEnities:[jsonData objectForKey:@"links"] withRepo: LinksRepository.sharedInstance];
    }
}

- (void)printCountImagesFromDB
{
    
}

@end


// Another examples
// http://www.raywenderlich.com/15916/how-to-synchronize-core-data-with-a-web-service-part-1
