//
//  OwnViewController.h
//  Brandymint
//
//  Created by denisdbv@gmail.com on 07.03.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuartzCore/QuartzCore.h"

@protocol RootViewDelegate
@optional
-(void)willAboutViewHide;
@end

@interface OwnViewController : UIViewController <RootViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *contextContainerView;
@property (strong, nonatomic) IBOutlet UIScrollView *cardsScrollView;
@property (nonatomic, strong) IBOutlet UIPageControl *pageControl;
@property (nonatomic, strong) IBOutlet UIImageView *logo;

@property (nonatomic, strong) IBOutlet UIButton *cloudBtn;

-(IBAction) onCloudClick:(id)sender;

@end
