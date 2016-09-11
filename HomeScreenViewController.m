//
//  HomeScreenViewController.m
//  OLXTest
//
//  Created by Macbook on 11/09/16.
//  Copyright © 2016 Macbook. All rights reserved.
//

#import "HomeScreenViewController.h"

@interface HomeScreenViewController ()

@property (nonatomic) NSMutableArray* arrItems;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@end

@implementation HomeScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Categories";
    // Do any additional setup after loading the view from its nib.
}

- (void) viewDidAppear:(BOOL)animated {
    [self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
