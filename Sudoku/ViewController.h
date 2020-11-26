//
//  ViewController.h
//  Sudoku
//
//  Created by Jakub Vallo on 13/02/17.
//  Copyright © 2017 Jakub Vallo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Game.h"

@interface ViewController : UIViewController <GameDelegate>

@property (nonatomic, strong) IBOutlet UIView *addView;
@property (nonatomic, strong) Game *game;
@property (weak, nonatomic) IBOutlet UIButton *clearButton;

- (IBAction)clearButton:(id)sender;
- (IBAction)goNew:(id)sender;
- (IBAction)didSelectNewNumber:(id)sender;
- (IBAction)didSelect:(id)sender;
- (IBAction)computeNext:(id)sender;
- (IBAction)computeAll:(id)sender;

@property (nonatomic, strong) IBOutlet UIButton *button11;
@property (nonatomic, strong) IBOutlet UIButton *button12;
@property (nonatomic, strong) IBOutlet UIButton *button13;
@property (nonatomic, strong) IBOutlet UIButton *button14;
@property (nonatomic, strong) IBOutlet UIButton *button15;
@property (nonatomic, strong) IBOutlet UIButton *button16;
@property (nonatomic, strong) IBOutlet UIButton *button17;
@property (nonatomic, strong) IBOutlet UIButton *button18;
@property (nonatomic, strong) IBOutlet UIButton *button19;

@property (nonatomic, strong) IBOutlet UIButton *button21;
@property (nonatomic, strong) IBOutlet UIButton *button22;
@property (nonatomic, strong) IBOutlet UIButton *button23;
@property (nonatomic, strong) IBOutlet UIButton *button24;
@property (nonatomic, strong) IBOutlet UIButton *button25;
@property (nonatomic, strong) IBOutlet UIButton *button26;
@property (nonatomic, strong) IBOutlet UIButton *button27;
@property (nonatomic, strong) IBOutlet UIButton *button28;
@property (nonatomic, strong) IBOutlet UIButton *button29;

@property (nonatomic, strong) IBOutlet UIButton *button31;
@property (nonatomic, strong) IBOutlet UIButton *button32;
@property (nonatomic, strong) IBOutlet UIButton *button33;
@property (nonatomic, strong) IBOutlet UIButton *button34;
@property (nonatomic, strong) IBOutlet UIButton *button35;
@property (nonatomic, strong) IBOutlet UIButton *button36;
@property (nonatomic, strong) IBOutlet UIButton *button37;
@property (nonatomic, strong) IBOutlet UIButton *button38;
@property (nonatomic, strong) IBOutlet UIButton *button39;

@property (nonatomic, strong) IBOutlet UIButton *button41;
@property (nonatomic, strong) IBOutlet UIButton *button42;
@property (nonatomic, strong) IBOutlet UIButton *button43;
@property (nonatomic, strong) IBOutlet UIButton *button44;
@property (nonatomic, strong) IBOutlet UIButton *button45;
@property (nonatomic, strong) IBOutlet UIButton *button46;
@property (nonatomic, strong) IBOutlet UIButton *button47;
@property (nonatomic, strong) IBOutlet UIButton *button48;
@property (nonatomic, strong) IBOutlet UIButton *button49;

@property (nonatomic, strong) IBOutlet UIButton *button51;
@property (nonatomic, strong) IBOutlet UIButton *button52;
@property (nonatomic, strong) IBOutlet UIButton *button53;
@property (nonatomic, strong) IBOutlet UIButton *button54;
@property (nonatomic, strong) IBOutlet UIButton *button55;
@property (nonatomic, strong) IBOutlet UIButton *button56;
@property (nonatomic, strong) IBOutlet UIButton *button57;
@property (nonatomic, strong) IBOutlet UIButton *button58;
@property (nonatomic, strong) IBOutlet UIButton *button59;

@property (nonatomic, strong) IBOutlet UIButton *button61;
@property (nonatomic, strong) IBOutlet UIButton *button62;
@property (nonatomic, strong) IBOutlet UIButton *button63;
@property (nonatomic, strong) IBOutlet UIButton *button64;
@property (nonatomic, strong) IBOutlet UIButton *button65;
@property (nonatomic, strong) IBOutlet UIButton *button66;
@property (nonatomic, strong) IBOutlet UIButton *button67;
@property (nonatomic, strong) IBOutlet UIButton *button68;
@property (nonatomic, strong) IBOutlet UIButton *button69;

@property (nonatomic, strong) IBOutlet UIButton *button71;
@property (nonatomic, strong) IBOutlet UIButton *button72;
@property (nonatomic, strong) IBOutlet UIButton *button73;
@property (nonatomic, strong) IBOutlet UIButton *button74;
@property (nonatomic, strong) IBOutlet UIButton *button75;
@property (nonatomic, strong) IBOutlet UIButton *button76;
@property (nonatomic, strong) IBOutlet UIButton *button77;
@property (nonatomic, strong) IBOutlet UIButton *button78;
@property (nonatomic, strong) IBOutlet UIButton *button79;

@property (nonatomic, strong) IBOutlet UIButton *button81;
@property (nonatomic, strong) IBOutlet UIButton *button82;
@property (nonatomic, strong) IBOutlet UIButton *button83;
@property (nonatomic, strong) IBOutlet UIButton *button84;
@property (nonatomic, strong) IBOutlet UIButton *button85;
@property (nonatomic, strong) IBOutlet UIButton *button86;
@property (nonatomic, strong) IBOutlet UIButton *button87;
@property (nonatomic, strong) IBOutlet UIButton *button88;
@property (nonatomic, strong) IBOutlet UIButton *button89;

@property (nonatomic, strong) IBOutlet UIButton *button91;
@property (nonatomic, strong) IBOutlet UIButton *button92;
@property (nonatomic, strong) IBOutlet UIButton *button93;
@property (nonatomic, strong) IBOutlet UIButton *button94;
@property (nonatomic, strong) IBOutlet UIButton *button95;
@property (nonatomic, strong) IBOutlet UIButton *button96;
@property (nonatomic, strong) IBOutlet UIButton *button97;
@property (nonatomic, strong) IBOutlet UIButton *button98;
@property (nonatomic, strong) IBOutlet UIButton *button99;

@end

