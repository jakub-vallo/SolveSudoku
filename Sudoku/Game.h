//
//  Game.h
//  Sudoku
//
//  Created by Jakub Vallo on 19/02/17.
//  Copyright © 2017 Jakub Vallo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Field.h"

//declare protocol to update the table after the data are fetched
@protocol GameDelegate <NSObject>

- (void)updateOne: (Field *)field;
- (void)updateAll: (NSMutableDictionary *)fields;
- (void)failedToCompute;
- (void)gameNotOK;
- (void)gameDone;

@end

@interface Game : NSObject

@property (nonatomic, weak) id <GameDelegate> delegate;

@property (nonatomic, strong) NSMutableDictionary *fields;
@property (nonatomic, strong) Field *current;

- (id)initDefaultTestGame;
- (id)initWithButtons:(NSDictionary *) buttons;
- (BOOL)check;
- (void)mainLoopTimes:(BOOL)once;

@end
