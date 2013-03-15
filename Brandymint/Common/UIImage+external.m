//
//  UIImage+external.m
//  Brandymint
//
//  Created by denisdbv@gmail.com on 15.03.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import "UIImage+external.h"

@implementation UIImage (Resize)

- (UIImage*)scaleToSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0.0, size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, size.width, size.height), self.CGImage);
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;
}
@end
