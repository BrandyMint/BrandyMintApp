//
//  AboutViewController.h
//  Brandymint
//
//  Created by DenisDbv on 18.03.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Bloc.h"
#import "Link.h"

@interface AboutViewController : UIViewController

- (id)initWithView:(UIView*)mainView above:(UIView*)topView;

-(void) showAboutView;
-(void) hideAboutView;

@end
