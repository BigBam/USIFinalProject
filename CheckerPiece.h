//
//  CheckerPiece.h
//  USIFinalProject
//
//  Created by USI on 1/9/14.
//  Copyright (c) 2014 Bam F. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckerPiece : NSObject

@property (strong, nonatomic) UIImage *image;

@property BOOL isActive;

@property int position;

@end
