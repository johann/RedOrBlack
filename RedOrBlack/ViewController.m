//
//  ViewController.m
//  RedOrBlack
//
//  Created by Johann Kerr on 1/7/15.
//  Copyright (c) 2015 Johann Kerr. All rights reserved.
//

#import "ViewController.h"
#import "MDCSwipeToChoose/MDCSwipeToChoose.h"
#import "Card.h"
#import "Deck.h"
#import "Stack.h"
#import "CardView.h"
//#import "Game.h"
#import "JFMinimalNotification.h"
#import "UIBarButtonItem+Badge.h"
#import "CNPPopupController.h"


static const CGFloat ChooseCardButtonHorizontalPadding = 80.f;
static const CGFloat ChooseCardButtonVerticalPadding = 20.f;


@interface ViewController () <JFMinimalNotificationDelegate,CNPPopupControllerDelegate>

@property (nonatomic, strong) CNPPopupController *popupController;

@property (nonatomic, strong) NSMutableArray *mutableCards;
@property (nonatomic, strong) JFMinimalNotification* minimalNotification;
@property (nonatomic, strong) NSArray *cards;
@property (nonatomic) NSUInteger cardIndex;

@property (nonatomic, weak) NSString *title;
@property (nonatomic, weak) NSString *subtitle;
@property (nonatomic, weak) NSString *image;
@property (nonatomic) int score;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"phbg2.png"]];
    Deck *deck = [[Deck alloc] init];
    [deck shuffle];
    self.deckCards = deck;
    //NSLog(@"%u", self.deckCards.draw.suit);
    //NSLog(@"%u", self.deckCards.draw.value);
    self.cardIndex = 0;
    
    UIImageView *bn = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Logo2.png"]];
    //    //[bn addSubview:_badgeView];
    self.navigationItem.titleView = bn;
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *beer = [UIImage imageNamed:@"beer"];
    button.frame = CGRectMake(0,0,beer.size.width, beer.size.height);
    [button addTarget:self action:nil forControlEvents:UIControlEventTouchDown];
    [button setBackgroundImage:beer forState:UIControlStateNormal];
    
    // Make BarButton Item
    UIBarButtonItem *navLeftButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = navLeftButton;
    self.navigationItem.rightBarButtonItem.badgeValue = @"";
    self.navigationItem.rightBarButtonItem.badgeBGColor = self.navigationController.navigationBar.tintColor;
    
    
//    UIBarButtonItem *beerButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"beer.png"] style:UIBarButtonItemStylePlain target:self action:nil];
//    self.navigationItem.rightBarButtonItem = beerButton;
    
    self.frontCardView = [self popCardViewWithFrame:[self frontCardViewFrame]];
    [self.view addSubview:self.frontCardView];
    self.backCardView = [self popCardViewWithFrame:[self backCardViewFrame]];
    [self.view insertSubview:self.backCardView belowSubview:self.frontCardView];
    
}
- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}


#pragma mark - MDCSwipeToChooseDelegate Protocol Methods

// This is called when a user didn't fully swipe left or right.
- (void)viewDidCancelSwipe:(UIView *)view {
    NSLog(@"You couldn't decide on %@.", self.currentCard);
}

