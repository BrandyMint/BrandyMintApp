//
//  ImagesRepository.m
//  Brandymint
//
//  Created by DenisDbv on 21.03.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import "ImagesRepository.h"

@implementation ImagesRepository

CWL_SYNTHESIZE_SINGLETON_FOR_CLASS(ImagesRepository)

-(NSString *) entityName { return @"Image"; }

-(void) printCountImagesFromDB
{
    NSManagedObjectContext *context = [self managerContext];
    
    NSEntityDescription *entityDescriptor = [NSEntityDescription entityForName:[self entityName] inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];

    [request setEntity:entityDescriptor];
    
    NSError *error;
    NSArray *entityImages = [context executeFetchRequest:request error:&error];
    
    if(entityImages == nil)
    {
        NSLog(@"Error while reading %@", ([error localizedDescription] != nil) ? [error localizedDescription] : @"Unknown Error");
        return;
    }
    
    NSLog(@"\n----------------------------");
    NSLog(@"COUNT IMAGES = %i", entityImages.count);
    NSLog(@"----------------------------");
    
    for(Image *img in entityImages)
    {
        NSLog(@"%@", img.url);
    }
}

@end
