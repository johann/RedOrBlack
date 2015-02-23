//
//  CardView.m
//  RedOrBlack
//
//  Created by Johann Kerr on 1/7/15.
//  Copyright (c) 2015 Johann Kerr. All rights reserved.
//

#import "CardView.h"
#import "Card.h"

//const CGFloat CardWidth = 67.0f;   // this includes the drop shadows
//const CGFloat CardHeight = 99.0f;


@implementation CardView
{
    UIImageView *_frontImageView;
    UIImageView *_backImageView;
    CGFloat _angle;
}

@synthesize card = _card;
@synthesize descrip = _descrip;

//- (instancetype)init {
//    self = [super init];
//    if (self) {
//        
//        [self setup];
//        //[self loadBack];
//    }
//    return self;
//}

- (instancetype)initWithFrame:(CGRect)frame
                       card:(Card *)card
                      options:(MDCSwipeToChooseViewOptions *)options {
    self = [super initWithFrame:frame options:options];
    if (self) {
        _card = card;
        self.imageView.image = [UIImage imageNamed:@"BofC"];
       
        
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight |
        UIViewAutoresizingFlexibleWidth |
        UIViewAutoresizingFlexibleBottomMargin;
        self.imageView.autoresizingMask = self.autoresizingMask;
    }
    return self;
}

//- (instancetype)initWithCoder:(NSCoder *)aDecoder {
//    self = [super initWithCoder:aDecoder];
//    if (self) {
//        [self setup];
//        //[self loadFront];
//    }
//    return self;
//}

- (void)dealloc
{
#ifdef DEBUG
    NSLog(@"dealloc %@", self);
#endif
}

- (void)loadBack
{
    if(_backImageView == nil)
    {
        _backImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _backImageView.image = [UIImage imageNamed:@"Back of Card"];
        _backImageView.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:_backImageView];
    }
}
- (void)unloadBack
{
    [_backImageView removeFromSuperview];
    _backImageView = nil;
}

- (NSString*)loadFront
{
    if (_frontImageView == nil)
    {
        _frontImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _frontImageView.contentMode = UIViewContentModeScaleToFill;
        _frontImageView.hidden = YES;
        [self addSubview:_frontImageView];
        
        NSString *suitString;
        switch (self.card.suit)
        {
            case SuitClubs:    suitString = @"Clubs"; break;
            case SuitDiamonds: suitString = @"Diamonds"; break;
            case SuitHearts:   suitString = @"Hearts"; break;
            case SuitSpades:   suitString = @"Spades"; break;
        }
        
        NSString *valueString;
        switch (self.card.value)
        {
            case CardAce:   valueString = @"Ace"; break;
            case CardJack:  valueString = @"Jack"; break;
            case CardQueen: valueString = @"Queen"; break;
            case CardKing:  valueString = @"King"; break;
            default:        valueString = [NSString stringWithFormat:@"%d", self.card.value];
        }
        
        NSString *filename = [NSString stringWithFormat:@"%@ %@", suitString, valueString];
        //self.descrip = [NSString stringWithFormat:@"%@ of %@", valueString, suitString];
        
        _frontImageView.image = [UIImage imageNamed:filename];
        NSLog(@"%@", filename);
        
        return filename;
    }
    return nil;
}

-(NSString*)loadDescription
{
    NSString *suitString;
    switch (self.card.suit)
    {
        case SuitClubs:    suitString = @"Clubs"; break;
        case SuitDiamonds: suitString = @"Diamonds"; break;
        case SuitHearts:   suitString = @"Hearts"; break;
        case SuitSpades:   suitString = @"Spades"; break;
    }
    
    NSString *valueString;
    switch (self.card.value)
    {
        case CardAce:   valueString = @"Ace"; break;
        case CardJack:  valueString = @"Jack"; break;
        case CardQueen: valueString = @"Queen"; break;
        case CardKing:  valueString = @"King"; break;
        default:        valueString = [NSString stringWithFormat:@"%d", self.card.value];
    }
    
    
    self.descrip = [NSString stringWithFormat:@"%@ of %@", valueString, suitString];
    
    return self.descrip;
    
}
- (void)unloadFront
{
    [_frontImageView removeFromSuperview];
    _frontImageView = nil;
}


