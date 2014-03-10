//
//  MainViewController.m
//  FoodShaming
//
//  Created by Vanessa Grass on 3/9/14.
//  Copyright (c) 2014 Vanessa Grass. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *foodView;
@property (weak, nonatomic) IBOutlet UIImageView *profileView;
@property (weak, nonatomic) IBOutlet UIView *mealPost;


@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.foodView.layer.borderColor = [UIColor colorWithRed:255.0f/255.0f green:212.0f/255.0f blue:120.0f/255.0f alpha:1.0f].CGColor;
    self.foodView.layer.borderWidth = 0.5;
   
    self.mealPost.layer.shadowColor = [UIColor blackColor].CGColor;
    self.mealPost.layer.shadowOffset = CGSizeMake(0,1);
    self.mealPost.layer.shadowOpacity = 0.25;
    
     self.mealPost.layer.cornerRadius = 2;
    
    self.navigationItem.title = @"FoodShaming";
    self.navigationController.navigationBar.barStyle=UIBarStyleBlack;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:255.0f/255.0f green:212.0f/255.0f blue:120.0f/255.0f alpha:1.0f];
    
    
    //left button
    UIBarButtonItem *leftButton =[[UIBarButtonItem alloc] init];
    self.navigationItem.leftBarButtonItem = leftButton;
    self.navigationItem.leftBarButtonItem.image=[UIImage imageNamed:@"back"];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];

    // Configure the left button with text
    //UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Left" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    self.navigationItem.leftBarButtonItem = leftButton;
    
    //right button
    UIBarButtonItem *rightButton =[[UIBarButtonItem alloc] init];
    self.navigationItem.rightBarButtonItem = rightButton;
    self.navigationItem.rightBarButtonItem.image=[UIImage imageNamed:@"share"];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    
    // Configure the right button with text
    //UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Right" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    self.navigationItem.rightBarButtonItem = rightButton;
    
    
    
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
