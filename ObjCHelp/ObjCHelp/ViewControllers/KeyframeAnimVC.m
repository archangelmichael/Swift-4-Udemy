//
//  KeyframeAnimVC.m
//  ObjCHelp
//
//  Created by Radi Shikerov on 18.01.18.
//  Copyright © 2018 Radi. All rights reserved.
//

#import "KeyframeAnimVC.h"

@interface KeyframeAnimVC ()

@property (weak, nonatomic) IBOutlet UIImageView *ivLogo;
@property (weak, nonatomic) IBOutlet UILabel *lblInteractions;
@property (weak, nonatomic) IBOutlet UILabel *lblInteractionDuration;

@end

@implementation KeyframeAnimVC

BOOL animationsInProgress = NO;
void (^appearAnimation)(void) = ^{ };
void (^disappearAnimation)(void) = ^{ };

double numberOfAnimations = 6.0;
double subAnimDuration = 0.5;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.ivLogo.alpha = 0.0;
    appearAnimation = ^{ self.ivLogo.alpha = 1.0; };
    disappearAnimation = ^{ self.ivLogo.alpha = 0.0; };
}

- (IBAction)onInteractionsCountChanged:(id)sender {
    UIStepper * interactionsCountStepper = (UIStepper *)sender;
    if (interactionsCountStepper) {
        double interactions = interactionsCountStepper.value;
        self.lblInteractions.text = [NSString stringWithFormat:@"%.f",  interactions];
        numberOfAnimations = interactions * 2;
    }
}

- (IBAction)onInteractionDuratioanChanged:(id)sender {
    UIStepper * interactionDurationStepper = (UIStepper *)sender;
    if (interactionDurationStepper) {
        double duration = interactionDurationStepper.value;
        self.lblInteractionDuration.text = [NSString stringWithFormat:@"%.f",  duration];
        subAnimDuration = duration / 2;
    }
}


- (IBAction)onStart:(id)sender {
    if (animationsInProgress) {
        [self stopAnimations];
    }
    
    NSLog(@"Animation started");
   
    double totalAnimDuration = numberOfAnimations * subAnimDuration;
    double relativeAnimDuration = 1.0/numberOfAnimations;
    
    animationsInProgress = YES;
    self.ivLogo.alpha = 0;
    
    [UIView animateKeyframesWithDuration:totalAnimDuration
                                   delay:0
                                 options:UIViewKeyframeAnimationOptionCalculationModeCubic
                              animations:
     ^{
         for (int animationIndex = 0; animationIndex < numberOfAnimations; animationIndex++) {
             [UIView addKeyframeWithRelativeStartTime:relativeAnimDuration * animationIndex
                                     relativeDuration:relativeAnimDuration
                                           animations: animationIndex%2 == 0 ? appearAnimation : disappearAnimation];
         }
     }
                              completion:^(BOOL finished)
     {
         if (finished) {
             animationsInProgress = NO;
             [self stopAnimations];
         }
     }];
}

- (IBAction)onStop:(id)sender {
    [self stopAnimations];
}

- (void)stopAnimations {
    [self.ivLogo.layer removeAllAnimations];
    NSLog(@"Animation stopped");
}

@end
