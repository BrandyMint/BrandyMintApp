//
//  AboutViewController.m
//  Brandymint
//
//  Created by DenisDbv on 18.03.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import "AboutViewController.h"
#import "BlockView.h"
#import "LinksView.h"

@interface AboutViewController ()

@end

@implementation AboutViewController
{
    UIView *rootView;
    UIView *aboveView;
}

- (id)initWithView:(UIView*)mainView above:(UIView*)topView
{
    self = [super initWithNibName:@"AboutViewController" bundle:[NSBundle mainBundle]];
    if (self) {
        rootView = mainView;
        aboveView = topView;
        //[self showAboutView];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

-(void) viewWillAppear:(BOOL)animated
{
    self.view.backgroundColor = [UIColor clearColor];

    for (Bloc *bloc in [[BlocsRepository sharedBlocsRepository] entitiesBuffer])
    {
        BlockView * blockView = (BlockView*)[self.view viewWithTag: bloc.position.integerValue ];
        if([blockView isKindOfClass:[BlockView class]])  {
            [blockView fillView: bloc];
        }
    }
}

-(void) showAboutView
{
    CGRect aboutViewFrame = self.view.frame;
    aboutViewFrame.origin.y = self.view.frame.size.height;
    self.view.frame = aboutViewFrame;
    
    [rootView insertSubview:self.view aboveSubview:aboveView];
    
    [UIView animateWithDuration:0.2
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         CGRect rect = aboutViewFrame;
                         rect.origin.y = 0;
                         self.view.frame = rect;
                     }
                     completion:^(BOOL finished){
                        //
                     }];
}

-(void) hideAboutView
{
    CGRect aboutViewFrame = self.view.frame;
    
    [rootView insertSubview:self.view aboveSubview:aboveView];
    
    [UIView animateWithDuration:0.2
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         CGRect rect = aboutViewFrame;
                         rect.origin.y = aboutViewFrame.size.height;
                         self.view.frame = rect;
                     }
                     completion:^(BOOL finished){
                         [self.view removeFromSuperview];
                     }];
}

@end
