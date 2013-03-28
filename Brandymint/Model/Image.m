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
@dynamic thumb;
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

- (void)didChangeValueForKey:(NSString *)key
{
    if ([key isEqualToString:@"url"]) {
      UIImage *image = self.data;
  
      self.thumb = [self scaleToSize:CGSizeMake(image.size.width/8, image.size.height/8)];
    }
    
    [super didChangeValueForKey:key];
}

- (UIImage*)scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0.0, size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, size.width, size.height), self.data.CGImage);
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

@end
