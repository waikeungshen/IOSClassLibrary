//
//  Util.m
//  ClassLibrary
//
//  Created by waikeungshen on 15/4/30.
//  Copyright (c) 2015年 waikeungshen. All rights reserved.
//

#import "Util.h"
#import "NSObject+Reflect.h"
#import <objc/runtime.h>

@implementation Util

+ (NSDictionary *)getDictionaryFromObject:(id)object :(BOOL (^)(NSString *))property {
    NSArray *propertyKeys = [object propertyKeys]; // 属性名数组
    NSMutableArray *propertyArray = [NSMutableArray array];
    NSMutableArray *valueArray = [NSMutableArray array];
    
    for (NSString *key in propertyKeys) {
        if (!property(key)) {
            continue;
        }
        id value = [object objectForKey:key];
        [propertyArray addObject:key];
        if (value == nil) {
            [valueArray addObject:[NSNull null]];
        } else {
            [valueArray addObject:value];
        }
    }
    
    NSDictionary *returnDic = [NSDictionary dictionaryWithObjects:valueArray forKeys:propertyArray];
    
    return returnDic;
}

+ (BOOL)isRetinaScreen {
    CGSize screenSize = [[UIScreen mainScreen] currentMode].size;
    if ((screenSize.width >= 639.9f) && (fabs(screenSize.height >= 959.9f))) {
        return YES;
    }
    return NO;
}

+ (NSString *)currentSystemVersion {
    CGFloat versionNumber = 0.f;
    NSString *version = [UIDevice currentDevice].systemVersion;
    if (version) {
        versionNumber = [version floatValue];
    }
    return [NSString stringWithFormat:@"%.1f", versionNumber];
}

//+ (BOOL)versionIsLowerThan:(CGFloat *)targerVersion {
//    CGFloat versionNumber = 0.f;
//    NSString *version = [UIDevice currentDevice].systemVersion;
//    if (version) {
//        versionNumber = [version floatValue];
//    }
//
//    return (versionNumber <= targerVersion) ? YES : NO;
//}

+ (NSInteger)getStringLength:(NSString *)string {
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData *da = [string dataUsingEncoding:enc];
    return [da length];
}

