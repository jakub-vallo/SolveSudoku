//
//  ViewController.m
//  Sudoku
//
//  Created by Jakub Vallo on 13/02/17.
//  Copyright © 2017 Jakub Vallo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic) BOOL isSelecting;
@property (nonatomic, strong) UIButton *selecting;
@property (nonatomic, strong) UIButton *updated;
@property (nonatomic, strong) UIColor *defaultColor;

@property (nonatomic, strong) NSMutableDictionary *buttons;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.buttons = [[NSMutableDictionary alloc] initWithCapacity:100];
    [self addButtons];
    self.defaultColor = self.button11.backgroundColor;
    
    [self updateAll:[[Game alloc] initDefaultTestGame].fields];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)clearButton:(id)sender {
    [self.addView setHidden:YES];
    [self.clearButton setHidden:YES];
    [self.selecting setTitle:@"" forState:UIControlStateNormal];
    [self.selecting setBackgroundColor:self.defaultColor];
    self.isSelecting = NO;
    self.selecting = nil;
}

- (IBAction)goNew:(id)sender {
    self.isSelecting = NO;
    self.selecting = nil;
    [self.addView setHidden:YES];
    [self.clearButton setHidden:YES];
    [self resetButtons];
}

- (IBAction)didSelectNewNumber:(id)sender {
    [self.addView setHidden:YES];
    [self.clearButton setHidden:YES];
    UIButton *b = (UIButton *) sender;
    [self.selecting setTitle:b.currentTitle forState:UIControlStateNormal];
    [self.selecting setBackgroundColor:self.defaultColor];
    self.isSelecting = NO;
    self.selecting = nil;
}

- (IBAction)didSelect:(id)sender {
    if (self.isSelecting) return;
    self.isSelecting = YES;
    self.selecting = sender;
    UIButton *b = (UIButton *) sender;
    [b setBackgroundColor:[UIColor redColor]];
    [self.addView setHidden:NO];
    [self.clearButton setHidden:NO];
}

- (IBAction)computeNext:(id)sender {
    [self.updated setBackgroundColor:self.defaultColor];
    self.updated = nil;
    
    self.game = [[Game alloc] initWithButtons:self.buttons];
    [self.game setDelegate:self];
    if ([self.game check]) [self.game mainLoopTimes:YES];
    else [self gameNotOK];
}

- (IBAction)computeAll:(id)sender {
    self.game = [[Game alloc] initWithButtons:self.buttons];
    [self.game setDelegate:self];
    if ([self.game check]) [self.game mainLoopTimes:NO];
    else [self gameNotOK];
}

# pragma mark - Game Delegate

- (void)updateAll:(NSDictionary *)fields {
    for (int i = 1; i < 10; i++) {
        for (int j = 1; j < 10; j++) {
            NSString *key = [NSString stringWithFormat:@"%d",10*i+j];
            Field *f = [fields objectForKey:key];
            if (f.value == 0) continue;
            UIButton *b = [self.buttons objectForKey:f.position];
            [b setTitle:[NSString stringWithFormat:@"%lu",(unsigned long)f.value] forState:UIControlStateNormal];
        }
    }
    NSLog(@"updateAll");
}

- (void)updateOne:(Field *)field {
    UIButton *b = [self.buttons objectForKey:field.position];
    self.updated = b;
    [b setBackgroundColor:[UIColor greenColor]];
    [b setTitle:[NSString stringWithFormat:@"%lu",(unsigned long)field.value] forState:UIControlStateNormal];
    NSLog(@"updateOne");
}

- (void)gameNotOK {
    //UIAlertView game is not ok, check ur numbers
    NSLog(@"gameNotok");
}

- (void)gameDone {
    //UIAlertView game done
    NSLog(@"gameDone");
}

- (void)failedToCompute {
    //UIAlertView failed to compute, "Forgive me, Master!"
    NSLog(@"failedToCompute");
}

#pragma mark - Buttons

-(void)resetButtons {
    NSString *key;
    for (int i = 1; i < 10; i++) {
        for (int j = 1; j < 10; j++) {
            key = [NSString stringWithFormat:@"%d",i*10+j];
            UIButton *button = [self.buttons objectForKey:key];
            [button setTitle:@"" forState:UIControlStateNormal];
            [button setBackgroundColor:self.defaultColor];
        }
    }
}

