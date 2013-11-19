//
//  SCVViewController.m
//  SimpleCV
//
//  Created by Tim on 03/10/2013.
//  Copyright (c) 2013 Charismatic Megafauna Ltd. All rights reserved.
//

#import "SCVViewController.h"

@interface SCVViewController ()
@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *suitsArray;
@property (nonatomic, strong) NSArray *suitIcons;
@property (nonatomic, strong) NSDictionary *dataDictionary;
@end

@implementation SCVViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self setupData];
    [self configureCollectionView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Setup methods

-(void)setupData {
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"cards" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:filePath];

    NSError *error = nil;
    NSDictionary *cardsData = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];

    if (error) {
        return;
    }
    
    self.suitsArray = [cardsData objectForKey:@"suits"];
    
}

-(void)configureCollectionView {
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"SCVCollectionViewCell" bundle:Nil] forCellWithReuseIdentifier:@"SCVCollectionViewCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"SCVSectionHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SectionHeader"];
    //[self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"SectionFooter"];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];

    //[flowLayout setHeaderReferenceSize:CGSizeMake(self.collectionView.frame.size.width, 170.0f)];
    //[flowLayout setFooterReferenceSize:CGSizeMake(self.collectionView.frame.size.width, 75.0f)];
    
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [flowLayout setMinimumInteritemSpacing:20.0f];
    [flowLayout setMinimumLineSpacing:30.0f];
    [flowLayout setSectionInset:UIEdgeInsetsMake(25, 25, 25, 25)];
    
    [self.collectionView setCollectionViewLayout:flowLayout];
    
}

#pragma mark -
#pragma mark UICollectionView delegate methods

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.suitsArray count];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    NSDictionary *suitDictionary = [self.suitsArray objectAtIndex:section];
    
    NSArray *cardsArray = [suitDictionary objectForKey:@"cards"];
    
    return [cardsArray count];
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SCVCollectionViewCell" forIndexPath:indexPath];
    
    // Get suit
    NSDictionary *suitDictionary = [self.suitsArray objectAtIndex:indexPath.section];
    
    // Get cards
    NSArray *cardsArray = [suitDictionary objectForKey:@"cards"];
    
    // Get card for this row
    NSDictionary *cardDictionary = [cardsArray objectAtIndex:indexPath.row];
    
    // Get card's imageName
    NSString *cardImageName = [cardDictionary objectForKey:@"cardImage"];
    
    // Load the image and add to the cell
    UIImage *cardImage = [UIImage imageNamed:cardImageName];
    UIImageView *cardImageView =[[UIImageView alloc] initWithImage:cardImage];
    [cell.contentView addSubview:cardImageView];
    
    return cell;
}

//-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//    
//    UICollectionReusableView *reusableView = nil;
//    NSString *suitName = [self.suitsArray objectAtIndex:indexPath.section];
//    
//    if (kind == UICollectionElementKindSectionHeader) {
//        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SectionHeader" forIndexPath:indexPath];
//
//        UIImage *suitImage = [UIImage imageNamed:suitName];
//
//        UIImageView *suitImageView = (UIImageView *)[reusableView viewWithTag:1000];
//        [suitImageView setImage:suitImage];
//        
//        UILabel *suitLabel = (UILabel *)[reusableView viewWithTag:2000];
//        [suitLabel setText:suitName];
//        
//    }
//    
//    if (kind == UICollectionElementKindSectionFooter) {
//        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"SectionFooter" forIndexPath:indexPath];
//
////        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
////        [label setText:[NSString stringWithFormat:@"%@ Footer", suitName]];
////        [label setFont:[UIFont fontWithName:@"HelveticaNeue" size:22.0f]];
////        [label setTextColor:[UIColor redColor]];
////        [label sizeToFit];
////        [label setFrame:CGRectMake(10, 10, label.frame.size.width, label.frame.size.height)];
////        [reusableView addSubview:label];
////        
////        [reusableView setBackgroundColor:[UIColor greenColor]];
//    }
//    
//    return reusableView;
//    
//}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    // Get suit
    NSDictionary *suitDictionary = [self.suitsArray objectAtIndex:indexPath.section];
    
    // Get cards
    NSArray *cardsArray = [suitDictionary objectForKey:@"cards"];
    
    // Get card for this row
    NSDictionary *cardDictionary = [cardsArray objectAtIndex:indexPath.row];
    
    // Get data for card
    NSString *cardImageName = [cardDictionary objectForKey:@"cardImage"];
    UIImage *cardImage = [UIImage imageNamed:cardImageName];

    NSLog(@"cardimahge = %f,%f", cardImage.size.width, cardImage.size.height);
    
    return cardImage.size;
}

@end
