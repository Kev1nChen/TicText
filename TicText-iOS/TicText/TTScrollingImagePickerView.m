//
//  TTScrollingImagePickerView
//  TicText
//
//  Created by Chengkan Huang on 4/17/15.
//  Copyright (c) 2015 Kevin Yufei Chen. All rights reserved.
//

#import "TTScrollingImagePickerView.h"

#import <PureLayout/PureLayout.h>
#import "TTScrollingLayout.h"
#import "TTScrollingImagePickerCell.h"

#define kImageSpacing 2.0

@interface TTScrollingImagePickerView () <UICollectionViewDataSource, UICollectionViewDelegate, TTScrollingImagePickerCellDelegate>

@property (nonatomic) BOOL addConstraints;
@property (nonatomic, strong) UIButton *imagePickerButton;
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *imagesArray;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, strong) TTScrollingLayout *flowLayout;

@property (nonatomic, strong) UIView *optionButtonsView;
@property (nonatomic, strong) UIButton *sendButton;
@property (nonatomic) BOOL optionViewIsShown;

@end

@implementation TTScrollingImagePickerView

- (id)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    [self setClipsToBounds:YES];
    
    TTScrollingLayout *flow = [[TTScrollingLayout alloc] init];
    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flow.minimumInteritemSpacing = kImageSpacing;
    self.flowLayout = flow;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flow];
    collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.allowsMultipleSelection = NO;
    collectionView.allowsSelection = YES;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.collectionViewLayout = flow;
    [collectionView registerClass:[TTScrollingImagePickerCell class] forCellWithReuseIdentifier:@"Cell"];

    [self addSubview:collectionView];
    self.collectionView = collectionView;
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor clearColor];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(collectionView);
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[collectionView]|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[collectionView]|" options:0 metrics:nil views:views]];
    
    self.imagePickerButton = [[UIButton alloc] init];
    self.imagePickerButton.backgroundColor = [UIColor colorWithRed:130.0/255.0 green:100.0/255.0 blue:200.0/255.0 alpha:0.8];
    [self.imagePickerButton setImage:[UIImage imageNamed:@"ImagePickerIcon"] forState:UIControlStateNormal];
    [self.imagePickerButton.layer setMasksToBounds:YES];
    [self.imagePickerButton.layer setCornerRadius:25];
    [self.imagePickerButton addTarget:self
                               action:@selector(didTapImagePickerButton)
                     forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.imagePickerButton];
    
    self.addConstraints = NO;

    [self setNeedsUpdateConstraints];
}

- (void)layoutSubviews {
    [super layoutSubviews];
//    self.flowLayout.estimatedItemSize = CGSizeMake(1, self.collectionView.frame.size.height);
}

- (void)updateConstraints {
    if (!self.addConstraints) {
        self.addConstraints = YES;
        [self.imagePickerButton autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self withOffset:-5 relation:NSLayoutRelationEqual];
        [self.imagePickerButton autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self withOffset:5 relation:NSLayoutRelationEqual];
        [self.imagePickerButton autoSetDimension:ALDimensionHeight toSize:50];
        [self.imagePickerButton autoSetDimension:ALDimensionWidth toSize:50];
    }
    
    [super updateConstraints];
}

- (void)didTapImagePickerButton {
    [[NSNotificationCenter defaultCenter] postNotificationName:kTTScrollingImagePickerDidTapImagePickerButton object:nil];
}

- (void)setImages:(NSMutableArray *)images {
    self.imagesArray = [images copy];
    
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imagesArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TTScrollingImagePickerCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"Cell"
                                                                                      forIndexPath:indexPath];
    [cell setImage:[self.imagesArray objectAtIndex:indexPath.row]];
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"deselect at %ld", indexPath.row);
    TTScrollingImagePickerCell *cell = (TTScrollingImagePickerCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    self.optionViewIsShown = NO;
    cell.delegate = nil;
    [cell hideOptionButtons];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"select at %ld", indexPath.row);
    self.selectedIndex = indexPath.row;
    TTScrollingImagePickerCell *cell = (TTScrollingImagePickerCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    
    if (self.optionViewIsShown) {
        self.optionViewIsShown = NO;
        cell.delegate = nil;
        [cell hideOptionButtons];
    } else {
        self.optionViewIsShown = YES;
        cell.delegate = self;
        [cell showOptionButtons];
    }
}

# pragma mark - TTScrollingImagePickerCellDelegate
- (void) didTapSendButtonInScrollingImagePickerCell {
    NSLog(@"Send image at index %ld", self.selectedIndex);
    [[NSNotificationCenter defaultCenter] postNotificationName:kTTScrollingUIImagePickerDidChooseImage
                                                        object:nil
                                                      userInfo:@{kTTScrollingUIImagePickerChosenImageKey : [self.imagesArray objectAtIndex:self.selectedIndex]}];
}


- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    UIImage *imageAtPath = [self.imagesArray objectAtIndex:indexPath.row];
    
    CGFloat imageHeight = imageAtPath.size.height;
    CGFloat viewHeight = collectionView.frame.size.height;
    CGFloat scaleFactor = viewHeight/imageHeight;
    
    CGSize scaledSize = CGSizeApplyAffineTransform(imageAtPath.size, CGAffineTransformMakeScale(scaleFactor, scaleFactor));
    scaledSize.height = MIN(viewHeight, scaledSize.height);
    return scaledSize;
}

@end
