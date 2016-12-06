//
//  ViewController.h
//  AnimatedPreloader
//
//  Created by Admin on 25/11/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PreloaderView.h"

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet PreloaderView *prealoder;

- (void) animatePreloader;

@end

