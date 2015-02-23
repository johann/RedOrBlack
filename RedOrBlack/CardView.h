//
//  CardView.h
//  RedOrBlack
//
//  Created by Johann Kerr on 1/7/15.
//  Copyright (c) 2015 Johann Kerr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MDCSwipeToChoose/MDCSwipeToChoose.h>

@class Card;
@class Deck;
@class Stack;


@interface CardView : MDCSwipeToChooseView
@property (nonatomic, strong) Card *card;
@property (nonatomic, weak) NSString *descrip;

- (instancetype)initWithFrame:(CGRect)frame
                       card:(Card *)card
                      options:(MDCSwipeToChooseViewOptions *)options;


//-(void)animateDealingWithDelay:(NSTimeInterval)delay;
//-(void)animateTurningOver;
//-(void)animateSingleCard:(NSTimeInterval)delay;
-(NSString*)loadFront;
-(void)loadBack;
-(NSString*)loadDescription;

@end
