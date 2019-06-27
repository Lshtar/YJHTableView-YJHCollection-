//
//  InputViewController.m
//  YJHTableView(YJHCollection)
//
//  Created by D on 2019/5/7.
//  Copyright © 2019 D. All rights reserved.
//

#import "InputViewController.h"

@interface InputViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *textField;

@end

@implementation InputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"键盘输入限制";
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledEditChanged:)
                                                name:UITextFieldTextDidChangeNotification object:self.textField];
    

    self.view.backgroundColor = [UIColor whiteColor];
    
    //键盘输入限制
    [self setupkeyBoardInput];
}

- (void) setupkeyBoardInput
{
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(100, 200, 200, 300)];
    self.textField.backgroundColor = [UIColor cyanColor];
    self.textField.delegate = self;
    [self.view addSubview:self.textField];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    //过滤非汉字字符
    textField.text = [self filterCharactor:textField.text withRegex:@"[^\u4e00-\u9fa5]"];
    
    //    if (textField.text.length >= 4) {
    //        textField.text = [textField.text substringToIndex:4];
    //
    //    }
    return NO;
}

- (void)textFiledEditChanged:(id)notification{
    
    UITextRange *selectedRange = self.textField.markedTextRange;
    UITextPosition *position = [self.textField positionFromPosition:selectedRange.start offset:0];
    
    if (!position) { //// 没有高亮选择的字
        //过滤非汉字字符
        self.textField.text = [self filterCharactor:self.textField.text withRegex:@"[^\u4e00-\u9fa5]"];
        [self isEnglishCharacter:self.textField.text];
        
        //        if (self.textField.text.length >= 4) {
        //            self.textField.text = [self.textField.text substringToIndex:4];
        //        }
    }else { //有高亮文字
        //do nothing
    }
}

//根据正则，过滤特殊字符
- (NSString *)filterCharactor:(NSString *)string withRegex:(NSString *)regexStr{
    NSString *searchText = string;
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexStr options:NSRegularExpressionCaseInsensitive error:&error];
    NSString *result = [regex stringByReplacingMatchesInString:searchText options:NSMatchingReportCompletion range:NSMakeRange(0, searchText.length) withTemplate:@""];
    return result;
}
// 严格限制输入中文。中文unicode码的范围是4E00-9FEA ，共20970个汉字。
- (BOOL)isChineseCharacter:(NSString*)source {
    
    NSString *regex = @"^[\\u4E00-\\u9FEA]+$";
    
    return ([source rangeOfString:regex options:NSRegularExpressionSearch].length>0);
    
}

// 严格限制输入英文字母 英文unicode码的范围是 0041-005A（大写字母）和 0061-007A（小写字母）
- (BOOL)isEnglishCharacter:(NSString*)source {
    
    NSString *upperRegex = @"^[\\u0041-\\u005A]+$";
    
    NSString *lowerRegex = @"^[\\u0061-\\u007A]+$";
    
    BOOL isEnglish = (([source rangeOfString:upperRegex options:NSRegularExpressionSearch].length<=0) || ([source rangeOfString:lowerRegex options:NSRegularExpressionSearch].length<=0));
    
    return isEnglish;
    
}
//严格限制输入数字。数字的unicode范围是 0030-0039
- (BOOL)isNumber:(NSString*)source {
    
    NSString *regex = @"^[\\u0030-\\u0039]+$";
    
    return ([source rangeOfString:regex options:NSRegularExpressionSearch].length>0);
    
}
//限制输入Emoji
- (BOOL)stringContainsEmoji:(NSString*)source {
    
    __block BOOL returnValue =NO;
    [source enumerateSubstringsInRange:NSMakeRange(0, [source length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
        const unichar hs = [substring characterAtIndex:0];
        
        if(0xd800 <= hs && hs <=0xdbff) {
            
            if(substring.length>1) {
                
                const unichar ls = [substring characterAtIndex:1];
                
                const int uc = ((hs -0xd800) *0x400) + (ls -0xdc00) +0x10000;
                
                if(0x1d000<= uc && uc <=0x1f77f) {
                    
                    returnValue =YES;
                    
                }
                
            }
            
        }else if(substring.length>1) {
            
            const unichar ls = [substring characterAtIndex:1];
            
            if(ls ==0x20e3) {
                
                returnValue =YES;
                
            }
            
        }else{
            
            if(0x2100<= hs && hs <=0x27ff) {
                
                returnValue =YES;
                
            }else if(0x2B05<= hs && hs <=0x2b07) {
                
                returnValue =YES;
                
            }else if(0x2934<= hs && hs <=0x2935) {
                
                returnValue =YES;
                
            }else if(0x3297<= hs && hs <=0x3299) {
                
                returnValue =YES;
                
            }else if(hs ==0xa9|| hs ==0xae|| hs ==0x303d|| hs ==0x3030|| hs ==0x2b55|| hs ==0x2b1c|| hs ==0x2b1b|| hs ==0x2b50) {
                
                returnValue =YES;
                
            }
            
        }
        
        
    }];

    return returnValue;
    
}

//全角转半角
- (NSString *)replaceSpecialWhitespace{
    NSMutableString *convertedString = [self mutableCopy];
    CFStringTransform((CFMutableStringRef)convertedString, NULL, kCFStringTransformFullwidthHalfwidth, false);
    return [NSString stringWithString:convertedString];
}
//半角转全角
- (NSString *)replaceNormalWhiteSpace{
    NSMutableString *convertedString = [self mutableCopy];
    CFStringTransform((CFMutableStringRef)convertedString, NULL, kCFStringTransformHiraganaKatakana, false);
    return [NSString stringWithString:convertedString];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
