//
//  Image.h
//  Brandymint
//
//  Created by Danil Pismenny on 15.03.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Card;

@interface Image : NSManagedObject

@property (nonatomic, retain) UIImage * data;
@property (nonatomic, retain) UIImage * thumb;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) Card *card;

+(Image *) findOrDownloadByUrl: (NSString *)url withContext:(NSManagedObjectContext *)context;

@end
