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

#pragma mark - 设备

/**
 *  将object中的属性与属性值转换为字典
 *
 *  @param object   对象
 *  @param property block, 返回YES表示该属性值加入字典中
 *
 *  @return 包含属性与属性值的字典
 */
+ (NSDictionary *)getDictionaryFromObject:(id) object :(BOOL (^)(NSString *))property;

/**
 *  判断屏幕是否为Retain屏幕
 *
 *  @return YES为真，NO为否
 */
+ (BOOL) isRetinaScreen;

/**
 *  获取设备版本
 *
 *  @return 版本号
 */
+ (NSString *)currentSystemVersion;

/**
 *  设备版本比较
 *
 *  @param targerVersion 比较的版本大小
 *
 *  @return YES为小过比较版本，NO反之
 */
//+ (BOOL)versionIsLowerThan:(CGFloat *)targerVersion;

#pragma mark - label 字符串

/**
 *  获取字符串长度
 *
 *  @param string 字符串
 *
 *  @return 字符串长度
 */
+ (NSInteger)getStringLength:(NSString *)string;

/**
 *  根据label文字自适应label的高度
 *
 *  @param label 要自适应的label
 *
 *  @return 自适应后label的高度
 */
+ (CGFloat)fitLabelHeight:(UILabel *)label;

/**
 *  根据label文字自适应label的宽度
 *
 *  @param label 要自适应的label
 *
 *  @return 自适应后label的宽度
 */
+ (CGFloat)fitLabelWidth:(UILabel *)label;

/**
 *  获取字符串的字符长度
 *
 *  @param string 字符串
 *
 *  @return 字符长度
 */
+ (int)getWordCount:(NSString *)string;

/**
 *  判断字符串是否为空
 *
 *  @param string 字符串
 *
 *  @return 空为YES，不空为NO
 */
+ (BOOL)stringIsEmpty:(NSString *)string;

/**
 *  判断数组是否为空（包括nil，数组count为0）
 *
 *  @param array 数组
 *
 *  @return 空为YES，不空为NO
 */
+ (BOOL)arrayIsEmpty:(NSArray *)array;

/**
 *  判断字典是否为空（包括nil，数组count为0）
 *
 *  @param dicionary 字段
 *
 *  @return 空为YES，不空为NO
 */
+ (BOOL)dictionaryIsEmpty:(NSDictionary *)dicionary;

/**
 *  去掉字符串中的空格
 *
 *  @param string 字符串
 *
 *  @return 去掉空格的字符串
 */
+ (NSString *)trimString:(NSString *)string;

#pragma mark - 验证

/**
 *  验证字符串是否为邮箱
 *
 *  @param string 邮箱字符串
 *
 *  @return YES为合法，NO为不合法
 */
+ (BOOL)validateEmail:(NSString *)email;

/**
 *  @brief  验证字符串是否为合法的手机号
 *
 *  @param mobile 手机号字符串
 *
 *  @return YES为合法，NO为不合法
 */
+ (BOOL)validateMobile:(NSString *)mobile;

#pragma mark - 存取
/**
 *  获取文件在document的路径
 *
 *  @param filename 文件名
 *
 *  @return 路径
 */
+ (NSString *)getDocumentFilePath:(NSString *)filename;


#pragma mark - 键盘
/**
 *  @brief  隐藏键盘
 */
- (void)hideKeyWindow;

#pragma mark - 界面

/**
 *  @brief  从storyboard中根据secenename获取UIViewController
 *
 *  @param storyboard storyboard name
 *  @param sceneName secene name
 *
 *  @return 得到的UIViewController
 */
- (UIViewController *)getViewControllerFromStoryboard:(NSString *)storyboard SceneName:(NSString *)sceneName;


#pragma mark - tableviewcell 操作

/**
 *  @brief  在tableview注册自定义的tableviewcell
 *
 *  @param xib        xib文件名
 *  @param identifier 标示字符串
 *  @param tableview  tableview
 */
- (void)registerTableViewCellForXib:(NSString *)xib Identifier:(NSString *)identifier TableView:(UITableView *)tableview;

/**
 *  @brief  根据identifier获取tableviewcell，indexpath为nil是arc模式，indexpath不为nil实mrc模式
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
 *  @brief  在collectionview注册自定义的collectioncell
 *
 *  @param xib            xib文件名
 *  @param identifier     标示字符串
 *  @param collectionView collectionview
 */
- (void)registerCollectionCellForXib:(NSString *)xib Identifier:(NSString *)identifier CollectionView:(UICollectionView *)collectionView;

/**
 *  @brief  根据identifier获取collectioncell
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
 *  @brief  创建xib，获取index索引视图
 *
 *  @param xib   xib 文件
 *  @param index 索引
 *
 *  @return 视图
 */
- (id) getViewFromXib:(NSString *)xib Index:(NSInteger)index;

#pragma mark - 系统短信电话功能

/**
 *  @brief  打电话
 *
 *  @param mobile 电话号码
 */
- (void)callMobile:(NSString *)mobile;

/**
 *  @brief  发短信
 *
 *  @param mobile 电话号码
 */
- (void)sendMessageToMobile:(NSString *)mobile;

@end
