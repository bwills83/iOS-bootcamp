//
//  MainViewController.m
//  FoodShamingLogin
//
//  Created by Vanessa Grass on 3/17/14.
//  Copyright (c) 2014 Vanessa Grass. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;
@property (weak, nonatomic) IBOutlet UITextField *loginText;
@property (weak, nonatomic) IBOutlet UIView *logInUX;

- (IBAction)onTap:(id)sender;


@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //keyboard hide/show methods
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willShowKeyboard:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willHideKeyboard:) name:UIKeyboardWillHideNotification object:nil];
        
    }
    return self;
}


// hide keyboard
- (void)willHideKeyboard:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    
    NSNumber *durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration = durationValue.doubleValue;
    NSNumber *curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey];
    UIViewAnimationCurve animationCurve = curveValue.intValue;
    
    //CGSize kbSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:(animationCurve << 16)
                     animations:^{
                         self.logInUX.frame = CGRectMake(0, 77, 320, 306 );
                     }
                     completion:nil];
}

// show keyboard
- (void)willShowKeyboard:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    
    // keyboard height and width
    CGSize kbSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    NSLog(@"Height: %f Width: %f", kbSize.height, kbSize.width);
    
    // animation duration and curve
    NSNumber *durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration = durationValue.doubleValue;
    NSNumber *curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey];
    UIViewAnimationCurve animationCurve = curveValue.intValue;
    
    // move the view with the same duration and animation curve so that it will match with the keyboard animation
    [UIView animateWithDuration:animationDuration delay:0.0 options:(animationCurve << 14) animations:^
     {
         self.logInUX.frame = CGRectMake(0, self.view.frame.size.height - kbSize.height - self.logInUX.frame.size.height, 320, self.logInUX.frame.size.height);
     }
                     completion:nil];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.emailField.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)showLoading:(id)sender {
    
}

//loading screen
-(void)enter {
    [self dismissViewControllerAnimated:YES completion:Nil];
    loadingViewController *loading = [[loadingViewController alloc] init];
    
    loading.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
  
}


//login

- (IBAction)logIn:(id)sender {
    if(![self.loginText.text isEqualToString:@"email"] && ![self.passwordText.text isEqualToString:@"password"]){
        NSString *message = @"Wrong password. Try again.";
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Incorrect Password" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }else{
        [self performSelector:@selector(enter) withObject:nil afterDelay:0];
    }

}



//dismiss keyboard
- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
}

//login button
- (IBAction)logInBtn:(id)sender {
    
}
@end
