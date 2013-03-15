//
//  Card.m
//  Brandymint
//
//  Created by denisdbv@gmail.com on 13.03.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import "Card.h"
#import "CardsRepository.h"
#import "NSDate+external.h"

@implementation Card

@dynamic desc;
@dynamic image;
@dynamic link;
@dynamic position;
@dynamic subtitle;
@dynamic title;
@dynamic url;
@dynamic image_url;
@dynamic updated_at;
@dynamic key;           // Уникальный ключ


+(Card *)createFromDictionary:(NSDictionary*)dict
{
    Card *card = [NSEntityDescription
                  insertNewObjectForEntityForName:@"Card"
                  inManagedObjectContext:[[CardsRepository sharedRepository] managerContext]];
    
    card.position = [NSNumber numberWithInteger:[[dict objectForKey:@"position"] integerValue]];
    card.title = [dict objectForKey:@"title"];
    card.subtitle = [dict objectForKey:@"subtitle"];
    card.desc = [dict objectForKey:@"desc"];
    card.link = [dict objectForKey:@"link"];
    card.key = [dict objectForKey:@"key"];
    card.url = [dict objectForKey:@"url"];
    card.updated_at = [NSDate parseDateFromString:[dict objectForKey:@"updated_at"]];
    card.image_url = [dict objectForKey:@"image_url"];
   
    return card;
}

@end
