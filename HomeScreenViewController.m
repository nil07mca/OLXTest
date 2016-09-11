//
//  HomeScreenViewController.m
//  OLXTest
//
//  Created by Macbook on 11/09/16.
//  Copyright © 2016 Macbook. All rights reserved.
//

#import "HomeScreenViewController.h"
#import "RFQuiltLayout.h"
#import "Categories.h"
#import "DataManager.h"

@interface HomeScreenViewController ()<RFQuiltLayoutDelegate> {
    
}

@property (nonatomic) NSMutableArray* arrItems;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@end

@implementation HomeScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Categories";
    [self setUpLayout];
    [self initiateData];
    // Do any additional setup after loading the view from its nib.
}

- (void) viewDidAppear:(BOOL)animated {
    [self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpLayout {
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    RFQuiltLayout* layout = (id)[self.collectionView collectionViewLayout];
    layout.direction = UICollectionViewScrollDirectionVertical;
    layout.blockPixels = CGSizeMake(self.view.frame.size.width/4,self.view.frame.size.width/4);
//    self.collectionView.translatesAutoresizingMaskIntoConstraints = false;
}

- (void)initiateData {
    _arrItems = [NSMutableArray arrayWithArray:[[DataManager sharedManager] categoryList]];
}

#pragma mark - UICollectionView Delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self tappedOnIndexPath:indexPath];
}
#pragma mark - UICollectionView Datasource

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return _arrItems.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    Categories* categories = [_arrItems objectAtIndex:indexPath.row];
    UIImageView *cellImage = [[UIImageView alloc] init];
    cellImage.frame = cell.bounds ;
    
    [cellImage setClipsToBounds:YES];
    
    cellImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:categories.imageURL]]];
    cellImage.translatesAutoresizingMaskIntoConstraints = NO;
    cellImage.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [cell addSubview:cellImage];
    return cell;
}

#pragma mark – CustomLayoutDelegate


-(CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout blockSizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row >= _arrItems.count) {
        NSLog(@"Asking for index paths of non-existant cells!! %ld from %lu cells", (long)indexPath.row, (unsigned long)_arrItems.count);
    }
    
    Categories* categories = [_arrItems objectAtIndex:indexPath.row];
    return CGSizeMake(categories.categoryWeight, 1);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetsForItemAtIndexPath:(NSIndexPath *)indexPath {
    return UIEdgeInsetsMake(2, 2, 2, 2);
}


- (void)tappedOnIndexPath:(NSIndexPath *)indexPath {
    for (Categories* cat in _arrItems) {
        cat.isRecentVisited = NO ;
        //        cat.categoryWeight = 1 ;
    }
    Categories* categories = [_arrItems objectAtIndex:indexPath.row];
    categories.isRecentVisited = YES ;
    categories.visitCount++ ;
    int maxWeight = 1;
    if (categories.categoryWeight<3) {
        categories.categoryWeight++;
        maxWeight = categories.categoryWeight ;
    }
    //    [self reoderCategories];
    for (Categories* cat in _arrItems) {
        if (!cat.isRecentVisited && cat.categoryWeight == maxWeight) {
            if (cat.categoryWeight>1) {
                cat.categoryWeight--;
            }
        }
    }
    [self.collectionView reloadData];
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
