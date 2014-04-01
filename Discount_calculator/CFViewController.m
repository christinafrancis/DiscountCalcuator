//
//  CFViewController.m
//  Discount_calculator
//
//  Created by Christina Francis on 10/2/13.
//  Copyright (c) 2013 Christina Francis. All rights reserved.
//

#import "CFViewController.h"
#import "UITextField+nextTextField.h"

#include "MyDiscountViewController.h"

@interface CFViewController ()
- (IBAction)handleCalculate:(id)sender;

@end

@implementation CFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.tf_price.nextTextField = self.tf_dollorsOff;
    self.tf_dollorsOff.nextTextField = self.tf_disc;
    self.tf_disc.nextTextField = self.tf_addDisc;
    self.tf_addDisc.nextTextField = self.tf_tax;
    self.tf_tax.nextTextField = self.tf_price;
  
    self.tf_price.prevTextField = self.tf_tax;
    self.tf_dollorsOff.prevTextField = self.tf_price;
    self.tf_disc.prevTextField = self.tf_dollorsOff;
    self.tf_addDisc.prevTextField = self.tf_disc;
    self.tf_tax.prevTextField = self.tf_addDisc;
    
    self.lb_result.text = @" ";
    UISwipeGestureRecognizer* swipeRightGestureRecognizer =
    [[UISwipeGestureRecognizer alloc] initWithTarget: self
                                              action: @selector(handleSwipeRightFrom:)];
    swipeRightGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer: swipeRightGestureRecognizer];
    
    self.calc_clicked = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)touchesBegan: (NSSet *) touches withEvent: (UIEvent *) event
{
    NSLog( @"resigning first respond for inputTextField; Touch event!" );
    if ( ! [self isFirstResponder]) {
        if ([self.tf_price isFirstResponder]) {
            [self.tf_price resignFirstResponder];
        }
        if ([self.tf_dollorsOff isFirstResponder]) {
            [self.tf_dollorsOff resignFirstResponder];
        }
        if ([self.tf_disc isFirstResponder]) {
            [self.tf_disc resignFirstResponder];
        }
        if ([self.tf_addDisc isFirstResponder]) {
            [self.tf_addDisc resignFirstResponder];
        }
        if ([self.tf_tax isFirstResponder]) {
            [self.tf_tax resignFirstResponder];
        }
        
    }
    
}

- (void)nextClicked: (UIBarButtonItem*) sender
{
    UITextField* next = self.activeTF.nextTextField;
    if (next) {
        [next becomeFirstResponder];
    }
}

- (void)previousClicked: (UIBarButtonItem*) sender
{
    UITextField* next = self.activeTF.prevTextField;
    if (next) {
        [next becomeFirstResponder];
    }
}

- (void) doneClicked: (UIBarButtonItem*) sender
{
    NSLog( @"done pressed resigning first respond for inputTextField; Touch event!" );
    [self.activeTF resignFirstResponder];
}



- (BOOL)textFieldShouldBeginEditing: (UITextField *) textField
{
    self.activeTF = textField;
    NSLog(@"Right before");
    
    //[self.lb_result setHidden:YES];
    
    self.lb_result.text = @"  ";
    
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    [toolbar sizeToFit];
    
    UIBarButtonItem *prevButton = [[UIBarButtonItem alloc]
                                   initWithTitle: @"Previous"
                                   style: UIBarButtonItemStyleDone
                                   target: self
                                   action:@selector(previousClicked:)];
    
    UIBarButtonItem *nextButton = [[UIBarButtonItem alloc]
                                   initWithTitle: @"Next"
                                   style: UIBarButtonItemStyleDone
                                   target: self
                                   action:@selector(nextClicked:)];
    
    UIBarButtonItem *flexButton = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace
                                   target: self
                                   action: nil];
    
    UIBarButtonItem *doneButton =[[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem: UIBarButtonSystemItemDone
                                  target: self
                                  action: @selector(doneClicked:)];
    
    NSArray* itemsArray = @[prevButton, nextButton, flexButton, doneButton];
    
    [toolbar setItems: itemsArray];
    
    [textField setInputAccessoryView: toolbar];
    
    return YES;
}



- (IBAction)handleCalculate:(id)sender {
    
    float price = [[NSDecimalNumber decimalNumberWithString:[self.tf_price text]] floatValue];
    float dollorsOff = [[NSDecimalNumber decimalNumberWithString:[self.tf_dollorsOff text]] floatValue];
    
    float disc = [[NSDecimalNumber decimalNumberWithString:[self.tf_disc text]] floatValue];
    float addDisc = [[NSDecimalNumber decimalNumberWithString:[self.tf_addDisc text]] floatValue];
    float tax = [[NSDecimalNumber decimalNumberWithString:[self.tf_tax text]] floatValue];
    
    
    if(dollorsOff > price) {
        self.lb_result.text = @" Dollors Off should be less than price ";
        self.calc_clicked = NO;
    }
    
    else if(disc > 100 || addDisc > 100 || tax > 100){
        self.lb_result.text = @" Percentage values should be less than 100 ";
        self.calc_clicked = NO;
    }
    else if ([self.tf_price.text length] != 0 && [self.tf_dollorsOff.text length] != 0 && [self.tf_disc.text length] != 0 && [self.tf_addDisc.text length] != 0 && [self.tf_tax.text length] != 0) {
        
    
    self.p1 = [[PriceDetails alloc] init];

    float tax_price;
        
        
        // All values are calculated here
    tax_price = ( tax / 100 ) * price ;
    self.p1.price = price + tax_price;
    self.p1.disc_price = ( ( price * (1-disc/100) * (1-addDisc/100) ) - dollorsOff ) + tax_price;
    self.p1.save_price = self.p1.price - self.p1.disc_price;
    
    self.p1.disc_perc = ( self.p1.disc_price/self.p1.price ) * 100;
    self.p1.save_perc = 100 - self.p1.disc_perc;
    
    NSLog(@"result: %f = price ; %f = disc_price; %.2f = save_price; %f = disc_perc; %f = save_perc ",self.p1.price,self.p1.disc_price,self.p1.save_price,self.p1.disc_perc,self.p1.save_perc);
    
    self.lb_result.text = [NSString stringWithFormat:@"Original Price:%.2f ;Discount Price:%.2f",self.p1.price,self.p1.disc_price];
        
        self.calc_clicked = YES;
        
        if(self.p1.disc_perc < 0 || self.p1.save_perc < 0) {
            self.lb_result.text = @" Error in entered values: Discount Price negative";
            self.calc_clicked = NO;
        }
    }
    else{
        self.lb_result.text = @" Fields cannot be empty ";
        self.calc_clicked = NO;
    }
}

- (void)handleSwipeRightFrom:(UIGestureRecognizer*)recognizer {
    if(self.calc_clicked){
        [self performSegueWithIdentifier:@"mainToDisplay" sender:self];
    }
    else{
        self.lb_result.text = @" Click on Calculate before swipe ";
    }
}

// This will get called too before the view appears
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    NSLog(@" inside cfViewcont prerare for segue");
    
    if ([[segue identifier] isEqualToString:@"mainToDisplay"] ) {
        
        // Get destination view
        MyDiscountViewController *vc = [segue destinationViewController];
        
        
        // Pass the information to your destination view
                NSLog(@"p1.price is %f",self.p1.price);
        [vc setPrice_obj:self.p1];
        NSLog(@"p1.price is %f",self.p1.price);
        
        NSLog(@"End of prepare for segue..");
    }
}

@end
