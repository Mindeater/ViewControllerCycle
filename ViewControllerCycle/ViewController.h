//
//  ViewController.h
//  ViewControllerCycle
//
//  Created by Ashley McCoy on 1/12/11.
//  Copyright (c) 2011 Mindeater Web Services. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SingleViewController;
@interface ViewController : UIViewController{
    
    SingleViewController *vc1;
    SingleViewController *vc2;
    SingleViewController *vc3;
    
    int prevIndex;
	int currIndex;
	int nextIndex;
    
    NSArray *dataModel;
    
    UINavigationController *nav;
    int vcIndex;
}

@property(nonatomic,retain)SingleViewController *vc1;
@property(nonatomic,retain)SingleViewController *vc2;
@property(nonatomic,retain)SingleViewController *vc3;

@property (nonatomic) int prevIndex;
@property (nonatomic) int currIndex;
@property (nonatomic) int nextIndex;

@property(nonatomic,retain)NSArray *dataModel;

@property(nonatomic,retain)UINavigationController *nav;
@property(nonatomic)int vcIndex;

-(void)nextItem:(id)sender;
-(void)prevItem:(id)sender;
-(void)resetViewControllers;

@end
