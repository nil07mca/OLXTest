//
//  WelcomeViewController.m
//  OLXTest
//
//  Created by Macbook on 11/09/16.
//  Copyright © 2016 Macbook. All rights reserved.
//

#import "WelcomeViewController.h"
#import "HomeScreenViewController.h"
#import "DataManager.h"

@interface WelcomeViewController ()<DataManagerDelegate> {
    
}
@property (weak, nonatomic) IBOutlet UIImageView *mostVisitedImageView;
@property (weak, nonatomic) IBOutlet UIButton *btnListing;
@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _btnListing.hidden = YES ;
    [DataManager sharedManager].delegate = self;
    [[DataManager sharedManager] fetchCategoryList];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    Categories* category = [[DataManager sharedManager] getRecentCategoty];
    if (category.isRecentVisited == YES) {
        [_mostVisitedImageView setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:category.imageURL]]]];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tapGoListing:(id)sender {
    HomeScreenViewController* home = [[HomeScreenViewController alloc] initWithNibName:@"HomeScreenViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:home animated:YES];
}

#pragma mark - DataManagerDelegate
- (void)dataLoadCompletedWithData:(NSArray*)data {
    _btnListing.hidden = NO ;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
