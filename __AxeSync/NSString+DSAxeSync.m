//
//  Created by Andrew Podkovyrin
//  Copyright © 2019 Dash Core Group. All rights reserved.
//
//  Licensed under the MIT License (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  https://opensource.org/licenses/MIT
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import "NSString+DSAxeAttributedStrings.h"

#import "DSPriceManager.h"
#import "UIImage+DSUtils.h"

@implementation NSString (DSAxeSync)

- (NSAttributedString *)attributedStringForAxeSymbol {
    return [self attributedStringForAxeSymbolWithTintColor:[UIColor blackColor]];
}

- (NSAttributedString *)attributedStringForAxeSymbolWithTintColor:(UIColor *)color {
    return [self attributedStringForAxeSymbolWithTintColor:color axeSymbolSize:CGSizeMake(12, 12)];
}

+ (NSAttributedString *)axeSymbolAttributedStringWithTintColor:(UIColor *)color forAxeSymbolSize:(CGSize)axeSymbolSize {
    NSTextAttachment *axeSymbol = [[NSTextAttachment alloc] init];

    axeSymbol.bounds = CGRectMake(0, 0, axeSymbolSize.width, axeSymbolSize.height);
    axeSymbol.image = [[UIImage imageNamed:@"Axe-Light"] ds_imageWithTintColor:color];
    return [NSAttributedString attributedStringWithAttachment:axeSymbol];
}


- (NSAttributedString *)attributedStringForAxeSymbolWithTintColor:(UIColor *)color axeSymbolSize:(CGSize)axeSymbolSize {

    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]
        initWithString:[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];

    NSRange range = [attributedString.string rangeOfString:AXE];
    if (range.location == NSNotFound) {
        [attributedString insertAttributedString:[[NSAttributedString alloc] initWithString:@" "] atIndex:0];
        [attributedString insertAttributedString:[NSString axeSymbolAttributedStringWithTintColor:color forAxeSymbolSize:axeSymbolSize] atIndex:0];

        [attributedString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, attributedString.length)];
    }
    else {
        [attributedString replaceCharactersInRange:range
                              withAttributedString:[NSString axeSymbolAttributedStringWithTintColor:color forAxeSymbolSize:axeSymbolSize]];
        [attributedString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, attributedString.length)];
    }
    return attributedString;
}

// MARK: time

+ (NSString *)waitTimeFromNow:(NSTimeInterval)wait {
    NSUInteger seconds = wait;
    NSUInteger hours = seconds / 360;
    seconds %= 360;
    NSUInteger minutes = seconds / 60;
    seconds %= 60;

    NSString *hoursUnit = hours != 1 ? DSLocalizedString(@"hours", nil) : DSLocalizedString(@"hour", nil);
    NSString *minutesUnit = minutes != 1 ? DSLocalizedString(@"minutes", nil) : DSLocalizedString(@"minute", nil);
    NSString *secondsUnit = seconds != 1 ? DSLocalizedString(@"seconds", nil) : DSLocalizedString(@"second", nil);
    NSMutableString *tryAgainTime = [@"" mutableCopy];
    if (hours) {
        [tryAgainTime appendString:[NSString stringWithFormat:@"%ld %@", (unsigned long)hours, hoursUnit]];
        if (minutes && seconds) {
            [tryAgainTime appendString:DSLocalizedString(@", ", nil)];
        }
        else if (minutes || seconds) {
            [tryAgainTime appendString:DSLocalizedString(@" and ", nil)];
        }
    }
    if (minutes) {
        [tryAgainTime appendString:[NSString stringWithFormat:@"%ld %@", (unsigned long)minutes, minutesUnit]];
        if (seconds) {
            [tryAgainTime appendString:DSLocalizedString(@" and ", nil)];
        }
    }
    if (seconds) {
        [tryAgainTime appendString:[NSString stringWithFormat:@"%ld %@", (unsigned long)seconds, secondsUnit]];
    }
    return [NSString stringWithString:tryAgainTime];
}

@end
