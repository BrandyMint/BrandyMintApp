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

#pragma mark -
#pragma mark Load JSON file from web

-(void) receiveJSONFromUrl:(NSString*)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    dispatch_async(kBgQueue, ^{
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
            [[CardsRepository sharedRepository] updateCards:cardsArray];
        }
    }
}

#pragma mark -
#pragma Load JSON file from resources

-(void) readJsonFromFile
{
    NSManagedObjectContext *context = [[CardsRepository sharedRepository] managerContext];
    
    NSError* err = nil;
    NSString* dataPath = [[NSBundle mainBundle] pathForResource:@"DataManifest" ofType:@"json"];
    NSDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:dataPath]
                                                     options:kNilOptions
                                                       error:&err];
    
    if (jsonData != nil)
    {
        NSArray *cardsArray = [jsonData objectForKey:@"cards"];
        if(cardsArray != nil)
        {
            [[CardsRepository sharedRepository] updateCards:cardsArray];
        }
    }
}

@end
