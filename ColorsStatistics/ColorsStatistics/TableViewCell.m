//
//  TableViewCell.m
//  ColorsStatistics
//
//  Created by Admin on 18/10/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "TableViewCell.h"
#import "Consts.h"
#import "UIColorHex.h"

@implementation TableViewCell


-(void) setUp
{
    [self.nicheImage.layer setCornerRadius:20.0f];
    [self.nicheStat.layer setCornerRadius: 4.0f];
    for (CALayer *layer in self.nicheStat.layer.sublayers) {
        [layer setCornerRadius:4.0f];
        layer.masksToBounds = YES;
    }
    self.nicheName.lineBreakMode = NSLineBreakByWordWrapping;
    self.nicheName.numberOfLines = 0;
    self.statsLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.statsLabel.numberOfLines = 0;
}

-(void) updateFromData:(NSDictionary *)niche
{
    
    NSNumber *nsNisheId = niche[kNicheId];
    int nicheId = [nsNisheId intValue];
    switch (nicheId)
    
    {
        case vYumor:
            [_nicheImage setImage:[UIImage imageNamed:@"Humor"]];
            [_nicheStat setProgressTintColor:[UIColor colorFromHexString:@"#FCC431"]];
            break;
            
        case vErotica:
            [_nicheImage setImage:[UIImage imageNamed:@"Erotica"]];
            [_nicheStat setProgressTintColor:[UIColor colorFromHexString:@"#ff496f"]];
            break;
            
        case vEsoterica:
            [_nicheImage setImage:[UIImage imageNamed:@"Esoterics"]];
            [_nicheStat setProgressTintColor:[UIColor colorFromHexString:@"#e2825a"]];
            break;
            
        case vFantasy:
            [_nicheImage setImage:[UIImage imageNamed:@"Fantasy"]];
            [_nicheStat setProgressTintColor:[UIColor colorFromHexString:@"#a349c1"]];
            break;
            
        case vFantastika:
            [_nicheImage setImage:[UIImage imageNamed:@"Fantastictales"]];
            [_nicheStat setProgressTintColor:[UIColor colorFromHexString:@"#bf8beb"]];
            break;
            
        default:
            break;
            
    }
    [_nicheName setText:niche[kNicheName]];
    int wishListCount = [niche[kWishListCount] intValue];
    int nowReadingCount = [niche[kWishListCount] intValue];
    int readingCount = [niche[kReadCount] intValue];
    /*float progress = 0;
    if (readingCount > 0) {
        progress = readingCount / 100.0f;
    } else {
        progress = nowReadingCount / 100.0f;
    }*/
    //NSLog(@"pogressView progress before=%f", _nicheStat.progress);
    [_nicheStat setProgress:0.0f];
    //NSLog(@"pogressView progress after=%f", _nicheStat.progress);
    [_nicheStat layoutIfNeeded];
    [_nicheStat setNeedsDisplay];
    NSString *statString = [NSString stringWithFormat:@"хочу прочитать %d читаю %d прочитал %d",
                            wishListCount,
                            nowReadingCount,
                            readingCount];
    NSMutableAttributedString *attString =
     [[NSMutableAttributedString alloc] initWithString:statString];
    int wishListLen = [niche[kWishListCount] stringValue].length;
    int nowReadingLen = [niche[kWishListCount] stringValue].length;
    int readingLen = [niche[kReadCount] stringValue].length;
    [attString addAttribute: NSForegroundColorAttributeName
                      value: [UIColor colorWithRed:1 green:1 blue:1 alpha:0.6]
                      range: NSMakeRange(0,15)];
    
    int start = 15;
    [attString addAttribute: NSFontAttributeName
                      value:  [UIFont fontWithName:@"HelveticaNeue-Bold" size:18]
                      range: NSMakeRange(start,wishListLen)];
    
    start += wishListLen;
    [attString addAttribute: NSForegroundColorAttributeName
                      value: [UIColor colorWithRed:1 green:1 blue:1 alpha:0.6]
                      range: NSMakeRange(start,7)];
    
    start += 7;
    [attString addAttribute: NSFontAttributeName
                      value:  [UIFont fontWithName:@"HelveticaNeue-Bold" size:18]
                      range: NSMakeRange(start,nowReadingLen)];
    
    start += nowReadingLen;
    [attString addAttribute: NSForegroundColorAttributeName
                      value: [UIColor colorWithRed:1 green:1 blue:1 alpha:0.6]
                      range: NSMakeRange(start, 10)];
    start += 10;
    [attString addAttribute: NSFontAttributeName
                      value:  [UIFont fontWithName:@"HelveticaNeue-Bold" size:18]
                      range: NSMakeRange(start, readingLen)];
    
    self.statsLabel.attributedText = attString;
    [super updateFromData:niche];
}

- (void)prepareForReuse
{
    [_nicheStat setProgress:0.0f];
}

@end
