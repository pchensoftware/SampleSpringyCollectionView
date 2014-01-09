//
//  MyController.m
//  SampleSpringyCollectionView
//
//  Created by Peter Chen on 1/9/14.
//  Copyright (c) 2014 Peter Chen. All rights reserved.
//

#import "MyController.h"
#import "SpringyFlowLayout.h"

@interface MyController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation MyController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Springy Collection View";
    
    SpringyFlowLayout *springyLayout = [[SpringyFlowLayout alloc] init];
    springyLayout.itemSize = CGSizeMake(300, 50);
    springyLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:springyLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CellId"];
    [self.view addSubview:self.collectionView];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.collectionView.collectionViewLayout invalidateLayout];
}

//==================================================
#pragma mark - Collection view
//==================================================

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellId" forIndexPath:indexPath];
    cell.layer.cornerRadius = 5;
    cell.backgroundColor = [UIColor colorWithWhite:0.5 + arc4random_uniform(10)/30.0 alpha:1];
    return cell;
}

@end
