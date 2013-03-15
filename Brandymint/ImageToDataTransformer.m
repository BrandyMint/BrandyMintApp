//
//  ImageToDataTransformer.m
//  Brandymint
//
//  Created by Danil Pismenny on 12.03.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import "ImageToDataTransformer.h"


@implementation ImageToDataTransformer

+(BOOL)allowsReverseTransformation {
    return YES;
}

+(Class)transformedValueClass {
    return [NSData class];
}

-(id)transformedValue:(id)value {
	//    NSData* coreDataImage = [NSData dataWithData:UIImagePNGRepresentation(value)];
    //return UIImagePNGRepresentation(value);
    return UIImageJPEGRepresentation(value, 1.0);
}

-(id)reverseTransformedValue:(id)value {
  return [[UIImage alloc] initWithData:value ];
}

@end

// http://stackoverflow.com/questions/2681630/how-to-read-png-image-to-nsimage
// https://developer.apple.com/library/ios/#samplecode/PhotoLocations/Listings/Classes_UIImageToDataTransformer_m.html#//apple_ref/doc/uid/DTS40008909-Classes_UIImageToDataTransformer_m-DontLinkElementID_14
// http://petermcintyre.com/topics/uiimage-in-core-data/
// http://stackoverflow.com/questions/9383682/trouble-with-core-data-transformable-attributes-for-images