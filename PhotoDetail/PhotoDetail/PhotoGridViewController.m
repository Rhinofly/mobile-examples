//
//  PhotoGridViewController.m
//  PhotoGrid
//
//  Created by Johan Haneveld on 1/29/13.
//  Copyright (c) 2013 Rhinofly. All rights reserved.
//

#import "PhotoGridViewController.h"
#import "PhotoGridCell.h"
#import "PhotoDetailViewController.h"
#import "ImageModel.h"

@interface PhotoGridViewController ()

@end

@implementation PhotoGridViewController

@synthesize data = _data;
@synthesize showNavigationBarWithAnimation = _showNavigationBarWithAnimation;
@synthesize thumbLoaders = _thumbLoaders;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self)
    {
        // first time the view loads , dont show the navigationbar.
        _showNavigationBarWithAnimation = NO;
        
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

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
    
	[self.navigationController setNavigationBarHidden:YES animated:_showNavigationBarWithAnimation];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
    
	[self.navigationController setNavigationBarHidden:NO animated:YES];
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
    
	PhotoGridCell *cell;
    
	if ([_data count] == 0 && indexPath.row == 0)
	{
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:0];
		cell.textLabel.text = @"Loading…";
		
		return cell;
    }
    
    ImageModel *model = [_data objectAtIndex:[indexPath row]];
    
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.textLabel.hidden = !model.caption.length;
    
    if (!cell.textLabel.hidden)
    {
        cell.textLabel.text = model.caption;
    }
    
    // Only load cached images; defer new downloads until scrolling ends
    if (!model.thumb)
    {
        if (self.collectionView.dragging == NO && self.collectionView.decelerating == NO)
        {
            [self loadThumb:model forIndexPath:indexPath];
        }
        
        // if a download is deferred or in progress, use a placeholder image
        UIImage *image = [UIImage imageNamed:@"ThumbPlaceholder.png"];
        
        cell.imageView.image = image;
    }
    else
    {
        cell.imageView.image = model.thumb;
    }
    
    return cell;
}

- (void)loadThumb:(ImageModel *)model forIndexPath:(NSIndexPath *)indexPath
{
    ImageLoader *thumbLoader = [_thumbLoaders objectForKey:indexPath];
    
    if (thumbLoader == nil)
    {
        thumbLoader = [[ImageLoader alloc] init];
        thumbLoader.indexPath = indexPath;
        thumbLoader.delegate = self;
        [_thumbLoaders setObject:thumbLoader forKey:indexPath];
        [thumbLoader start:[NSString stringWithFormat:@"%@%@%@", @"http://", model.url, @"_thumb_160"]];
    }
}

- (void)imageDidLoad:(UIImage *)image forIndexPath:(NSIndexPath *)indexPath
{
    if (image)
    {
        ImageModel *model = [_data objectAtIndex:[indexPath row]];
        model.thumb = image;
        PhotoGridCell *cell = [self.collectionView cellForItemAtIndexPath:indexPath];
        
        cell.imageView.image = model.thumb;
    }
    
    // Remove the thumbLoader from the in thumbloaders collection.
    // This will result in it being deallocated.
    [_thumbLoaders removeObjectForKey:indexPath];
}

- (void)loadThumbsForOnscreenRows
{
    if ([_data count] > 0)
    {
        NSArray *visiblePaths = [self.collectionView indexPathsForVisibleItems];
        
        for (NSIndexPath *indexPath in visiblePaths)
        {
            ImageModel *model = [_data objectAtIndex:indexPath.row];
            
            if (!model.thumb) // avoid the app icon download if the app already has an icon
            {
                [self loadThumb:model forIndexPath:indexPath];
            }
        }
    }
}

// Load images for all onscreen rows when scrolling is finished
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
	{
        [self loadThumbsForOnscreenRows];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self loadThumbsForOnscreenRows];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // navigationbar can be shown with animation.
    _showNavigationBarWithAnimation = YES;
    
    PhotoDetailViewController *detailView = [[PhotoDetailViewController alloc] initWithNibName:@"PhotoDetailViewController" bundle:nil];
    [detailView setModel: [_data objectAtIndex:[indexPath row]]];
    [[self navigationController] pushViewController:detailView animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    self.collectionView = nil;
    self.data = nil;
}

@end
