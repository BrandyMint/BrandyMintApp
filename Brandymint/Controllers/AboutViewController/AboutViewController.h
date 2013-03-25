//
//  AboutViewController.h
//  Brandymint
//
//  Created by DenisDbv on 18.03.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OwnViewController.h"
#import "BlockView.h"
#import "LinksView.h"
#import "Bloc.h"
#import "Link.h"

@interface AboutViewController : UIViewController <RootViewDelegate>

@property (nonatomic, retain) IBOutlet BlockView *blockView;
@property (nonatomic, retain) IBOutlet LinksView *linksView;

@property(nonatomic,assign)id delegate;

- (id)initWithView:(UIView*)mainView above:(UIView*)topView;

-(void) showAboutView;
-(void) hideAboutView;

@end
