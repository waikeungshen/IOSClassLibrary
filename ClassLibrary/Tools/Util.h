//
//  Util.h
//  ClassLibrary
//
//  Created by waikeungshen on 15/4/30.
//  Copyright (c) 2015年 waikeungshen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface Util : NSObject

/**
 *  得到单例
 *
 *  @return 单例的对象
 */
+ (id)getInstance;

#pragma mark - 设备

/**
 *  将object中的属性与属性值转换为字典
 *
 *  @param object   对象
 *  @param property block, 返回YES表示该属性值加入字典中
 *
 *  @return 包含属性与属性值的字典
 */
- (NSDictionary *)getDictionaryFromObject:(id) object :(BOOL (^)(NSString *))property;

/**
 *  判断屏幕是否为Retain屏幕
 *
 *  @return YES为真，NO为否
 */
- (BOOL) isRetinaScreen;

/**
 *  获取设备版本
 *
 *  @return 版本号
 */
- (NSString *)currentSystemVersion;

#pragma mark - label 字符串

/**
 *  获取字符串长度
 *
 *  @param string 字符串
 *
 *  @return 字符串长度
 */
- (NSInteger)getStringLength:(NSString *)string;

/**
 *  根据label文字自适应label的高度
 *
 *  @param label 要自适应的label
 *
 *  @return 自适应后label的高度
 */
- (CGFloat)fitLabelHeight:(UILabel *)label;

/**
 *  根据label文字自适应label的宽度
 *
 *  @param label 要自适应的label
 *
 *  @return 自适应后label的宽度
 */
- (CGFloat)fitLabelWidth:(UILabel *)label;

/**
 *  获取字符串的字符长度
 *
 *  @param string 字符串
 *
 *  @return 字符长度
 */
- (int)getWordCount:(NSString *)string;

/**
 *  判断字符串是否为空
 *
 *  @param string 字符串
 *
 *  @return 空为YES，不空为NO
 */
- (BOOL)stringIsEmpty:(NSString *)string;

/**
 *  判断数组是否为空（包括nil，数组count为0）
 *
 *  @param array 数组
 *
 *  @return 空为YES，不空为NO
 */
- (BOOL)arrayIsEmpty:(NSArray *)array;

/**
 *  判断字典是否为空（包括nil，数组count为0）
 *
 *  @param dicionary 字段
 *
 *  @return 空为YES，不空为NO
 */
- (BOOL)dictionaryIsEmpty:(NSDictionary *)dicionary;

/**
 *  去掉字符串中的空格
 *
 *  @param string 字符串
 *
 *  @return 去掉空格的字符串
 */
- (NSString *)trimString:(NSString *)string;

#pragma mark - 验证

/**
 *  验证字符串是否为邮箱
 *
 *  @param string 邮箱字符串
 *
 *  @return YES为合法，NO为不合法
 */
- (BOOL)validateEmail:(NSString *)email;

/**
 *  验证字符串是否为合法的手机号
 *
 *  @param mobile 手机号字符串
 *
 *  @return YES为合法，NO为不合法
 */
- (BOOL)validateMobile:(NSString *)mobile;

/**
 *  验证银行卡号的合法性
 *
 *  @param bankCardNumber 银行卡号字符串
 *
 *  @return YES表示合法，NO表示非法
 */
- (BOOL)validateBankCardNumber:(NSString *)bankCardNumber;

#pragma mark - 存取
/**
 *  获取文件在document的路径
 *
 *  @param filename 文件名
 *
 *  @return 路径
 */
- (NSString *)getDocumentFilePath:(NSString *)filename;


#pragma mark - 键盘
/**
 *  隐藏键盘
 */
- (void)hideKeyWindow;

#pragma mark - 界面

/**
 *  从storyboard中根据secenename获取UIViewController
 *
 *  @param storyboard storyboard name
 *  @param sceneName secene name
 *
 *  @return 得到的UIViewController
 */
