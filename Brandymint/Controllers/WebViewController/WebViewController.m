//
//  WebViewController.m
//  Brandymint
//
//  Created by denisdbv@gmail.com on 25.03.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController
{
    NSURL* _url;
}

@synthesize navBar;
@synthesize webView;

-(id)initWithURL:(NSURL*)url
{
  self = [super initWithNibName:nil bundle:nil];
  if (self) {
      _url = url;
  }
  return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
  
    [self.webView loadRequest:[NSURLRequest requestWithURL:_url]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(IBAction) onBackButton:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction) onOpenInButton:(id)sender
{
    [[UIApplication sharedApplication] openURL:_url];
}

@end