+ (CGFloat)fitLabelHeight:(UILabel *)label {
    label.numberOfLines = 0;
    CGSize size = [label sizeThatFits:CGSizeMake(label.frame.size.width, 0)];
    [label.text sizeWithFont:label.font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    
    CGRect frame = label.frame;
    frame.size.height =size.height;
    label.frame = frame;
    
    return label.frame.size.height;
}

+ (CGFloat)fitLabelWidth:(UILabel *)label {
    label.numberOfLines = 0;
    CGSize size = [label sizeThatFits:CGSizeMake(0, label.frame.size.height)];
    [label.text sizeWithFont:label.font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    
    CGRect frame = label.frame;
    frame.size.width = size.width;
    label.frame = frame;
    
    return label.frame.size.width;
}

+ (int)getWordCount:(NSString *)string {
    int i, n=[string length], l = 0, a = 0, b = 0;
    unichar c;
    for (i = 0; i < n; i++) {
        c = [string characterAtIndex:i];
        if (isblank(c)) {
            b++;
        } else if (isascii(c)) {
            a++;
        } else {
            l++;
        }
    }
    if (a ==0 && l == 0) {
        return 0;
    }
    return l+(int)ceilf((float)(a+b)/2.0);
}

+ (BOOL)stringIsEmpty:(NSString *)string {
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    NSString *text = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([text length] == 0) {
        return YES;
    }
    return NO;
}

+ (BOOL)arrayIsEmpty:(NSArray *)array {
    if ([array isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([array count] == 0 || array == nil) {
        return YES;
    }
    return NO;
}

+ (BOOL)dictionaryIsEmpty:(NSDictionary *)dicionary {
    if ([dicionary isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([dicionary count] == 0 || dicionary == nil) {
        return YES;
    }
    return NO;
}

+ (NSString *)trimString:(NSString *)string {
    if (![self stringIsEmpty:string]) {
        NSString *text = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        return text;
    }
    return string;
}

+ (BOOL)validateEmail:(NSString *)email {
    if((0 != [email rangeOfString:@"@"].length) &&
       (0 != [email rangeOfString:@"."].length)) {
        
        NSCharacterSet* tmpInvalidCharSet = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
        NSMutableCharacterSet* tmpInvalidMutableCharSet = [tmpInvalidCharSet mutableCopy];
        [tmpInvalidMutableCharSet removeCharactersInString:@"_-"];
        
        //使用compare option 来设定比较规则，如
        //NSCaseInsensitiveSearch是不区分大小写
        //NSLiteralSearch 进行完全比较,区分大小写
        //NSNumericSearch 只比较定符串的个数，而不比较字符串的字面值
        NSRange range1 = [email rangeOfString:@"@"
                                      options:NSCaseInsensitiveSearch];
        
        //取得用户名部分
        NSString* userNameString = [email substringToIndex:range1.location];
        NSArray* userNameArray   = [userNameString componentsSeparatedByString:@"."];
        
        for(NSString* string in userNameArray){
            NSRange rangeOfInavlidChars = [string rangeOfCharacterFromSet: tmpInvalidMutableCharSet];
            if(rangeOfInavlidChars.length != 0 || [string isEqualToString:@""])
                return NO;
        }
        
        NSString *domainString = [email substringFromIndex:range1.location+1];
        NSArray *domainArray   = [domainString componentsSeparatedByString:@"."];
        
        for(NSString *string in domainArray){
            NSRange rangeOfInavlidChars=[string rangeOfCharacterFromSet:tmpInvalidMutableCharSet];
            if(rangeOfInavlidChars.length !=0 || [string isEqualToString:@""])
                return NO;
        }
        
        return YES;
    }
    else // no ''@'' or ''.'' present
        return NO;
}

+ (BOOL)validateMobile:(NSString *)mobile {
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     * 中国联通：China Unicom
     * 130,131,132,152,155,156,185,186
     */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     * 中国电信：China Telecom
     * 133,1349,153,180,189
     */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     * 大陆地区固话及小灵通
     * 区号：010,020,021,022,023,024,025,027,028,029
     * 号码：七位或八位
     */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobile] == YES)
        || ([regextestcm evaluateWithObject:mobile] == YES)
        || ([regextestct evaluateWithObject:mobile] == YES)
        || ([regextestcu evaluateWithObject:mobile] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

+ (NSString *)getDocumentFilePath:(NSString *)filename {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:filename];
}

#pragma mark - 键盘

- (void)hideKeyWindow {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

#pragma mark - 界面

- (UIViewController *)getViewControllerFromStoryboard:(NSString *)storyboard SceneName:(NSString *)sceneName {
    UIStoryboard *storyboard1 = [UIStoryboard storyboardWithName:storyboard bundle:[NSBundle mainBundle]];
    return [storyboard1 instantiateViewControllerWithIdentifier:sceneName];
}

#pragma mark - tableviewcell 操作

- (void)registerTableViewCellForXib:(NSString *)xib Identifier:(NSString *)identifier TableView:(UITableView *)tableview {
    UINib *nib = [UINib nibWithNibName:xib bundle:nil];
    [tableview registerNib:nib forCellReuseIdentifier:identifier];
}

- (UITableViewCell *)getTableViewCellByIdentifier:(NSString *)identifier TableView:(UITableView *)tableview IndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (indexPath != nil) {
        cell = [tableview dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    } else {
        cell = [tableview dequeueReusableCellWithIdentifier:identifier];
    }
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

#pragma mark - collectioncell 操作

- (void)registerCollectionCellForXib:(NSString *)xib Identifier:(NSString *)identifier CollectionView:(UICollectionView *)collectionView {
    UINib *nib = [UINib nibWithNibName:xib bundle:nil];
    [collectionView registerNib:nib forCellWithReuseIdentifier:identifier];
}

- (UICollectionViewCell *)getCollectionCellByIdentifier:(NSString *)identifier CollectionView:(UICollectionView *)collectionView IndexPath:(NSIndexPath *)indexPath {
    return [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
}

#pragma mark - xib 操作

- (id)getViewFromXib:(NSString *)xib Index:(NSInteger)index {
    NSArray *viewArray = [[NSBundle mainBundle] loadNibNamed:xib owner:nil options:nil];
    return [viewArray objectAtIndex:index];
}

#pragma mark - 系统短信电话功能

- (void)callMobile:(NSString *)mobile {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", mobile]]];
}

- (void)sendMessageToMobile:(NSString *)mobile {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"sms://%@", mobile]]];
}
@end