- (void)setup {
    //Shadow
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity = 0.33;
    self.layer.shadowOffset = CGSizeMake(0, 1.5);
    self.layer.shadowRadius = 4.0;
    self.layer.shouldRasterize = YES;
    
    //Corner Radius
    self.layer.cornerRadius = 10.0;
}

-(CGPoint)centerOfView
{
    CGRect rect = self.superview.bounds;
    CGFloat midX = CGRectGetMinX(rect);
    CGFloat midY = CGRectGetMinY(rect);
    
    return CGPointMake(midX, midY);
    
}

//- (void) animateDealingWithDelay:(NSTimeInterval)delay
//{
//    self.frame = CGRectMake(1.0f, 1.0f, CardWidth, CardHeight);
//    //self.transform = CGAffineTransformMakeRotation(M_PI);
//    
//    
//    [UIView animateWithDuration:0.2f
//                          delay:delay
//                        options:UIViewAnimationOptionCurveEaseOut
//                     animations:^
//     {
//         self.center = [self centerOfView];
//         //self.transform = CGAffineTransformMakeRotation(_angle);
//         NSLog(@"ANIMATE_DEALING_WITH DELAY - CARDVIEW.M");
//         
//     }
//                     completion:nil];
//}
//
//-(void)animateSingleCard:(NSTimeInterval)delay
//{
//    self.frame = CGRectMake(10.f, 10.f, CardWidth, CardHeight);
//    [UIView animateWithDuration:0.2f
//                          delay:delay
//                        options:UIViewAnimationOptionCurveEaseOut
//                     animations:^
//     {
//         self.center = [self centerOfView];
//         //self.transform = CGAffineTransformMakeRotation(_angle);
//         NSLog(@"ANIMATE_SINGLE_CARD DELAY - CARDVIEW.M");
//         
//     }
//                     completion:nil];
//    
//}
//
//- (void)animateTurningOver
//{
//    [self loadFront];
//    [self.superview bringSubviewToFront:self];
//    UIImageView *darkenView = [[UIImageView alloc] initWithFrame:self.bounds];
//    darkenView.backgroundColor = [UIColor clearColor];
//    darkenView.image = [UIImage imageNamed:@"Darken"];
//    darkenView.alpha = 0.0f;
//    [self addSubview:darkenView];
//    
//    
//    
//    
//    CGPoint startPoint = self.center;
//    CGPoint endPoint = [self centerOfView];
//    CGFloat afterAngle = 1.0f;
//    CGPoint halfwayPoint = CGPointMake((startPoint.x + endPoint.x)/2.0f, (startPoint.y + endPoint.y)/2.0f);
//    CGFloat halfwayAngle = (_angle + afterAngle)/2.0f;
//    
//    [UIView animateWithDuration:0.15f
//                          delay:0.0f
//                        options:UIViewAnimationOptionCurveEaseIn
//                     animations:^
//     {
//         CGRect rect = _backImageView.bounds;
//         rect.size.width = 1.0f;
//         _backImageView.bounds = rect;
//         
//         darkenView.bounds = rect;
//         darkenView.alpha = 0.5f;
//         
//         self.center = halfwayPoint;
//         //self.transform = CGAffineTransformScale(CGAffineTransformMakeRotation(halfwayAngle), 1.2f, 1.2f);
//     }
//                     completion:^(BOOL finished)
//     {
//         _frontImageView.bounds = _backImageView.bounds;
//         _frontImageView.hidden = NO;
//         
//         [UIView animateWithDuration:0.15f
//                               delay:0
//                             options:UIViewAnimationOptionCurveEaseOut
//                          animations:^
//          {
//              CGRect rect = _frontImageView.bounds;
//              rect.size.width = CardWidth;
//              _frontImageView.bounds = rect;
//              
//              darkenView.bounds = rect;
//              darkenView.alpha = 0.0f;
//              
//              self.center = endPoint;
//              //self.transform = CGAffineTransformMakeRotation(afterAngle);
//          }
//                          completion:^(BOOL finished)
//          {
//              [darkenView removeFromSuperview];
//              [self unloadBack];
//          }];
//     }];
//    
//    
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
