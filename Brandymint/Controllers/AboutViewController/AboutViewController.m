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

@synthesize blockView;
@synthesize linksView;
@synthesize delegate;

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
    
    for (Bloc *bloc in [[BlocsRepository sharedInstance] entitiesBuffer])
    {
        UIView * blockContainer = (UIView*)[self.view viewWithTag: bloc.position.integerValue ];
        
        blockView = [[[NSBundle mainBundle] loadNibNamed:@"BlockView" owner:self options:nil] objectAtIndex:0];
        [blockView fillView: bloc];
        
        [blockContainer addSubview: blockView];
    }
    
    UIView * linksContainer = (UIView*)[self.view viewWithTag: 5 ];
    linksView = [[[NSBundle mainBundle] loadNibNamed:@"LinksView" owner:self options:nil] objectAtIndex:0];
    [linksContainer addSubview: linksView];
}

-(void) showAboutView
{
    self.view.alpha = 0;
    [rootView addSubview:self.view];
  
    [UIView animateWithDuration:0.2
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.view.alpha = 1;
                     }
                     completion:^(BOOL finished){
                        //
                     }];
}

-(void) hideAboutView
{
    [self hideAboutViewToDirection:UISwipeGestureRecognizerDirectionDown];
}

-(void) hideAboutViewToDirection:(UISwipeGestureRecognizerDirection)direction
{
    
    [UIView animateWithDuration:0.2
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.view.alpha = 0;
                     }
                     completion:^(BOOL finished){
                         [self.view removeFromSuperview];
                     }];
  
    if([delegate respondsToSelector:@selector(willAboutViewHide)])
    {
        [delegate willAboutViewHide];
    }
}

@end
