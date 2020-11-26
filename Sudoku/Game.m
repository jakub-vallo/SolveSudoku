//
//  Game.m
//  Sudoku
//
//  Created by Jakub Vallo on 19/02/17.
//  Copyright © 2017 Jakub Vallo. All rights reserved.
//

#import "Game.h"

@implementation Game

- (id)initDefaultTestGame {
    
    NSMutableDictionary *testFields = [[NSMutableDictionary alloc] init];
    [testFields setValue:[NSNumber numberWithInt:2] forKey:@"12"];
    [testFields setValue:[NSNumber numberWithInt:4] forKey:@"16"];
    [testFields setValue:[NSNumber numberWithInt:9] forKey:@"17"];
    [testFields setValue:[NSNumber numberWithInt:7] forKey:@"22"];
    [testFields setValue:[NSNumber numberWithInt:5] forKey:@"24"];
    [testFields setValue:[NSNumber numberWithInt:9] forKey:@"26"];
    [testFields setValue:[NSNumber numberWithInt:3] forKey:@"32"];
    [testFields setValue:[NSNumber numberWithInt:6] forKey:@"34"];
    [testFields setValue:[NSNumber numberWithInt:4] forKey:@"39"];
    [testFields setValue:[NSNumber numberWithInt:6] forKey:@"42"];
    [testFields setValue:[NSNumber numberWithInt:2] forKey:@"46"];
    [testFields setValue:[NSNumber numberWithInt:9] forKey:@"48"];
    [testFields setValue:[NSNumber numberWithInt:7] forKey:@"51"];
    [testFields setValue:[NSNumber numberWithInt:8] forKey:@"53"];
    [testFields setValue:[NSNumber numberWithInt:2] forKey:@"57"];
    [testFields setValue:[NSNumber numberWithInt:3] forKey:@"59"];
    [testFields setValue:[NSNumber numberWithInt:9] forKey:@"62"];
    [testFields setValue:[NSNumber numberWithInt:1] forKey:@"64"];
    [testFields setValue:[NSNumber numberWithInt:5] forKey:@"68"];
    [testFields setValue:[NSNumber numberWithInt:1] forKey:@"71"];
    [testFields setValue:[NSNumber numberWithInt:6] forKey:@"76"];
    [testFields setValue:[NSNumber numberWithInt:5] forKey:@"78"];
    [testFields setValue:[NSNumber numberWithInt:9] forKey:@"84"];
    [testFields setValue:[NSNumber numberWithInt:4] forKey:@"86"];
    [testFields setValue:[NSNumber numberWithInt:8] forKey:@"88"];
    [testFields setValue:[NSNumber numberWithInt:7] forKey:@"93"];
    [testFields setValue:[NSNumber numberWithInt:8] forKey:@"94"];
    [testFields setValue:[NSNumber numberWithInt:6] forKey:@"98"];
    
    self = [super init];
    if (self) {
        NSString *key;
        self.fields = [[NSMutableDictionary alloc] initWithCapacity:100];
        for (int i = 1; i < 10; i++) {
            for (int j = 1; j < 10; j++) {
                key = [NSString stringWithFormat:@"%d",i*10+j];
                NSUInteger number;
                NSNumber *testNumber = [testFields valueForKey:key];
                if (testNumber) number = [testNumber intValue];
                else number = 0;
                Field *f = [[Field alloc] initWithValue:number andWithPosition:key];
                [self.fields setValue:f forKey:key];
            }
        }
    }
    return self;
}

- (id)initWithButtons:(NSDictionary *)buttons {
    self = [super init];
    if (self) {
        NSString *key;
        self.fields = [[NSMutableDictionary alloc] initWithCapacity:100];
        for (int i = 1; i < 10; i++) {
            for (int j = 1; j < 10; j++) {
                key = [NSString stringWithFormat:@"%d",i*10+j];
                UIButton *button = [buttons objectForKey:key];
                NSUInteger number;
                if ([button.currentTitle isEqualToString:@""]) number = 0;
                else number = [button.currentTitle integerValue];
                Field *f = [[Field alloc] initWithValue:number andWithPosition:key];
                f.possible = [[NSMutableArray alloc] initWithArray:@[@1, @2, @3, @4, @5, @6, @7, @8, @9]];
                [self.fields setValue:f forKey:key];
            }
        }
    }
    return self;
}

