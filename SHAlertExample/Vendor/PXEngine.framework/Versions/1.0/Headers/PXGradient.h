//
//  PXGradient.h
//  PXEngine
//
//  Created by Kevin Lindsey on 6/8/12.
//  Copyright (c) 2012 Pixate, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <PXEngine/PXPaint.h>

/**
 *  A common base class for linear- and radial-gradients.
 */
@interface PXGradient : NSObject <PXPaint>

/**
 *  An array of offsets, from zero to one inclusive, one for each color
 */
@property (nonatomic) NSMutableArray *offsets;

/**
 *  An array of colors, one for each color in the gradient. It is expected that each color will have a corresponding
 *  offset; however, if the two arrays differ in size, then the colors will be evenly distributed between zero and one,
 *  inclusive.
 */
@property (nonatomic) NSMutableArray *colors;

/**
 *  The transform to apply before rendering this gradient
 */
@property (nonatomic) CGAffineTransform transform;

/**
 *  The CGGRadient representing this gradient.
 */
@property (readonly) CGGradientRef gradient;

/**
 *  Add a color to this gradients list of colors
 *
 *  @param color The color to add
 */
- (void)addColor:(UIColor *)color;

/**
 *  Add a color at the given offset
 *
 *  @param color The color to add
 *  @param offset The offset to add
 */
- (void)addColor:(UIColor *)color withOffset:(CGFloat)offset;

@end
