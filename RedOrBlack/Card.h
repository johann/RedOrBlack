//
//  Card.h
//  RedOrBlack
//
//  Created by Johann Kerr on 1/7/15.
//  Copyright (c) 2015 Johann Kerr. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum
{
    SuitClubs,
    SuitDiamonds,
    SuitHearts,
    SuitSpades
}
Suit;

#define CardAce   1
#define CardJack  11
#define CardQueen 12
#define CardKing  13

@interface Card : NSObject

@property (nonatomic, assign, readonly) Suit suit;
@property (nonatomic, assign, readonly) int value;

@property (nonatomic, assign) BOOL isTurnedOver;

- (id)initWithSuit:(Suit)suit value:(int)value;
- (BOOL)isEqualToCard:(Card *)otherCard;
- (BOOL)matchesCard:(Card *)otherCard;

- (BOOL)isLessThan:(Card*)otherCard;
- (BOOL)isMoreThan:(Card*)otherCard;
- (BOOL)isPurple;


@end