- (void)mainLoopTimes:(BOOL)once {
    while (true) {
        if(![self check]) {
            [self.delegate gameNotOK];
            break;
        }
        if ([self done]) {
            [self.delegate updateAll:self.fields];
            [self.delegate gameDone];
            break;
        }
        
        [self applyRules];
        
        if ([self updateState]) {
            [self printCurrent];
        } else {
            if (!once) [self.delegate updateAll:self.fields];
            [self printMissing];
            [self.delegate failedToCompute];
            break;
        }
        if (once) {
            [self.delegate updateOne:self.current];
            break;
        }
    }
}

- (BOOL)done {
    for (int i = 1; i < 10; i++) {
        for (int j = 1; j < 10; j++) {
            NSString *key = [NSString stringWithFormat:@"%d", i*10+j];
            Field *f = [self.fields objectForKey:key];
            if (f.value == 0) return NO;
        }
    }
    return YES;
}

- (BOOL)updateState {
    //find new number, update corresponding field and store it in _current, return yes if number was found
    if ([self checkOnePossible]) return YES;
    if ([self checkUniquePosition]) return YES;
    return NO;
}

- (void)applyRules {
    //apply rules to reduce possible numbers for each field
    [self checkSquareRowColumn];
    [self checkSingleSquareRowColumn];
    [self checkPairs];
    //add rule: pairs/triples
}

- (NSString *)firstRowFieldKeyFromPrintRow:(int)row {
    switch (row) {
        case 2: return @"11";
        case 4: return @"14";
        case 6: return @"17";
        case 9: return @"41";
        case 11: return @"44";
        case 13: return @"47";
        case 16: return @"71";
        case 18: return @"74";
        case 20: return @"77";
        default: return @"-- - - - - - -- - - - - - -- - - - - - --";
    }
}

- (NSUInteger)fieldIndexFromPrintColumn:(int)column {
    switch (column) {
        case 2: return 10;
        case 4: return 0;
        case 6: return 1;
        case 9: return 2;
        case 11: return 3;
        case 13: return 4;
        case 16: return 5;
        case 18: return 6;
        case 20: return 7;
        default: return 1000;
    }
}

- (void)printCurrent {
    
    //NSArray *firstRowFields = @[@"11", @"14", @"17", @"41", @"44", @"47", @"71", @"74", @"77"];
    NSString *separatorRow = @"-- - - - - - -- - - - - - -- - - - - - --";
    
    for (int row = 0; row < 22; row++) {
        NSString *key = [self firstRowFieldKeyFromPrintRow:row];
        Field *firstRowField = [self.fields objectForKey:key];
        NSMutableString *rowStr = [NSMutableString new];
        if (firstRowField) {
            NSArray *rowFields = [self getRow:firstRowField];
            for (int column = 0; column < 22; column++)  {
                NSUInteger index = [self fieldIndexFromPrintColumn:column];
                if (index == 1000) [rowStr appendString:@"|"];
                else {
                    Field *f;
                    if (index == 10) f = firstRowField;
                    else f = [rowFields objectAtIndex:index];
                    if (f.value == 0) [rowStr appendString:@"   "];
                    else [rowStr appendString:[NSString stringWithFormat:@" %lu ",(unsigned long)f.value]];
                }
            }
            [rowStr appendString:@"|"];
        } else [rowStr appendString:key];
        NSLog(@"%@", rowStr);
    }
    NSLog(@"%@\n%@", separatorRow, separatorRow);
}

- (void)printMissing {
    for (int i = 1; i < 10; i++) {
        for (int j = 1; j < 10; j++) {
            NSString *key = [NSString stringWithFormat:@"%d",i*10+j];
            Field *f = [self.fields objectForKey:key];
            if (f.value != 0) continue;
            NSMutableString *arrayString = [@"[" mutableCopy];
            for (NSNumber *n in f.possible) {
                [arrayString appendFormat:@"%d, ", n.intValue];
            }
            [arrayString appendString:@"]"];
            NSLog(@"%@ %@", key, arrayString);
        }
    }
    
}

#pragma mark - Check

- (BOOL)check {
    for (int i = 1; i < 10; i++) {
        for (int j = 1; j < 10; j++) {
            NSString *key = [NSString stringWithFormat:@"%d",i*10+j];
            Field *f = [self.fields objectForKey:key];
            if (![self isFieldOK:f]) return NO;
        }
    }
    return YES;
}

- (BOOL)isFieldOK:(Field *)field {
    if (field.value == 0 && field.possible.count > 0) return YES;
    BOOL isOK = YES;
    //check square
    NSMutableArray *array = [self getSquare:field];
    for (Field *f in array) {
        if (f.value == field.value) isOK = NO;
    }
    //check row
    array = [self getRow:field];
    for (Field *f in array) {
        if (f.value == field.value) isOK = NO;
    }
    //check column
    array = [self getColumn:field];
    for (Field *f in array) {
        if (f.value == field.value) isOK = NO;
    }
    
    return isOK;
}

