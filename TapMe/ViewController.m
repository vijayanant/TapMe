//
//  ViewController.m
//  TapMe
//
//  Created by Vijay Ananth on 01/02/2014.
//  Copyright (c) 2014 Vijay Ananth. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_tile.png"]];
    
    scoreLabel.numberOfLines=2;
    scoreLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"field_score.png"]];
    timerLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"field_time.png"]];
    
    buttonBeep = [self setupAudioPlayerWithFile:@"ButtonTap" type:@"wav"];
    secondBeep = [self setupAudioPlayerWithFile:@"SecondBeep" type:@"wav"];
    backgroundMusic = [self setupAudioPlayerWithFile:@"HallOfTheMountainKing" type:@"mp3"];

    
    [self setUpGame];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpGame
{
    currentScore = 0;
    timeLeft = 30;
    
    scoreLabel.text = [NSString stringWithFormat:@"Score\n%i", currentScore];
    timerLabel.text = [NSString stringWithFormat:@"Time: %is", timeLeft];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(checkInterval) userInfo:nil repeats:YES];

    [backgroundMusic setVolume:0.2];
    [backgroundMusic play];
}

- (void) checkInterval {
    timeLeft--;
    timerLabel.text = [NSString stringWithFormat:@"Remaining: %i", timeLeft];
    [secondBeep play];
    
    if (timeLeft == 0) {
        [timer invalidate];
        UIAlertView *showScore = [[UIAlertView alloc]
                            initWithTitle:@"Time is up"
                            message:[NSString stringWithFormat:@"You scored %i points", currentScore]
                            delegate:self
                            cancelButtonTitle: @"Play Again"
                            otherButtonTitles:nil];
        [showScore show];
    }
    
}

- (IBAction)buttonPressed {
    currentScore++;
    scoreLabel.text = [NSString stringWithFormat:@"Score\n%i",currentScore];
    [buttonBeep play];
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self setUpGame];
}

- (AVAudioPlayer *)setupAudioPlayerWithFile:(NSString *)file type:(NSString *)type
{
    // 1
    NSString *path = [[NSBundle mainBundle] pathForResource:file ofType:type];
    NSURL *url = [NSURL fileURLWithPath:path];
    
    // 2
    NSError *error;
    
    // 3
    AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    
    // 4
    if (!audioPlayer) {
        NSLog(@"%@",[error description]);
    }
    
    // 5
    return audioPlayer;
}

@end
