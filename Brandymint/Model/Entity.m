//
//  Entity.m
//  Brandymint
//
//  Created by Danil Pismenny on 15.03.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import "Entity.h"
#import "NSDate+external.h"
#import "Image.h"

@implementation Entity

@dynamic key;


-(void)setSmartValue:(id) value forKey:(NSString *)key
{
    //NSLog(@"Set smart value: %@ = %@", key, value);
    if ([value isKindOfClass:[NSNull class]]) {
        [self setValue:nil forKey:key];
        // TODO Определять по типу property, а не названию
    } else if ([key isEqualToString:@"updated_at"]) {
        [self setValue:[NSDate parseDateFromString:value] forKey:key];
    } else {
        [self setValue:value forKey:key];
    }
}

-(void)updateFromDict:(NSDictionary* )entity_dict
{
    // TODO Делать наоборот- Проходиться по всем свойствам entity и брать их из Directory.
    
    // NSDate *updated_at = [NSDate parseDateFromString:[entity_dict objectForKey:@"updated_at"]];
    // NSString *image_url = [entity_dict objectForKey:@"image_url"];
    
    [entity_dict enumerateKeysAndObjectsUsingBlock:^(NSString* key, id value, BOOL *stop) {
        [self setSmartValue:value forKey:key];
    }];
    


//
//        //Если карточка обновлена, то мы создаем новую, а старую удалим
//        if (![existen_card.updated_at isEqualToDate:updated_at]) {
//            Card *card = [Card createFromDictionary:entity_dict];
//            
//            if (![existen_card.image_url isEqualToString:image_url]) {
//                card.image = [self downloadImageByUrl:image_url];
//            } else {
//                card.image = existen_card.image;
//            }
//        }
//        else    {   //Если карточка не обновлена то удаляем ее из очереди на удаление
//        }
//    } else {
//    }
}


@end
