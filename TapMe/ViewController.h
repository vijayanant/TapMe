//
//  ViewController.h
//  TapMe
//
//  Created by Vijay Ananth on 01/02/2014.
//  Copyright (c) 2014 Vijay Ananth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController <UIAlertViewDelegate>{
    IBOutlet UILabel *scoreLabel;
    IBOutlet UILabel *timerLabel;
    
    NSInteger currentScore;
    NSInteger timeLeft;
    NSTimer *timer;
    
    AVAudioPlayer *buttonBeep;
    AVAudioPlayer *secondBeep;
    AVAudioPlayer *backgroundMusic;
}

-(IBAction)buttonPressed;


@end
