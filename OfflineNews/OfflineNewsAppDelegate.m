//
//  OfflineNewsAppDelegate.m
//  OfflineNews
//
//  Created by Evgeny Yagrushkin on 11-02-28.
//  Copyright 2011 JekSoft. All rights reserved.
//

#import "OfflineNewsAppDelegate.h"

@implementation OfflineNewsAppDelegate


@synthesize window=_window;

@synthesize tabBarController=_tabBarController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    // Add the tab bar controller's current view as a subview of the window
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    
    // create view for the welcome screen
    UIView *welcomeView = [[[UIView alloc] initWithFrame:[self.window frame]] autorelease];
    
    // program name
	UILabel *titleLable;
	titleLable = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)] autorelease];
	[titleLable setFont:[UIFont systemFontOfSize:30.0]];
	[titleLable setTextColor:[UIColor blackColor]];
	[titleLable setHighlightedTextColor:[UIColor clearColor]];
	[titleLable setBackgroundColor:[UIColor clearColor]];
	[titleLable setText:@"Offline news"];
    [titleLable setAlpha:1.0];
	CGSize aSize = [titleLable.text sizeWithFont:[UIFont systemFontOfSize:30]];
    titleLable.frame = CGRectMake(0, 0, aSize.width, aSize.height);
    titleLable.center = CGPointMake(320/2, 480/2);
    [welcomeView addSubview:titleLable];
   
    // copyright name
	UILabel *titleCopyRight;
	titleCopyRight = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)] autorelease];
	[titleCopyRight setFont:[UIFont systemFontOfSize:15.0]];
	[titleCopyRight setTextColor:[UIColor blackColor]];
	[titleCopyRight setHighlightedTextColor:[UIColor clearColor]];
	[titleCopyRight setBackgroundColor:[UIColor clearColor]];
	[titleCopyRight setText:@"(c) 2011 Eugene Yagrushkin"];
    [titleCopyRight setAlpha:1.0];
	aSize = [titleCopyRight.text sizeWithFont:[UIFont systemFontOfSize:15.0]];
    titleCopyRight.frame = CGRectMake(0, 0, aSize.width, aSize.height);
    titleCopyRight.center = CGPointMake(320/2, 400);

    [welcomeView addSubview:titleCopyRight];
    
    welcomeView.backgroundColor = [UIColor yellowColor];
    
    [self.window addSubview:welcomeView];

    // welcome screen animation
    [UIView animateWithDuration:2
                     animations:^{
                         
                         [titleLable setAlpha:0.0];
                         [titleCopyRight setAlpha:0.0];
                         [welcomeView setBackgroundColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.0]];
                         
                     }
                     completion:^(BOOL finished)
     {
         [welcomeView removeFromSuperview];
     }
     ];

    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc
{
    [_window release];
    [_tabBarController release];
    [super dealloc];
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

@end
