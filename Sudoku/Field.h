//
//  Field.h
//  Sudoku
//
//  Created by Jakub Vallo on 19/02/17.
//  Copyright © 2017 Jakub Vallo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Field : NSObject

@property (nonatomic) NSUInteger value;
@property (nonatomic, strong) NSString *position;
@property (nonatomic, strong) NSMutableArray *possible;

-(id)initWithValue:(NSUInteger)value andWithPosition:(NSString *)pos;

@end
