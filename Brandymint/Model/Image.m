//
//  Image.m
//  Brandymint
//
//  Created by Danil Pismenny on 15.03.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import "Image.h"
#import "Card.h"
#import "ImageToDataTransformer.h"


@implementation Image

@dynamic data;
@dynamic url;
@dynamic card;

+ (void)initialize {
    if (self == [Image class]) {
        ImageToDataTransformer *transformer = [[ImageToDataTransformer alloc] init];
        [NSValueTransformer setValueTransformer:transformer forName:@"ImageToDataTransformer"];
    }
}

+(Image *) findOrDownloadByUrl:(NSString* )url withContext:(NSManagedObjectContext *)context
{
    Image *image = [self findImageByUrl:url withContext:context];
    
    return image ? image : [self downloadAandCreateByUrl:url withContext:context];
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


+(Image *) downloadAandCreateByUrl:(NSString *)url withContext:(NSManagedObjectContext *)context
{
    NSLog(@"Download image by url: %@", url);
    
    Image *image = [NSEntityDescription
                    insertNewObjectForEntityForName: @"Image"
                    inManagedObjectContext: context];
    image.data = [self downloadImageByUrl:url];
    image.url = url;
    
    return image;
}

+(UIImage *)downloadImageByUrl:(NSString *)url
{
    return [[UIImage alloc]
            initWithData:[NSData
                          dataWithContentsOfURL:[NSURL URLWithString:url]]];
    
}

@end
