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
    
    NSArray *blockSubviews = self.view.subviews;

    for (Bloc *bloc in [[BlocsRepository sharedBlocsRepository] entitiesBuffer])
    {
        /*TODO: To search for a tagged view, use the viewWithTag: method of UIView. This method performs a depth-first search of the receiver and its subviews. It does not search superviews or other parts of the view hierarchy. Thus, calling this method from the root view of a hierarchy searches all views in the hierarchy but calling it from a specific subview searches only a subset of views.*/
        
        //(BlockView*)[self.view viewWithTag: bloc.position.integerValue ];
        BlockView * blockView = [self blockWithTag:blockSubviews :bloc.position.integerValue];
        
        if([blockView isKindOfClass:[BlockView class]])  {
            [blockView fillView: bloc];
        }
    }
}

-(BlockView*) blockWithTag:(NSArray*)blocksView :(NSInteger)tag
{
    for(UIView *view in blocksView)
    {
        if(view.tag == tag)
            return (BlockView*)view;
    }
    return nil;
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
