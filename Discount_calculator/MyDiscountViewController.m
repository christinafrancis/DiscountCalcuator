//
//  MyDiscountViewController.m
//  Discount_calculator
//
//  Created by Christina Francis on 10/2/13.
//  Copyright (c) 2013 Christina Francis. All rights reserved.
//

#import "MyDiscountViewController.h"

@implementation MyDiscountViewController

-(void) setPrice_obj:(PriceDetails *)p2{
    
    self.p1 = [[PriceDetails alloc] init];
    
    self.p1.price = p2.price;
    self.p1.save_price = p2.save_price;
    self.p1.save_perc = p2.save_perc;
    self.p1.disc_price = p2.disc_price;
    self.p1.disc_perc = p2.disc_perc;
    NSLog(@"p1 price is %f", self.p1.price);
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    self.lb_price.text = [NSString stringWithFormat:@"Total: $%.2f",self.p1.price];
    self.lb_save_price.text = [NSString stringWithFormat:@"$%.2f",self.p1.save_price];
    self.lb_save_perc.text = [NSString stringWithFormat:@"%.2f%%",self.p1.save_perc];
    self.lb_disc_price.text = [NSString stringWithFormat:@"$%.2f",self.p1.disc_price];
    self.lb_disc_perc.text = [NSString stringWithFormat:@"%% after Discount: %.2f%%",self.p1.disc_perc];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
