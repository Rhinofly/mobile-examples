//
//  PhotoGridViewController.m
//  PhotoGrid
//
//  Created by Johan Haneveld on 1/29/13.
//  Copyright (c) 2013 Rhinofly. All rights reserved.
//

#import "PhotoGridViewController.h"
#import "PhotoGridCell.h"

@interface PhotoGridViewController ()

@end

@implementation PhotoGridViewController

@synthesize data = _data;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self)
    {
        // Two ways to register a cell for the collection. First is by class, the other by nib
        //[self.collectionView registerClass:[PhotoGridCell class] forCellWithReuseIdentifier:@"Cell"];
        [self.collectionView registerNib:[UINib nibWithNibName:@"PhotoGridCell" bundle:nil] forCellWithReuseIdentifier:@"Cell"];
        
        // Collection flow layout settings. These settings can you either do with the UICollectionViewFlowLayout class or change it in the nib file
        //UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        // Set cell size
        //[flowLayout setItemSize:CGSizeMake(145, 110)];
        // Set direction to the layout. Default is vertical
        //[flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        //[self.collectionView setCollectionViewLayout:flowLayout];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    // Return the number of sections.
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    // Return the number of items in the section.
    return [_data count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    NSDictionary *image = (NSDictionary *)[_data objectAtIndex:[indexPath row]];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@", @"http://", [image objectForKey:@"url"], @"_thumb_160"]];
	NSData *data = [NSData dataWithContentsOfURL:url];
    
    PhotoGridCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
	cell.imageView.image = [UIImage imageWithData:data];
    cell.textLabel.text = [image objectForKey:@"caption"];
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
