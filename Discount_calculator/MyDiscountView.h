//
//  MyDiscountView.h
//  Discount_calculator
//
//  Created by Christina Francis on 10/2/13.
//  Copyright (c) 2013 Christina Francis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PriceDetails.h"



@interface MyDiscountView : UIView

@property (weak, nonatomic) IBOutlet UILabel *lb_price;
@property (weak, nonatomic) IBOutlet UILabel *lb_save_price;
@property (weak, nonatomic) IBOutlet UILabel *lb_save_perc;
@property (weak, nonatomic) IBOutlet UILabel *lb_disc_price;
@property (weak, nonatomic) IBOutlet UILabel *lb_disc_perc;


@property unsigned int demo;

@end