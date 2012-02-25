//
//  SecondViewController.h
//  OfflineNews
//
//  Created by Evgeny Yagrushkin on 11-02-28.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SecondViewController : UIViewController {
    
}

@property (nonatomic, retain) IBOutlet UIWebView *web;

- (void)refreshWebView:(NSNotification *)note;
- (void)loadData:(NSString *)name; 

@end