// This is called then a user swipes the view fully left or right.
- (void)view:(UIView *)view wasChosenWithDirection:(MDCSwipeDirection)direction {
    // MDCSwipeToChooseView shows "NOPE" on swipes to the left,
    // and "LIKED" on swipes to the right.
    NSTimeInterval timeP = self.score + .5;
    NSString *timeSubtitle = @"";
    if(self.score == 1 || self.score == 0){
       timeSubtitle = @"DRINK FOR 1 SECOND";
        
    }else if (self.score > 1)
    {
        timeSubtitle = [NSString stringWithFormat:@"DRINK FOR %d SECONDS", self.score];
                                      
    }
    
    if (direction == MDCSwipeDirectionLeft) {
        
       
        if (self.currentCard.suit == SuitDiamonds || self.currentCard.suit == SuitHearts )
        {
            self.minimalNotification = [JFMinimalNotification notificationWithStyle:JFMinimalNotificationStyleError title:timeSubtitle subTitle:self.title dismissalDelay:timeP
                                                                       touchHandler:^{
                [self.minimalNotification dismiss];
            }];
            
            
           
            self.minimalNotification.delegate = self;
            [self.minimalNotification setRightAccessoryView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:self.image]] animated:YES];
            [self.view addSubview:self.minimalNotification];
            [self.minimalNotification show];
            [self eraseBadge];
            NSLog(@"%d", self.score);
            
        }
        else if (self.currentCard.suit == SuitClubs || self.currentCard.suit == SuitSpades)
        {
            self.minimalNotification = [JFMinimalNotification notificationWithStyle:JFMinimalNotificationStyleSuccess title:@"Safe!" subTitle:self.title dismissalDelay:0.6 touchHandler:^{
                [self.minimalNotification dismiss];
            }];
            
            self.minimalNotification.delegate = self;
            [self.minimalNotification setRightAccessoryView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:self.image]] animated:YES];
            [self.view addSubview:self.minimalNotification];
            [self.minimalNotification show];
            self.score++;
            [self updateBadge];
            NSLog(@"%d", self.score);
            
            
        }
        else
        {
            
        }
        [self checkDeck];
        NSLog(@"Number of cards left %d", self.deckCards.cardsRemaining);
        //NSLog(@"You noped %@.", self.currentCard);
    } else {
        
        if (self.currentCard.suit == SuitDiamonds || self.currentCard.suit == SuitHearts )
        {
            self.minimalNotification = [JFMinimalNotification notificationWithStyle:JFMinimalNotificationStyleSuccess title:@"Safe!" subTitle:self.title dismissalDelay:0.6 touchHandler:^{
                [self.minimalNotification dismiss];
            }];
            
            self.minimalNotification.delegate = self;
            [self.minimalNotification setRightAccessoryView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:self.image]] animated:YES];
            [self.view addSubview:self.minimalNotification];
            [self.minimalNotification show];
            self.score++;
            [self updateBadge];
            NSLog(@"%d", self.score);
        }
        else if (self.currentCard.suit == SuitClubs || self.currentCard.suit == SuitSpades)
        {
            
            self.minimalNotification = [JFMinimalNotification notificationWithStyle:JFMinimalNotificationStyleError title:timeSubtitle subTitle:self.title dismissalDelay:timeP touchHandler:^{
                [self.minimalNotification dismiss];
            }];
            
            self.minimalNotification.delegate = self;
            [self.minimalNotification setRightAccessoryView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:self.image]] animated:YES];
            [self.view addSubview:self.minimalNotification];
            [self.minimalNotification show];
            [self eraseBadge];
            NSLog(@"%d", self.score);
           
            
           
            
        }
        else
        {
            
        }
        [self checkDeck];

        //NSLog(@"%@.", self.frontCardView.loadFront);
        
    }
    
    // MDCSwipeToChooseView removes the view from the view hierarchy
    // after it is swiped (this behavior can be customized via the
    // MDCSwipeOptions class). Since the front card view is gone, we
    // move the back card to the front, and create a new back card.
    self.frontCardView = self.backCardView;
    if ((self.backCardView = [self popCardViewWithFrame:[self backCardViewFrame]])) {
        // Fade the back card into view.
        self.backCardView.alpha = 0.f;
        [self.view insertSubview:self.backCardView belowSubview:self.frontCardView];
        [UIView animateWithDuration:0.5
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             self.backCardView.alpha = 1.f;
                         } completion:nil];
    }
}

- (void) updateBadge{
    
    self.navigationItem.rightBarButtonItem.badgeValue = [NSString stringWithFormat:@"%d", self.score];
    
}
- (void) eraseBadge{
    self.score = 0;
    self.navigationItem.rightBarButtonItem.badgeValue = @"";
}

#pragma mark - Internal Methods
- (void)setFrontCardView:(CardView*)frontCardView{
    _frontCardView = frontCardView;
    self.currentCard = frontCardView.card;
    self.image = frontCardView.loadFront;
    self.title = frontCardView.loadDescription;
}
- (CardView *)popCardViewWithFrame:(CGRect)frame{
    //following line might break check other methods
    if([self.deckCards cardCount] == 0){
        return nil;
    }
    MDCSwipeToChooseViewOptions *options = [MDCSwipeToChooseViewOptions new];
    options.delegate = self;
    options.threshold = 160.f;
    options.onPan = ^(MDCPanState *state){
        CGRect frame = [self backCardViewFrame];
        self.backCardView.frame = CGRectMake(frame.origin.x,
                                             frame.origin.y - (state.thresholdRatio * 10.f),
                                             CGRectGetWidth(frame),
                                             CGRectGetHeight(frame));
    };
    
    CardView *cardView = [[CardView alloc] initWithFrame:frame
                                                    card:[self.deckCards topmostCard]
                                                options:options];
    NSLog(@"%u  %u", self.deckCards.topmostCard.suit, self.deckCards.topmostCard.value);
    [self.deckCards removeTopmostCard];
    NSLog(@"%u  %u", self.deckCards.topmostCard.suit, self.deckCards.topmostCard.value);
    
    return cardView;

    
    

}

#pragma mark View Contruction

- (CGRect)frontCardViewFrame {
    CGFloat horizontalPadding = 20.f;
    CGFloat topPadding = 90.f;
    CGFloat bottomPadding = 200.f;
    return CGRectMake(horizontalPadding,
                      topPadding,
                      CGRectGetWidth(self.view.frame) - (horizontalPadding * 2),
                      CGRectGetHeight(self.view.frame) - bottomPadding);
}

