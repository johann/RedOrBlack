//
//  ViewController.h
//  RedOrBlack
//
//  Created by Johann Kerr on 1/7/15.
//  Copyright (c) 2015 Johann Kerr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardView.h"
#import "CNPPopupController.h"

@class ViewController;
@class Card;
@class Stack;
@class Deck;


@interface ViewController : UIViewController <MDCSwipeToChooseDelegate>



@property (nonatomic, strong) Deck *deckCards;
@property (nonatomic, strong) Card *currentCard;
@property (nonatomic, strong) CardView *frontCardView;
@property (nonatomic, strong) CardView *backCardView;


- (IBAction)higherAction:(id)sender;
- (IBAction)reloadDeck:(id)sender;
- (IBAction)lowerAction:(id)sender;

@end

