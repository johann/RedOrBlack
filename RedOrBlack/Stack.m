//
//  Stack.m
//  RedOrBlack
//
//  Created by Johann Kerr on 1/7/15.
//  Copyright (c) 2015 Johann Kerr. All rights reserved.
//

#import "Stack.h"
#import "Card.h"

@implementation Stack
{
    NSMutableArray *_cards;
}

- (id)init
{
    if ((self = [super init]))
    {
        _cards = [NSMutableArray arrayWithCapacity:52];
    }
    return self;
}

- (void)dealloc
{
#ifdef DEBUG
    NSLog(@"dealloc %@", self);
#endif
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
