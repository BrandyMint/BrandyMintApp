//
//  AboutViewController.h
//  Brandymint
//
//  Created by DenisDbv on 18.03.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Bloc.h"

@interface AboutViewController : UIViewController
{
    NSArray *blocs;
}

@property (nonatomic, retain) NSArray *blocs;

- (id)initAboutController:(NSArray*)blocArray;

@end
