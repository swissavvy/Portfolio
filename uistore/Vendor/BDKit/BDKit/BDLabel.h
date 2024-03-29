//
//  RTLabel.h
//  RTLabelProject
//
/**
 * Copyright (c) 2010 Muh Hon Cheng
 * Created by honcheng on 1/6/11.
 * 
 * Permission is hereby granted, free of charge, to any person obtaining 
 * a copy of this software and associated documentation files (the 
 * "Software"), to deal in the Software without restriction, including 
 * without limitation the rights to use, copy, modify, merge, publish, 
 * distribute, sublicense, and/or sell copies of the Software, and to 
 * permit persons to whom the Software is furnished to do so, subject 
 * to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be 
 * included in all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT 
 * WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, 
 * INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR 
 * PURPOSE AND NONINFRINGEMENT. IN NO EVENT 
 * SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE 
 * LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, 
 * TORT OR OTHERWISE, ARISING FROM, OUT OF OR 
 * IN CONNECTION WITH THE SOFTWARE OR 
 * THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 * 
 * @author 		Muh Hon Cheng <honcheng@gmail.com>
 * @copyright	2011	Muh Hon Cheng
 * @version
 * 
 */

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

typedef enum {
	BDTextAlignmentRight = kCTRightTextAlignment,
	BDTextAlignmentLeft = kCTLeftTextAlignment,
	BDTextAlignmentCenter = kCTCenterTextAlignment,
	BDTextAlignmentJustify = kCTJustifiedTextAlignment
} BDTextAlignment;

typedef enum {
	BDTextLineBreakModeWordWrapping = kCTLineBreakByWordWrapping,
	BDTextLineBreakModeCharWrapping = kCTLineBreakByCharWrapping,
	BDTextLineBreakModeClip = kCTLineBreakByClipping,
}BDTextLineBreakMode;

@protocol BDLabelDelegate <NSObject>

- (void)bdLabel:(id)rtLabel didSelectLinkWithURL:(NSURL*)url;

@end

@interface BDLabel : UIView {
	NSString *_text;
	UIFont *font;
	UIColor *textColor;
	BDTextAlignment _textAlignment;
	BDTextLineBreakMode _lineBreakMode;
	NSString *_plainText;
	NSMutableArray *_textComponents;
	CGSize _optimumSize;
	CGFloat _lineSpacing;
	int currentSelectedButtonComponentIndex;
	NSDictionary *linkAttributes;
    NSDictionary *selectedLinkAttributes;
	id<BDLabelDelegate> delegate;
	CTFrameRef frame;
    CFRange visibleRange;
    NSString *paragraphReplacement;
}

@property (nonatomic, retain) UIColor *textColor;
@property (nonatomic, retain) UIFont *font;
@property (nonatomic, retain) NSDictionary *linkAttributes;
@property (nonatomic, retain) NSDictionary *selectedLinkAttributes;
@property (nonatomic, assign) id<BDLabelDelegate> delegate;
@property (nonatomic, copy) NSString *paragraphReplacement;

- (NSString*)text;
- (void)setText:(NSString*)text;

- (void)setTextAlignment:(BDTextAlignment)textAlignment;
- (void)setLineBreakMode:(BDTextLineBreakMode)lineBreakMode;

- (CGSize)optimumSize;
- (void)setLineSpacing:(CGFloat)lineSpacing;
- (NSString*)visibleText;

@end
