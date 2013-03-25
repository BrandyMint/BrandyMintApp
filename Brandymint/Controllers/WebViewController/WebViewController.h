//
//  WebViewController.h
//  Brandymint
//
//  Created by denisdbv@gmail.com on 25.03.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController

@property (strong, nonatomic) IBOutlet UINavigationBar *navBar;
@property (strong, nonatomic) IBOutlet UIWebView *webView;

-(id)initWithURL:(NSURL*)url;

@end
