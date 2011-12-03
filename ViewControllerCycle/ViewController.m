//
//  ViewController.m
//  ViewControllerCycle
//
//  Created by Ashley McCoy on 1/12/11.
//  Copyright (c) 2011 Mindeater Web Services. All rights reserved.
//

#import "ViewController.h"

#import "SingleViewController.h"

@implementation ViewController

@synthesize vc1,vc2,vc3;
@synthesize currIndex,prevIndex,nextIndex;
@synthesize dataModel;
@synthesize nav;
@synthesize vcIndex;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor blackColor];
	// Do any additional setup after loading the view, typically from a nib.
    NSLog(@"Starting View");
    self.dataModel = [NSArray arrayWithObjects:
                 @"First",
                 @"Second",
                 @"Third",
                 @"Fourth",
                 @"Fifth",
                 @"Sixth",
                 @"Seventh",
                 @"Eighth",
                 @"Nineth",
                 @"Tenth",
                 @"Last",
                 nil];
                 
    
    // create 3 View Controllers
    vc1 = [[SingleViewController alloc] init]; 
    vc2 = [[SingleViewController alloc] init]; 
    vc3 = [[SingleViewController alloc] init]; 
    
    // connect back - should use a delgate pattern here but hey we are telling the object what it needs to know.
    vc1._parent = self;
    vc2._parent = self;
    vc3._parent = self;
    
    // populate their content
    prevIndex = [dataModel count]-1;
    currIndex = 0;
    nextIndex = 1;
    
    vc1.viewName = [dataModel objectAtIndex:prevIndex];
    vc2.viewName = [dataModel objectAtIndex:currIndex];
    vc3.viewName = [dataModel objectAtIndex:nextIndex];
    
    // push the first two onto the stack as a start
    self.nav = [[UINavigationController alloc] initWithRootViewController:self];
    self.nav.view.frame = CGRectMake(0, 0, 320, 460);

    NSArray *newStack = [NSArray arrayWithObjects:vc1,vc2, nil];
    [self.nav setViewControllers:newStack animated:YES];
    
    vcIndex = 2; // starting view controller sample
    
    [self.view addSubview:self.nav.view];
    
    self.nav.topViewController.title = [NSString stringWithFormat:@": %d :",currIndex];
}

-(void)resetViewControllers
{
    // don't really us these
    // calculate next and previous based on current
    nextIndex = (currIndex >= [self.dataModel count]-1) ? 0 : currIndex + 1;
    prevIndex = (currIndex <= 0) ? [self.dataModel count]-1 : currIndex - 1;
    
    NSArray *newStack;
    switch (vcIndex) {
        case 0:
            newStack = [NSArray arrayWithObjects:vc2,vc3, nil];
            // set the top view controllers data    
            vc3.viewName = [dataModel objectAtIndex:currIndex];
            break;
        case 1:
            newStack = [NSArray arrayWithObjects:vc3,vc1, nil];
            vc1.viewName = [dataModel objectAtIndex:currIndex];
            break;
        case 2:
            newStack = [NSArray arrayWithObjects:vc1,vc2, nil];
            vc2.viewName = [dataModel objectAtIndex:currIndex];
            break;
        default:
            break;
    }
    [self.nav setViewControllers:newStack animated:YES];
}

-(void)nextItem:(id)sender
{
    vcIndex = (vcIndex >= 2) ? vcIndex = 0 : vcIndex + 1;
    
    // shift the data counter
    currIndex = (currIndex >= [self.dataModel count]-1) ? 0 : currIndex + 1; 
    
    [self resetViewControllers];
    self.nav.topViewController.title = [NSString stringWithFormat:@": %d :",vcIndex];    
}

-(void)prevItem:(id)sender
{
    vcIndex = (vcIndex <= 0) ? vcIndex = 2 : vcIndex - 1;
    
    // Subtract one from the currentIndex or go to the end if we have reached the beginning.         
    currIndex = (currIndex == 0) ? [self.dataModel count] -1 : currIndex - 1;
    
    [self resetViewControllers];
    self.nav.topViewController.title = [NSString stringWithFormat:@": %d :",vcIndex];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
