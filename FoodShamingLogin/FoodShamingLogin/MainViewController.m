//
//  MainViewController.m
//  FoodShamingLogin
//
//  Created by Vanessa Grass on 3/17/14.
//  Copyright (c) 2014 Vanessa Grass. All rights reserved.
//

#import "MainViewController.h"
#import "NewsViewController.h"

@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;
@property (weak, nonatomic) IBOutlet UITextField *loginText;
@property (weak, nonatomic) IBOutlet UIView *logInUX;
@property (weak, nonatomic) IBOutlet UIButton *buttonView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;
@property (weak, nonatomic) IBOutlet UIView *buttonContainerView;

- (IBAction)onTap:(id)sender;
- (IBAction)onLoginButton:(id)sender;
- (void)checkPassword;


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
    self.passwordText.delegate = self;
    
    self.buttonView.enabled = NO;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextField delegate methods

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    NSString *otherText;
    if (textField == self.emailField) {
        otherText = self.passwordText.text;
    } else {
        otherText = self.emailField.text;
    }
    
    if (![text isEqual:@""] && ![otherText isEqual:@""]) {
        self.buttonView.enabled = YES;
    } else {
        self.buttonView.enabled = NO;
    }
    
    return YES;
}

#pragma mark - Private methods

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)onLoginButton:(id)sender {
    [self.buttonView setImage:[UIImage imageNamed:@"logging-in-btn"] forState:UIControlStateNormal];
    [self.activityView startAnimating];
    
    [self.view endEditing:YES];
    self.view.userInteractionEnabled = NO;
    
    [self performSelector:@selector(checkPassword) withObject:nil afterDelay:4];
}

- (void)checkPassword {
    if ([self.passwordText.text isEqualToString:@"password"]) {
        UITabBarController *tabBarController = [[UITabBarController alloc] init];
        tabBarController.tabBar.barTintColor = [UIColor whiteColor];
        
        NewsViewController *newsViewController = [[NewsViewController alloc] init];
        UINavigationController *newsNavigationController = [[UINavigationController alloc] initWithRootViewController:newsViewController];
        newsNavigationController.navigationBar.barTintColor = [UIColor colorWithRed:68/255.0 green:99/255.0 blue:161/255.0 alpha:1];
        newsNavigationController.navigationBar.titleTextAttributes = @{ NSForegroundColorAttributeName : [UIColor whiteColor] };
        newsNavigationController.navigationBar.translucent = NO;
        newsViewController.tabBarItem.title = @"News";
        newsViewController.tabBarItem.image = [UIImage imageNamed:@"news_tab"];
        
        UIViewController *requestsViewController = [[UIViewController alloc] init];
        UINavigationController *requestsNavigationController = [[UINavigationController alloc] initWithRootViewController:requestsViewController];
        requestsNavigationController.navigationBar.barTintColor = [UIColor colorWithRed:68/255.0 green:99/255.0 blue:161/255.0 alpha:1];
        requestsViewController.tabBarItem.title = @"Requests";
        requestsViewController.tabBarItem.image = [UIImage imageNamed:@"news_tab"];
        
        UIViewController *messagesViewController = [[UIViewController alloc] init];
        UINavigationController *messagesNavigationController = [[UINavigationController alloc] initWithRootViewController:messagesViewController];
        messagesNavigationController.navigationBar.barTintColor = [UIColor colorWithRed:68/255.0 green:99/255.0 blue:161/255.0 alpha:1];
        messagesViewController.tabBarItem.title = @"Messages";
        messagesViewController.tabBarItem.image = [UIImage imageNamed:@"news_tab"];
        
        UIViewController *notificationsViewController = [[UIViewController alloc] init];
        UINavigationController *notificationsNavigationController = [[UINavigationController alloc] initWithRootViewController:notificationsViewController];
        notificationsNavigationController.navigationBar.barTintColor = [UIColor colorWithRed:68/255.0 green:99/255.0 blue:161/255.0 alpha:1];
        notificationsViewController.tabBarItem.title = @"Notifications";
        notificationsViewController.tabBarItem.image = [UIImage imageNamed:@"news_tab"];
        
//        MoreViewController *moreViewController = [[MoreViewController alloc] init];
//        UINavigationController *moreNavigationController = [[UINavigationController alloc] initWithRootViewController:moreViewController];
//        moreNavigationController.navigationBar.barTintColor = [UIColor colorWithRed:68/255.0 green:99/255.0 blue:161/255.0 alpha:1];
//        moreNavigationController.navigationBar.translucent = NO;
//        moreViewController.tabBarItem.title = @"More";
//        moreViewController.tabBarItem.image = [UIImage imageNamed:@"news_tab"];
//        
//        tabBarController.viewControllers = @[newsNavigationController, requestsNavigationController, messagesNavigationController, notificationsNavigationController, moreNavigationController];
        
        tabBarController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:tabBarController animated:YES completion:nil];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Incorrect Password" message:@"The password you entered is incorrect. Please try again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    
    [self.buttonView setImage:[UIImage imageNamed:@"login_button"] forState:UIControlStateNormal];
    [self.activityView stopAnimating];
    self.view.userInteractionEnabled = YES;
}


-(void)showLoading:(id)sender {
    
}

//loading screen
//-(void)enter {
//    [self dismissViewControllerAnimated:YES completion:Nil];
//    loadingViewController *loading = [[loadingViewController alloc] init];
//    
//    loading.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//  
//}


//login

//- (IBAction)logIn:(id)sender {
//    if(![self.loginText.text isEqualToString:@"email"] && ![self.passwordText.text isEqualToString:@"password"]){
//        NSString *message = @"Wrong password. Try again.";
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Incorrect Password" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//    }else{
//        [self performSelector:@selector(enter) withObject:nil afterDelay:0];
//    }
//
//}



//dismiss keyboard
//- (IBAction)onTap:(id)sender {
//    [self.view endEditing:YES];
//}
//
//- (IBAction)onLoginButton:(id)sender {
//}

//login button
- (IBAction)logInBtn:(id)sender {
    
}
@end
