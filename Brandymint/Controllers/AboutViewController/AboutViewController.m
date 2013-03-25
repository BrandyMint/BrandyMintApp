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
    [self setHookOnMovingFinger];
  
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

-(void) setHookOnMovingFinger
{
    UISwipeGestureRecognizer *recognizer;
  
    recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(hideAboutViewToUp:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionUp)];
    [[self view] addGestureRecognizer:recognizer];
  
    recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(hideAboutViewToDown:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionDown)];
    [[self view] addGestureRecognizer:recognizer];
}

-(void) showAboutView
{
    CGRect aboutViewFrame = self.view.frame;
    aboutViewFrame.origin.y = rootView.frame.size.height;
    self.view.frame = aboutViewFrame;
    
    [rootView addSubview:self.view];
  
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
    [self hideAboutViewToDirection:NO];
}

-(void) hideAboutViewToDirection:(BOOL)isTop
{
    CGRect aboutViewFrame = self.view.frame;
    
    [UIView animateWithDuration:0.2
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         CGRect rect = aboutViewFrame;
                       
                         if(isTop)
                           rect.origin.y = -rootView.frame.size.height;
                         else
                           rect.origin.y = rootView.frame.size.height;
                       
                         self.view.frame = rect;
                     }
                     completion:^(BOOL finished){
                         [self.view removeFromSuperview];
                     }];
  
    if([delegate respondsToSelector:@selector(willAboutViewHide)])
    {
        [delegate willAboutViewHide];
    }
}

-(void) hideAboutViewToDown:(UISwipeGestureRecognizer *)recognizer
{
    [self hideAboutViewToDirection:NO];
}

-(void) hideAboutViewToUp:(UISwipeGestureRecognizer *)recognizer
{
    [self hideAboutViewToDirection:YES];
}

@end