- (UIViewController *)getViewControllerFromStoryboard:(NSString *)storyboard SceneName:(NSString *)sceneName;


#pragma mark - tableviewcell 操作

/**
 *  在tableview注册自定义的tableviewcell
 *
 *  @param xib        xib文件名
 *  @param identifier 标示字符串
 *  @param tableview  tableview
 */
- (void)registerTableViewCellForXib:(NSString *)xib Identifier:(NSString *)identifier TableView:(UITableView *)tableview;

/**
 *  根据identifier获取tableviewcell，indexpath为nil是arc模式，indexpath不为nil实mrc模式
 *
 *  @param identifier 标示字符串
 *  @param tableview  tableview
 *  @param indexPath  indexpath
 *
 *  @return 获取到的tableviewcell
 */
- (UITableViewCell *)getTableViewCellByIdentifier:(NSString *)identifier TableView:(UITableView *)tableview IndexPath:(NSIndexPath *)indexPath;

#pragma mark - collectioncell 操作

/**
 *  在collectionview注册自定义的collectioncell
 *
 *  @param xib            xib文件名
 *  @param identifier     标示字符串
 *  @param collectionView collectionview
 */
- (void)registerCollectionCellForXib:(NSString *)xib Identifier:(NSString *)identifier CollectionView:(UICollectionView *)collectionView;

/**
 *  根据identifier获取collectioncell
 *
 *  @param identifier     标示字符串
 *  @param collectionView collectionView
 *  @param indexPath      indexPath
 *
 *  @return <#return value description#>
 */
- (UICollectionViewCell *)getCollectionCellByIdentifier:(NSString *)identifier CollectionView:(UICollectionView *)collectionView IndexPath:(NSIndexPath *)indexPath;

#pragma mark - xib 操作

/**
 *  创建xib，获取index索引视图
 *
 *  @param xib   xib 文件
 *  @param index 索引
 *
 *  @return 视图
 */
- (id) getViewFromXib:(NSString *)xib Index:(NSInteger)index;

#pragma mark - 系统短信电话功能

/**
 *  打电话
 *
 *  @param mobile 电话号码
 */
- (void)callMobile:(NSString *)mobile;

/**
 *  发短信
 *
 *  @param mobile 电话号码
 */
- (void)sendMessageToMobile:(NSString *)mobile;

#pragma mark - View 相关
/**
 *  给view截屏
 *
 *  @param view 需要截屏的view
 *
 *  @return 截取后获得的图像
 */
- (UIImage *)getImageFromView:(UIView *)view;

#pragma mark - 时间相关
/**
 *  获取自1970年到现在的秒数
 *
 *  @return 秒数
 */
- (NSInteger)getCurrentSec;

/**
 *  获取自1970年到现在的毫秒数
 *
 *  @return 毫秒数
 */
- (long long)getCurrentMsec;

//获取某月最大天数
/**
 *  获取某月最大天数
 *
 *  @param year  年份
 *  @param month 月份
 *
 *  @return 天数
 */
- (NSInteger)getMaxDayForYear:(NSInteger)year Month:(NSInteger)month;

/**
 *  根据生日秒数获取生日日期
 *
 *  @param time 秒数
 *
 *  @return 生日日期
 */
- (NSString*)getBirthStrFromSecs:(NSInteger)time;

/**
 *  根据生日获取年龄
 *
 *  @param birth 生日 yyyy-mm-dd
 *
 *  @return 年龄
 */
- (NSInteger)getAgeFromBirth:(NSString*)birth;

/**
 *  根据秒数获取年龄
 *
 *  @param time 秒数
 *
 *  @return 年龄
 */
- (NSInteger)getAgeFromBirthSecs:(NSInteger)time;

/**
 *  获取当前的日期对象
 *
 *  @return 日期对象
 */
- (NSDateComponents*)getCurrentDateComponent;