-(void)addButtons {
    [self.buttons setObject:self.button11 forKey:@"11"];
    [self.buttons setObject:self.button12 forKey:@"12"];
    [self.buttons setObject:self.button13 forKey:@"13"];
    [self.buttons setObject:self.button14 forKey:@"14"];
    [self.buttons setObject:self.button15 forKey:@"15"];
    [self.buttons setObject:self.button16 forKey:@"16"];
    [self.buttons setObject:self.button17 forKey:@"17"];
    [self.buttons setObject:self.button18 forKey:@"18"];
    [self.buttons setObject:self.button19 forKey:@"19"];
    
    [self.buttons setObject:self.button21 forKey:@"21"];
    [self.buttons setObject:self.button22 forKey:@"22"];
    [self.buttons setObject:self.button23 forKey:@"23"];
    [self.buttons setObject:self.button24 forKey:@"24"];
    [self.buttons setObject:self.button25 forKey:@"25"];
    [self.buttons setObject:self.button26 forKey:@"26"];
    [self.buttons setObject:self.button27 forKey:@"27"];
    [self.buttons setObject:self.button28 forKey:@"28"];
    [self.buttons setObject:self.button29 forKey:@"29"];
    
    [self.buttons setObject:self.button31 forKey:@"31"];
    [self.buttons setObject:self.button32 forKey:@"32"];
    [self.buttons setObject:self.button33 forKey:@"33"];
    [self.buttons setObject:self.button34 forKey:@"34"];
    [self.buttons setObject:self.button35 forKey:@"35"];
    [self.buttons setObject:self.button36 forKey:@"36"];
    [self.buttons setObject:self.button37 forKey:@"37"];
    [self.buttons setObject:self.button38 forKey:@"38"];
    [self.buttons setObject:self.button39 forKey:@"39"];
    
    [self.buttons setObject:self.button41 forKey:@"41"];
    [self.buttons setObject:self.button42 forKey:@"42"];
    [self.buttons setObject:self.button43 forKey:@"43"];
    [self.buttons setObject:self.button44 forKey:@"44"];
    [self.buttons setObject:self.button45 forKey:@"45"];
    [self.buttons setObject:self.button46 forKey:@"46"];
    [self.buttons setObject:self.button47 forKey:@"47"];
    [self.buttons setObject:self.button48 forKey:@"48"];
    [self.buttons setObject:self.button49 forKey:@"49"];
    
    [self.buttons setObject:self.button51 forKey:@"51"];
    [self.buttons setObject:self.button52 forKey:@"52"];
    [self.buttons setObject:self.button53 forKey:@"53"];
    [self.buttons setObject:self.button54 forKey:@"54"];
    [self.buttons setObject:self.button55 forKey:@"55"];
    [self.buttons setObject:self.button56 forKey:@"56"];
    [self.buttons setObject:self.button57 forKey:@"57"];
    [self.buttons setObject:self.button58 forKey:@"58"];
    [self.buttons setObject:self.button59 forKey:@"59"];
    
    [self.buttons setObject:self.button61 forKey:@"61"];
    [self.buttons setObject:self.button62 forKey:@"62"];
    [self.buttons setObject:self.button63 forKey:@"63"];
    [self.buttons setObject:self.button64 forKey:@"64"];
    [self.buttons setObject:self.button65 forKey:@"65"];
    [self.buttons setObject:self.button66 forKey:@"66"];
    [self.buttons setObject:self.button67 forKey:@"67"];
    [self.buttons setObject:self.button68 forKey:@"68"];
    [self.buttons setObject:self.button69 forKey:@"69"];
    
    [self.buttons setObject:self.button71 forKey:@"71"];
    [self.buttons setObject:self.button72 forKey:@"72"];
    [self.buttons setObject:self.button73 forKey:@"73"];
    [self.buttons setObject:self.button74 forKey:@"74"];
    [self.buttons setObject:self.button75 forKey:@"75"];
    [self.buttons setObject:self.button76 forKey:@"76"];
    [self.buttons setObject:self.button77 forKey:@"77"];
    [self.buttons setObject:self.button78 forKey:@"78"];
    [self.buttons setObject:self.button79 forKey:@"79"];
    
    [self.buttons setObject:self.button81 forKey:@"81"];
    [self.buttons setObject:self.button82 forKey:@"82"];
    [self.buttons setObject:self.button83 forKey:@"83"];
    [self.buttons setObject:self.button84 forKey:@"84"];
    [self.buttons setObject:self.button85 forKey:@"85"];
    [self.buttons setObject:self.button86 forKey:@"86"];
    [self.buttons setObject:self.button87 forKey:@"87"];
    [self.buttons setObject:self.button88 forKey:@"88"];
    [self.buttons setObject:self.button89 forKey:@"89"];
    
    [self.buttons setObject:self.button91 forKey:@"91"];
    [self.buttons setObject:self.button92 forKey:@"92"];
    [self.buttons setObject:self.button93 forKey:@"93"];
    [self.buttons setObject:self.button94 forKey:@"94"];
    [self.buttons setObject:self.button95 forKey:@"95"];
    [self.buttons setObject:self.button96 forKey:@"96"];
    [self.buttons setObject:self.button97 forKey:@"97"];
    [self.buttons setObject:self.button98 forKey:@"98"];
    [self.buttons setObject:self.button99 forKey:@"99"];
}

@end
