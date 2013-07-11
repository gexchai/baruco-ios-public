//
//  BServiceDelegate.h
//  baruco-ios
//
//  Created by Piotr Paweł Dębosz on 12.08.2012.
//  Copyright (c) 2012 EL Passion. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BServiceDelegate <NSObject>

-(void)BServiceDidUpdateObjects;
-(void)BServiceDidntUpdateObjects;

-(void)BServiceDidLoadImage:(UIImage *)image;
-(void)BServiceDidntLoadImage:(NSError *)error;

-(void)BServiceDidLoadObject:(id)JSON;
-(void)BServiceDidFailLoadingObject:(NSError *)error;

-(void)BServiceDidLoadObjects:(NSArray *)objects;
-(void)BServiceDidFailLoadingObjects:(NSError *)error;
-(void)BServiceDidLoadObject:(id)JSON;
-(void)BServiceDidFailLoadingObject:(NSError *)error;

@end