/**
 *  获取指定日期的日期对象
 *
 *  @param date 指定日期
 *
 *  @return 日期对象
 */
- (NSDateComponents*)getDateComponentFromDate:(NSDate*)date;

/**
 *  通过字符串获取日期对象
 *
 *  @param dateStr 字符串日期
 *
 *  @return 日期对象
 */
- (NSDate*)getDateComponentFromString:(NSString*)dateStr;

/**
 *  获取指定参数的nsdate对象
 *
 *  @param year  年
 *  @param month 月
 *  @param day   日
 *  @param hour  时
 *  @param min   分
 *  @param sec   秒
 *
 *  @return NSDate 对象
 */
- (NSDate*)getDateFromYear:(NSInteger)year Month:(NSInteger)month Day:(NSInteger)day Hour:(NSInteger)hour Min:(NSInteger)min Sec:(NSInteger)sec;

/**
 *  根据秒数获取日期对象
 *
 *  @param secs 秒数
 *
 *  @return 日期对象
 */
- (NSString*)getDateStringFromSecs:(NSInteger)secs;

/**
 *  获取时间间隔
 *
 *  @param time 时间秒数
 *
 *  @return 间隔
 */
- (NSString*)getTimeSep:(NSInteger)time;

/**
 *  根据秒数获取日期对象
 *
 *  @param time 从1970开始的秒数
 *
 *  @return 日期对象
 */
- (NSDateComponents *)getDateComponentFromSecs:(NSInteger)time;

/**
 *  判断是否是闰年
 *
 *  @param year 年份
 *
 *  @return 是闰年返回YES，否返回NO
 */
- (BOOL)isLeapYear:(NSInteger)year;

/**
 *  得到date之后或之前的日子, 正表示之后，负表示之前
 *
 *  @param date  基准日期
 *  @param year  年
 *  @param month 月
 *  @param day   日
 *
 *  @return 计算之后的日期date
 */
- (NSDate *)getAfterDateFromDate:(NSDate *)date
                        withYear:(NSInteger)year
                       withMonth:(NSInteger)month
                         withDay:(NSInteger)day;
/**
 *  求两个日期差多少天
 *
 *  @param date1 日期1
 *  @param date2 日期2
 *
 *  @return 差的天数
 */
- (NSInteger)getDifferenceFromDate:(NSDate *)date1 toDate:(NSDate *)date2;


#pragma mark - 本地简易存储
/**
 *  保存数据到本地
 *
 *  @param date 需要保持的数据
 *  @param key  关键字
 */
- (void) saveDataToLocal:(id)date key:(NSString *)key;

/**
 *  从本地获取数据
 *
 *  @param key 关键字
 *
 *  @return 获取到的数据
 */
- (id)loadDataFromLocal:(NSString *)key;


#pragma mark - 进制转换
/**
 *  十进制转二进制
 *
 *  @param decimal 十进制数字符串
 *
 *  @return 二进制数字符串
 */
- (NSString *)toBinarySystemWithDecimalSystem:(NSString *)decimal;

/**
 *  二进制转十进制
 *
 *  @param binary 二进制数字符串
 *
 *  @return 十进制数字符串
 */
- (NSString *)toDecimalSystemWithBinarySystem:(NSString *)binary;

#pragma mark - color
/**
 *  将16进制值转换为UIColor
 *
 *  @param hexValue   16进制值
 *  @param alphaValue 透明度
 *
 *  @return UIColor
 */
- (UIColor *) colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue;
/**
 *  将16进制值转换为 UIColor
 *
 *  @param hexValue 16进制值
 *
 *  @return UIColor
 */
- (UIColor *) colorWithHex:(NSInteger)hexValue;

/**
 *  将UIColor转换为相应的16进制值
 *
 *  @param color UIColor
 *
 *  @return 16进制值
 */
- (NSString *) hexFromUIColor: (UIColor *) color;

@end
