//
//  SpringyFlowLayout.m
//  SampleSpringyCollectionView
//
//  Created by Peter Chen on 1/9/14.
//  Copyright (c) 2014 Peter Chen. All rights reserved.
//

#import "SpringyFlowLayout.h"

@interface SpringyFlowLayout()

@property (nonatomic, strong) UIDynamicAnimator *dynamicAnimator;

@end

@implementation SpringyFlowLayout

- (id)init
{
    self = [super init];
    if (self) {
        //
        // I used http://www.objc.io/issue-5/collection-views-and-uidynamics.html as a starting point for this sample project.
        //
        
        self.dynamicAnimator = [[UIDynamicAnimator alloc] initWithCollectionViewLayout:self];
    }
    return self;
}

- (void)prepareLayout {
    [super prepareLayout];
    
    CGSize contentSize = self.collectionView.contentSize;
    NSArray *items = [super layoutAttributesForElementsInRect:CGRectMake(0, 0, contentSize.width, contentSize.height)];
    
    if ([self.dynamicAnimator.behaviors count] == 0) {
        for (id<UIDynamicItem> item in items) {
            UIAttachmentBehavior *behaviour = [[UIAttachmentBehavior alloc] initWithItem:item attachedToAnchor:item.center];
            behaviour.length = 0;
            behaviour.damping = 0.9;
            behaviour.frequency = 2;
            [self.dynamicAnimator addBehavior:behaviour];
        }
    }
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    return [self.dynamicAnimator itemsInRect:rect];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [self.dynamicAnimator layoutAttributesForCellAtIndexPath:indexPath];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    CGFloat newBoundsDelta = newBounds.origin.y - self.collectionView.bounds.origin.y;
    CGPoint touchLocation = [self.collectionView.panGestureRecognizer locationInView:self.collectionView];
    
    for (UIAttachmentBehavior *springBehavior in self.dynamicAnimator.behaviors) {
        CGFloat distanceFromTouch = fabsf(touchLocation.y - springBehavior.anchorPoint.y);
        CGFloat scrollResistance = distanceFromTouch / 2000;
        
        UICollectionViewLayoutAttributes *item = springBehavior.items.firstObject;
        CGPoint center = item.center;
        center.y += newBoundsDelta < 0 ? MAX(newBoundsDelta, newBoundsDelta*scrollResistance) : MIN(newBoundsDelta, newBoundsDelta*scrollResistance);
        item.center = center;
        
        [self.dynamicAnimator updateItemUsingCurrentState:item];
    };
    
    return NO;
}

@end