#pragma mark - Get

- (NSMutableArray *)getRow: (Field *)field {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    NSUInteger square = ([field.position integerValue]/10 - 1)/3;
    NSUInteger row = ([field.position integerValue]%10 - 1)/3;
    for (int i = 1; i < 10; i++) {
        for (int j = 1; j < 10; j++) {
            Field *f = [self.fields objectForKey:[NSString stringWithFormat:@"%d",i*10+j]];
            if ([field.position isEqualToString:f.position]) continue;
            NSUInteger sq = ([f.position integerValue]/10 - 1)/3;
            NSUInteger rw = ([f.position integerValue]%10 - 1)/3;
            if (sq == square && rw == row) [array addObject:f];
        }
    }
    return array;
}

- (NSMutableArray *)getColumn: (Field *)field {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    NSUInteger square = ([field.position integerValue]/10)%3;
    NSUInteger column = ([field.position integerValue]%10)%3;
    for (int i = 1; i < 10; i++) {
        for (int j = 1; j < 10; j++) {
            Field *f = [self.fields objectForKey:[NSString stringWithFormat:@"%d",i*10+j]];
            if ([field.position isEqualToString:f.position]) continue;
            NSUInteger sq = ([f.position integerValue]/10)%3;
            NSUInteger col = ([f.position integerValue]%10)%3;
            if (sq == square && col == column) [array addObject:f];
        }
    }
    return array;
}

- (NSMutableArray *)getSquare: (Field *)field {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSUInteger square = [field.position integerValue]/10;
    for (int i = 1; i < 10; i++) {
        Field *f = [self.fields objectForKey:[NSString stringWithFormat:@"%lu",square*10+i]];
        if ([field.position isEqualToString:f.position]) continue;
        [array addObject:f];
    }
    return array;
}

#pragma mark - Rules

- (BOOL)checkSquareRowColumn {
    BOOL removeAtAll = NO;
    for (int i = 1; i < 10; i++) {
        for (int j = 1; j < 10; j++) {
            NSString *key = [NSString stringWithFormat:@"%d", i*10+j];
            Field *f = [self.fields objectForKey:key];
            if (f.value != 0) continue;
            NSArray *row = [self getRow:f];
            NSArray *column = [self getColumn:f];
            NSArray *square = [self getSquare:f];
            
            for (int k = 1; k < 10; k++) {
                BOOL remove = NO;
                if (![f.possible containsObject:[NSNumber numberWithInteger:k]]) continue;
                for (Field *p in row) if (p.value == k) remove = YES;
                for (Field *p in column) if (p.value == k) remove = YES;
                for (Field *p in square) if (p.value == k) remove = YES;
                if (remove) {
                    removeAtAll = YES;
                    [f.possible removeObject:[NSNumber numberWithInteger:k]];
                }
            }
        }
    }
    return removeAtAll;
}

- (BOOL)checkPairs {
    for (int i = 1; i < 10; i++) {
        for (int j = 1; j < 10; j++) {
            NSString *key = [NSString stringWithFormat:@"%d", i*10+j];
            Field *f = [self.fields objectForKey:key];
            if (f.value != 0) continue;
            NSArray *row = [self getRow:f];
            NSArray *column = [self getColumn:f];
            NSArray *square = [self getSquare:f];
            
            if ([self clearPossibleWithPairForField:f withShape:row]) return YES;
            if ([self clearPossibleWithPairForField:f withShape:column]) return YES;
            if ([self clearPossibleWithPairForField:f withShape:square]) return YES;
        }
    }
    return NO;
}

- (BOOL)clearPossibleWithPairForField:(Field *)field withShape:(NSArray *)shape {
    NSArray *together = [[[NSMutableArray alloc] initWithArray:shape] arrayByAddingObject:field];
    NSMutableDictionary *fieldPairsForIndex = [[NSMutableDictionary alloc] init];
    for (int i = 1; i < 10; i++) {
        NSMutableArray *fields = [NSMutableArray new];
        for (Field *f in together) {
            if ([f.possible containsObject:[NSNumber numberWithInt:i]]) [fields addObject:f];
        }
        if (fields.count == 2) [fieldPairsForIndex setValue:fields forKey:[NSString stringWithFormat:@"%d", i]];
    }
    
    for (int i = 1; i < 10; i++) {
        NSArray *fields = [fieldPairsForIndex valueForKey:[NSString stringWithFormat:@"%d", i]];
        if (fields == nil) continue;
        for (int j = 1; j < 10; j++) {
            NSArray *otherFields = [fieldPairsForIndex valueForKey:[NSString stringWithFormat:@"%d", j]];
            if (otherFields == nil) continue;
            if (fields == otherFields) continue;
            if ([fields isEqualToArray:otherFields]) {
                for (Field *f in fields) {
                    f.possible = [NSMutableArray arrayWithArray:@[[NSNumber numberWithInt:i], [NSNumber numberWithInt:j]]];
                }
                return YES;
            }
        }
    }
    
    return NO;
}

