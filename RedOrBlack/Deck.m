//
//  Deck.m
//  RedOrBlack
//
//  Created by Johann Kerr on 1/7/15.
//  Copyright (c) 2015 Johann Kerr. All rights reserved.
//

#import "Deck.h"
#import "Card.h"

@implementation Deck
{
    NSMutableArray *_cards;
}

- (void)setUpCards
{
    for (Suit suit = SuitClubs; suit <= SuitSpades; ++suit)
    {
        for (int value = CardAce; value <= CardKing; ++value)
        {
            Card *card = [[Card alloc] initWithSuit:suit value:value];
            [_cards addObject:card];
        }
    }
}

- (id)init
{
    if ((self = [super init]))
    {
        _cards = [NSMutableArray arrayWithCapacity:51];
        [self setUpCards];
    }
    return self;
}

- (void)shuffle
{
    NSUInteger count = [_cards count];
    NSMutableArray *shuffled = [NSMutableArray arrayWithCapacity:count];
    
    for (int t = 0; t < count; ++t)
    {
        int i = arc4random() % [self cardsRemaining];
        Card *card = [_cards objectAtIndex:i];
        [shuffled addObject:card];
        [_cards removeObjectAtIndex:i];
    }
    
    NSAssert([self cardsRemaining] == 0, @"Original deck should now be empty");
    
    _cards = shuffled;
}

- (Card *)draw
{
    // NSAssert([self cardsRemaining] > 0, @"No more cards in the deck");
    Card *card = [_cards lastObject];
    [_cards removeLastObject];
    return card;
}

- (int)cardsRemaining
{
    return [_cards count];
}

- (void)addCardToTop:(Card *)card
{
    NSAssert(card != nil, @"Card cannot be nil");
    NSAssert([_cards indexOfObject:card] == NSNotFound, @"Already have this Card");
    [_cards addObject:card];
}

- (void)addCardToBottom:(Card *)card
{
    NSAssert(card != nil, @"Card cannot be nil");
    NSAssert([_cards indexOfObject:card] == NSNotFound, @"Already have this Card");
    [_cards insertObject:card atIndex:0];
}
- (NSUInteger)cardCount
{
    return [_cards count];
}
- (Card *)cardAtIndex:(NSUInteger)index
{
    return [_cards objectAtIndex:index];
}
- (Card *)topmostCard
{
    return [_cards lastObject];
}
- (void)removeTopmostCard
{
    [_cards removeLastObject];
}
- (void)removeAllCards
{
    [_cards removeAllObjects];
}
- (NSArray *)array
{
    return [_cards copy];
}

- (void)addCardsFromArray:(NSArray *)array
{
    _cards = [array mutableCopy];
}


@end