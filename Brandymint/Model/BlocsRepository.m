//
//  BlocsRepository.m
//  Brandymint
//
//  Created by Danil Pismenny on 15.03.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import "BlocsRepository.h"
#import "AppDelegate.h"

@implementation BlocsRepository

@synthesize blocsBuffer;

static BlocsRepository *sharedSingleton = NULL;

+(BlocsRepository *) sharedRepository
{
    @synchronized(self) {
        if(sharedSingleton == NULL) {
            NSLog(@"BlocsRepository init");
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
        [self getAllBlocs];
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

@end
