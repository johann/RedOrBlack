//
//  Stack.h
//  RedOrBlack
//
//  Created by Johann Kerr on 1/7/15.
//  Copyright (c) 2015 Johann Kerr. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Card;

@interface Stack : NSObject

- (void)addCardToTop:(Card *)card;
- (void)addCardToBottom:(Card *)card;
- (NSUInteger)cardCount;
- (Card *)cardAtIndex:(NSUInteger)index;
- (Card *)topmostCard;
- (Card *)secondCard;
- (void)removeTopmostCard;
- (void)removeAllCards;
- (NSArray *)array;
- (void)addCardsFromArray:(NSArray *)array;

@end
