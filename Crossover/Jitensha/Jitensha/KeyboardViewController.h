//
//  KeyboardViewController.h
//  Jitensha
//
//  Created by Admin on 11/12/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KeyboardViewController : UIViewController

- (void)keyboardWillShow:(NSNotification *)note;
- (void)keyboardWillHide:(NSNotification *)note;

@end
