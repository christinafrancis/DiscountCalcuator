//
//  CFViewController.h
//  Discount_calculator
//
//  Created by Christina Francis on 10/2/13.
//  Copyright (c) 2013 Christina Francis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PriceDetails.h"

@interface CFViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *tf_price;
@property (weak, nonatomic) IBOutlet UITextField *tf_dollorsOff;
@property (weak, nonatomic) IBOutlet UITextField *tf_disc;
@property (weak, nonatomic) IBOutlet UITextField *tf_addDisc;
@property (weak, nonatomic) IBOutlet UITextField *tf_tax;
@property (weak, nonatomic) UITextField *activeTF;
@property (weak, nonatomic) IBOutlet UILabel *lb_result;
@property PriceDetails* p1;
@property BOOL calc_clicked;

@end