- (BOOL)checkSingleSquareRowColumn {
    BOOL removeAtAll = NO;
    for (int i = 1; i < 10; i++) {
        for (int j = 1; j < 10; j++) {
            NSString *key = [NSString stringWithFormat:@"%d",i*10+j];
            Field *f = [self.fields objectForKey:key];
            if (f.value != 0) continue;
            NSArray *row = [self getRow:f];
            NSArray *column = [self getColumn:f];
            NSArray *square = [self getSquare:f];
            
            for (NSNumber *n in f.possible) {
                NSMutableArray *sharedPossible = [NSMutableArray new];
                for (Field *g in square) {
                    if (g.value != 0) continue;
                    if ([g.possible containsObject:n]) [sharedPossible addObject:g];
                }
                
                //check if it is only row
                BOOL onlyRow = YES;
                for (Field *g in sharedPossible) {
                    if (![row containsObject:g]) onlyRow = NO;
                }
                if (onlyRow) {
                    for (Field *g in row) {
                        if (g.value != 0) continue;
                        if ([square containsObject:g]) continue;
                        if ([g.possible containsObject:n]) {
                            [g.possible removeObject:n];
                            removeAtAll = YES;
                        }
                    }
                }
                
                //check if it is only column
                BOOL onlyColumn = YES;
                for (Field *g in sharedPossible) {
                    if (![column containsObject:g]) onlyColumn = NO;
                }
                if (onlyColumn) {
                    for (Field *g in column) {
                        if (g.value != 0) continue;
                        if ([square containsObject:g]) continue;
                        if ([g.possible containsObject:n]) {
                            [g.possible removeObject:n];
                            removeAtAll = YES;
                        }
                    }
                }
            }
        }
    }
    if (removeAtAll) {
        NSLog(@"Did checkSingleSquareRowColumn");
    }
    return removeAtAll;
}

# pragma mark - Update

- (BOOL)checkOnePossible {
    for (int i = 1; i < 10; i++) {
        for (int j = 1; j < 10; j++) {
            NSString *key = [NSString stringWithFormat:@"%d",i*10+j];
            Field *f = [self.fields objectForKey:key];
            if (f.value != 0) continue;
            if (f.possible.count == 1) {
                NSNumber *n = [f.possible objectAtIndex:0];
                f.value = n.unsignedIntegerValue;
                self.current = f;
                return YES;
            }
        }
    }
    return NO;
}

- (BOOL)checkUniquePosition {
    for (int i = 1; i < 10; i++) {
        for (int j = 1; j < 10; j++) {
            NSString *key = [NSString stringWithFormat:@"%d",i*10+j];
            Field *f = [self.fields objectForKey:key];
            if (f.value != 0) continue;
            NSMutableArray *thisPossible = [[NSMutableArray alloc] initWithArray:f.possible];
            NSArray *row = [self getRow:f];
            NSArray *column = [self getColumn:f];
            NSArray *square = [self getSquare:f];
            BOOL found = NO;
            
            for (Field *g in row) {
                if (g.value != 0) continue;
                for (NSNumber *n in g.possible) {
                    [thisPossible removeObject:n];
                }
            }
            if (thisPossible.count > 0) found = YES;
            else [thisPossible addObjectsFromArray:f.possible];
            
            if (!found) {
                for (Field *g in column) {
                    if (g.value != 0) continue;
                    for (NSNumber *n in g.possible) {
                        [thisPossible removeObject:n];
                    }
                }
                if (thisPossible.count > 0) found = YES;
                else [thisPossible addObjectsFromArray:f.possible];
            }
            
            if (!found) {
                for (Field *g in square) {
                    if (g.value != 0) continue;
                    for (NSNumber *n in g.possible) {
                        [thisPossible removeObject:n];
                    }
                }
                if (thisPossible.count > 0) found = YES;
            }
            
            if (found) {
                if (thisPossible.count > 1) NSLog(@"Error");
                NSNumber *n = [thisPossible objectAtIndex:0];
                f.value = n.unsignedIntegerValue;
                self.current = f;
                return YES;
            }
        }
    }
    return NO;
}

@end
