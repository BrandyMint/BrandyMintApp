//
//  Image.m
//  Brandymint
//
//  Created by Danil Pismenny on 15.03.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import "Image.h"
#import "Card.h"


@implementation Image

@dynamic data;
@dynamic url;
@dynamic card;

+(Image *) findOrDownloadByUrl:(NSString* )url withContext:(NSManagedObjectContext *)context
{

    Image *image = [self findImageByUrl:url withContext:context];
    if (!image) {
        NSLog(@"Download image by url: %@", url);

        image = [NSEntityDescription
                 insertNewObjectForEntityForName: @"Image"
                 inManagedObjectContext: context];
        image.data = [image downloadImageByUrl:url];
        image.url = url;
    }
    return image;
}

+(Image *) findImageByUrl:(NSString *)url withContext:(NSManagedObjectContext *)context
{
    NSFetchRequest * fetch = [[NSFetchRequest alloc] init];
    NSPredicate* pred = [NSPredicate predicateWithFormat:@"url == %@", url];
    
    [fetch setEntity:[NSEntityDescription entityForName:@"Image" inManagedObjectContext:context]];
    [fetch setPredicate:pred];
    
    NSArray * images = [context executeFetchRequest:fetch error:nil];
    
    return images.count>0 ? [images objectAtIndex:0] : nil;
}

-(UIImage *) downloadImageByUrl: (NSString *)url
{
    NSLog(@"Download image by url: %@", url);

    return [[UIImage alloc]
            initWithData:[NSData
                          dataWithContentsOfURL:[NSURL URLWithString:url]]];
}

@end