- (CGRect)backCardViewFrame {
    CGRect frontFrame = [self frontCardViewFrame];
    return CGRectMake(frontFrame.origin.x,
                      frontFrame.origin.y + 10.f,
                      CGRectGetWidth(frontFrame),
                      CGRectGetHeight(frontFrame));
}

//// Create and add the "greater than" button.
//- (void)constructNopeButton {
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    UIImage *image = [UIImage imageNamed:@"nope"];
//    button.frame = CGRectMake(ChoosePersonButtonHorizontalPadding,
//                              CGRectGetMaxY(self.backCardView.frame) + ChoosePersonButtonVerticalPadding,
//                              image.size.width,
//                              image.size.height);
//    [button setImage:image forState:UIControlStateNormal];
//    [button setTintColor:[UIColor colorWithRed:247.f/255.f
//                                         green:91.f/255.f
//                                          blue:37.f/255.f
//                                         alpha:1.f]];
//    [button addTarget:self
//               action:@selector(nopeFrontCardView)
//     forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
//}
//
//// Create and add the "higher than" button.
//- (void)constructLikedButton {
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    UIImage *image = [UIImage imageNamed:@"liked"];
//    button.frame = CGRectMake(CGRectGetMaxX(self.view.frame) - image.size.width - ChoosePersonButtonHorizontalPadding,
//                              CGRectGetMaxY(self.backCardView.frame) + ChoosePersonButtonVerticalPadding,
//                              image.size.width,
//                              image.size.height);
//    [button setImage:image forState:UIControlStateNormal];
//    [button setTintColor:[UIColor colorWithRed:29.f/255.f
//                                         green:245.f/255.f
//                                          blue:106.f/255.f
//                                         alpha:1.f]];
//    [button addTarget:self
//               action:@selector(likeFrontCardView)
//     forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
//}

-(void)showPopupCentered:(id)sender {
    [self showPopupWithStyle:CNPPopupStyleCentered];
}

- (void)showPopupWithStyle:(CNPPopupStyle)popupStyle {
    
    NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    NSAttributedString *title = [[NSAttributedString alloc] initWithString:@"Congrats!" attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:24], NSParagraphStyleAttributeName : paragraphStyle}];
    NSAttributedString *lineOne = [[NSAttributedString alloc] initWithString:@"You've finished the Game" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18], NSParagraphStyleAttributeName : paragraphStyle}];
    UIImage *icon = [UIImage imageNamed:@"Logonew"];
    NSAttributedString *lineTwo = [[NSAttributedString alloc] initWithString:@"Still having a few more drinks?" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18], NSForegroundColorAttributeName : [UIColor colorWithRed:0.46 green:0.8 blue:1.0 alpha:1.0], NSParagraphStyleAttributeName : paragraphStyle}];
    
    NSAttributedString *buttonTitle = [[NSAttributedString alloc] initWithString:@"Play Again" attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:18], NSForegroundColorAttributeName : [UIColor whiteColor], NSParagraphStyleAttributeName : paragraphStyle}];
    
    CNPPopupButtonItem *buttonItem = [CNPPopupButtonItem defaultButtonItemWithTitle:buttonTitle backgroundColor:[UIColor colorWithRed:0.46 green:0.8 blue:1.0 alpha:1.0]];
    buttonItem.selectionHandler = ^(CNPPopupButtonItem *item){
        Deck *newDeck = [[Deck alloc] init];
        [newDeck shuffle];
        self.deckCards = newDeck;
        [self viewDidLoad];
        NSLog(@"Block for button: %@", item.buttonTitle.string);
    };
    
    self.popupController = [[CNPPopupController alloc] initWithTitle:title contents:@[lineOne, icon, lineTwo] buttonItems:@[buttonItem] destructiveButtonItem:nil];
    self.popupController.theme = [CNPPopupTheme defaultTheme];
    self.popupController.theme.popupStyle = popupStyle;
    self.popupController.delegate = self;
    self.popupController.theme.presentationStyle = CNPPopupPresentationStyleSlideInFromBottom;
    [self.popupController presentPopupControllerAnimated:YES];
}

#pragma mark - CNPPopupController Delegate
-(void) checkDeck{
    if (self.deckCards.cardsRemaining == 0){
        [self showPopupWithStyle:CNPPopupStyleCentered];
        
    }
    else{
        
    }
}
- (void)popupController:(CNPPopupController *)controller didDismissWithButtonTitle:(NSString *)title {
    NSLog(@"Dismissed with button title: %@", title);
}

- (void)popupControllerDidPresent:(CNPPopupController *)controller {
    NSLog(@"Popup controller presented.");
}



- (void)viewDidLayoutSubviews {
    // Required Data Source
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
