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
#import "Common.h"

@implementation Util

+ (id)getInstance {
    __strong static Util *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[Util alloc] init];
    });
    return instance;
}

- (NSDictionary *)getDictionaryFromObject:(id)object :(BOOL (^)(NSString *))property {
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

- (BOOL)isRetinaScreen {
    CGSize screenSize = [[UIScreen mainScreen] currentMode].size;
    if ((screenSize.width >= 639.9f) && (fabs(screenSize.height >= 959.9f))) {
        return YES;
    }
    return NO;
}

- (NSString *)currentSystemVersion {
    CGFloat versionNumber = 0.f;
    NSString *version = [UIDevice currentDevice].systemVersion;
    if (version) {
        versionNumber = [version floatValue];
    }
    return [NSString stringWithFormat:@"%.1f", versionNumber];
}

- (NSInteger)getStringLength:(NSString *)string {
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData *da = [string dataUsingEncoding:enc];
    return [da length];
}

- (CGFloat)fitLabelHeight:(UILabel *)label {
    label.numberOfLines = 0;
    CGSize size = [label sizeThatFits:CGSizeMake(label.frame.size.width, 0)];
    [label.text sizeWithFont:label.font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    
    CGRect frame = label.frame;
    frame.size.height =size.height;
    label.frame = frame;
    
    return label.frame.size.height;
}

- (CGFloat)fitLabelWidth:(UILabel *)label {
    label.numberOfLines = 0;
    CGSize size = [label sizeThatFits:CGSizeMake(0, label.frame.size.height)];
    [label.text sizeWithFont:label.font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    
    CGRect frame = label.frame;
    frame.size.width = size.width;
    label.frame = frame;
    
    return label.frame.size.width;
}

- (int)getWordCount:(NSString *)string {
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

- (BOOL)stringIsEmpty:(NSString *)string {
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    NSString *text = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([text length] == 0) {
        return YES;
    }
    return NO;
}

- (BOOL)arrayIsEmpty:(NSArray *)array {
    if ([array isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([array count] == 0 || array == nil) {
        return YES;
    }
    return NO;
}

- (BOOL)dictionaryIsEmpty:(NSDictionary *)dicionary {
    if ([dicionary isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([dicionary count] == 0 || dicionary == nil) {
        return YES;
    }
    return NO;
}

- (NSString *)trimString:(NSString *)string {
    if (![self stringIsEmpty:string]) {
        NSString *text = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        return text;
    }
    return string;
}

- (BOOL)validateEmail:(NSString *)email {
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

- (BOOL)validateMobile:(NSString *)mobile {
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

- (BOOL)validateBankCardNumber:(NSString *)bankCardNumber {
    BOOL flag;
    if (bankCardNumber.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{15,30})";
    NSPredicate *bankCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [bankCardPredicate evaluateWithObject:bankCardNumber];
}

- (NSString *)getDocumentFilePath:(NSString *)filename {
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

#pragma mark - View 相关

- (UIImage *)getImageFromView:(UIView *)view {
    // 创建一个基于位图的图形上下文并指定大小为view.bounds.size
    UIGraphicsBeginImageContext(view.bounds.size);
    //renderInContext 呈现接受者及其子范围到指定的上下文
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    // 返回一个基于当前图形上下文的图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // 移除栈顶的基于当前位图的图形上下文
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - 时间相关
//获取当前时间秒数
- (NSInteger)getCurrentSec {
    NSDate* now = [NSDate date];
    return [now timeIntervalSince1970];
}

//获取当前时间毫秒数
- (long long)getCurrentMsec {
    NSDate* now = [NSDate date];
    NSLog(@"time %.f", [now timeIntervalSince1970]*1000);
    return [now timeIntervalSince1970]*1000;
}

//获取某月最大天数
- (NSInteger)getMaxDayForYear:(NSInteger)year Month:(NSInteger)month {
    
    NSString* date = [NSString stringWithFormat:@"%.4ld-%.2ld-01",(NSUInteger)year, (NSUInteger)month];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *today = [formatter dateFromString:date];
    NSCalendar *c = [NSCalendar currentCalendar];
    NSRange days = [c rangeOfUnit:NSDayCalendarUnit
                           inUnit:NSMonthCalendarUnit
                          forDate:today];
    
    return days.length;
}

//根据生日秒数获取生日日期
- (NSString*)getBirthStrFromSecs:(NSInteger)time {
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateComponents* comps = [[Util getInstance] getDateComponentFromDate:date];
    NSInteger year = [comps year];
    NSInteger month = [comps month];
    NSInteger day = [comps day];
    return [NSString stringWithFormat:@"%.4ld-%.2ld-%.2ld", year, month, day];
}

//根据生日获取年龄yyyy-mm-dd
- (NSInteger)getAgeFromBirth:(NSString*)birth {
    NSArray* array = [birth componentsSeparatedByString:@"-"];
    NSInteger age = 20;
    if(array != nil && [array count] == 3) {
        NSInteger year = [array[0] integerValue];
        NSInteger month = [array[1] integerValue];
        NSInteger day = [array[2] integerValue];
        NSDate *date = [NSDate date];
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        NSInteger unitFlags = NSYearCalendarUnit |
        NSMonthCalendarUnit |
        NSDayCalendarUnit;
        
        comps = [calendar components:unitFlags fromDate:date];
        NSInteger year1 = [comps year];
        NSInteger month1 = [comps month];
        NSInteger day1 = [comps day];
        
        age = year1 - year;
        if(month1 < month || (month1 == month && day1 <= day)) {
            age --;
        }
    }
    return age;
}

//根据秒数获取年龄
- (NSInteger)getAgeFromBirthSecs:(NSInteger)time {
    NSInteger age = 20;
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateComponents* comps = [[Util getInstance] getDateComponentFromDate:date];
    NSInteger year = [comps year];
    NSInteger month = [comps month];
    NSInteger day = [comps day];
    NSDateComponents *comps1 = [self getCurrentDateComponent];
    NSInteger year1 = [comps1 year];
    NSInteger month1 = [comps1 month];
    NSInteger day1 = [comps1 day];
    
    age = year1 - year;
    if(month1 < month || (month1 == month && day1 <= day)) {
        age --;
    }
    
    return age;
}

//获取当前日期对象
- (NSDateComponents*)getCurrentDateComponent {
    NSDate* now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    return [calendar components:unitFlags fromDate:now];
}

//获取指定日期的日期对象
- (NSDateComponents*)getDateComponentFromDate:(NSDate*)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    return [calendar components:unitFlags fromDate:date];
}

//通过字符串获取日期对象
- (NSDate*)getDateComponentFromString:(NSString*)dateStr {
    if(IS_EMPTY(dateStr)) {
        return nil;
    }
    NSArray* array = [dateStr componentsSeparatedByString:@"-"];
    if(array == nil || [array count] != 3) {
        return nil;
    }
    NSInteger year = [[array objectAtIndex:0] integerValue];
    NSInteger month = [[array objectAtIndex:1] integerValue];
    NSInteger day = [[array objectAtIndex:2] integerValue];
    return [[Util getInstance] getDateFromYear:year Month:month Day:day Hour:0 Min:0 Sec:0];
}

//获取指定参数的nsdate对象
- (NSDate*)getDateFromYear:(NSInteger)year Month:(NSInteger)month Day:(NSInteger)day Hour:(NSInteger)hour Min:(NSInteger)min Sec:(NSInteger)sec {
    NSDateComponents* components = [[NSDateComponents alloc] init];
    [components setYear:year];
    [components setMonth:month];
    [components setDay:day];
    [components setHour:hour];
    [components setMinute:min];
    [components setSecond:sec];
    NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    return [calendar dateFromComponents:components];
}

//根据秒数获取日期对象
- (NSString*)getDateStringFromSecs:(NSInteger)secs {
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:secs];
    NSDateComponents* components = [[Util getInstance] getDateComponentFromDate:date];
    return [NSString stringWithFormat:@"%.4ld-%.2ld-%.2ld %.2ld:%.2ld:%.2ld", [components year], [components month], [components day], [components hour], [components minute], [components second]];
}

//获取时间间隔
- (NSString*)getTimeSep:(NSInteger)time {
    NSDate *dateOld = [NSDate dateWithTimeIntervalSince1970:time];
    time = [dateOld timeIntervalSinceNow];
    if(time < 0) {
        time = -time;
    }
    NSInteger utime = (NSInteger)time;
    
    if(utime < 60) {
        return @"刚刚";
    }
    else if (utime < 3600) {
        return [NSString stringWithFormat:@"%ld分钟前", utime/60];
    }
    else if (utime < 86400) {
        return [NSString stringWithFormat:@"%ld小时前", utime/3600];
    }
    else if(utime/86400 > 7) {
        return @"7天前";
    }
    return [NSString stringWithFormat:@"%ld天前", utime/86400];
}

- (NSDateComponents *)getDateComponentFromSecs:(NSInteger)time {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    return [self getDateComponentFromDate:date];
}

/**
 *  判断年份是否是闰年
 *
 *  @param year 年份
 *
 *  @return 闰年返回YES
 */
- (BOOL)isLeapYear:(NSInteger)year {
    if(((year%4==0) && (year%100!=0)) || (year%400==0))  {
        return YES;
    } else {
        return NO;
    }
}

- (NSDate *)getAfterDateFromDate:(NSDate *)date withYear:(NSInteger)year withMonth:(NSInteger)month withDay:(NSInteger)day {
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setYear:year];
    [comps setMonth:month];
    [comps setDay:day];
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *mDate = [calender dateByAddingComponents:comps toDate:date options:0];
    return mDate;
}

- (NSInteger)getDifferenceFromDate:(NSDate *)date1 toDate:(NSDate *)date2 {
    //得到相差秒数
    NSTimeInterval time = [date2 timeIntervalSinceDate:date1];
    int days = ((int)time)/(3600*24);
    return days;
}

#pragma mark - 本地简易存储

- (void) saveDataToLocal:(id)date key:(NSString *)key {
    NSUserDefaults *nsuser = [NSUserDefaults standardUserDefaults];
    NSData *nsdata = [NSKeyedArchiver archivedDataWithRootObject:date];
    [nsuser setObject:nsdata forKey:key];
    [nsuser synchronize];
}

- (id)loadDataFromLocal:(NSString *)key {
    NSUserDefaults *nsuser = [NSUserDefaults standardUserDefaults];
    NSData *nsdata = [nsuser objectForKey:key];
    if (nsdata == nil) {
        return nil;
    }
    return [NSKeyedUnarchiver unarchiveObjectWithData:nsdata];
}

#pragma mark - 进制转换

- (NSString *)toBinarySystemWithDecimalSystem:(NSString *)decimal {
    //int num = [decimal intValue];
    long long num = [decimal longLongValue];
    int remainder = 0;      //余数
    long long divisor = 0;        //除数
    
    NSString * prepare = @"";
    
    while (true)
    {
        remainder = num%2;
        divisor = num/2;
        num = divisor;
        prepare = [prepare stringByAppendingFormat:@"%d",remainder];
        
        if (divisor == 0)
        {
            break;
        }
    }
    
    NSString * result = @"";
    for (int i = (int)prepare.length - 1; i >= 0; i --)
    {
        result = [result stringByAppendingFormat:@"%@",
                  [prepare substringWithRange:NSMakeRange(i , 1)]];
    }
    
    return result;
}

- (NSString *)toDecimalSystemWithBinarySystem:(NSString *)binary {
    long ll = 0 ;
    long  temp = 0 ;
    for (int i = 0; i < binary.length; i++)
    {
        temp = [[binary substringWithRange:NSMakeRange(i, 1)] intValue];
        temp = temp * powf(2, binary.length - i - 1);
        ll += temp;
    }
    
    NSString * result = [NSString stringWithFormat:@"%ld",ll];
    
    return result;
}

- (UIColor *) colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue {
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0
                           green:((float)((hexValue & 0xFF00) >> 8))/255.0
                            blue:((float)(hexValue & 0xFF))/255.0 alpha:alphaValue];
}

- (UIColor *) colorWithHex:(NSInteger)hexValue {
    //return [UIColor colorWithHex:hexValue alpha:1.0];
    return [self colorWithHex:hexValue alpha:1.0];
}

- (NSString *) hexFromUIColor: (UIColor *) color {
    if (CGColorGetNumberOfComponents(color.CGColor) < 4) {
        const CGFloat *components = CGColorGetComponents(color.CGColor);
        color = [UIColor colorWithRed:components[0]
                                green:components[0]
                                 blue:components[0]
                                alpha:components[1]];
    }
    
    if (CGColorSpaceGetModel(CGColorGetColorSpace(color.CGColor)) != kCGColorSpaceModelRGB) {
        return [NSString stringWithFormat:@"#FFFFFF"];
    }
    
    return [NSString stringWithFormat:@"#%x%x%x", (int)((CGColorGetComponents(color.CGColor))[0]*255.0),
            (int)((CGColorGetComponents(color.CGColor))[1]*255.0),
            (int)((CGColorGetComponents(color.CGColor))[2]*255.0)];
}
@end
