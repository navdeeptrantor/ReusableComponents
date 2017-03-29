//
//  UtilityClass.h
//  Fonzee
//
//  Created by NavdeepSingh on 28/11/16.
//  Copyright © 2016 NavdeepSingh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface UtilityClass : NSObject


#pragma mark - StoryBoard
+ (UIStoryboard *)getStoryBoard;

#pragma mark - Display Alert having Message
+(id)displayAlertMessage:(NSString*)messsage;


#pragma mark - Validations and Strings methods
#pragma mark Email Validation
+(BOOL)NSStringIsValidEmail:(NSString *)checkString;

#pragma mark Phone Validation
+(BOOL)NSStringIsValidPhone:(NSString *)checkString;

#pragma mark Alpha-Numeric Validation
+(BOOL)checkForAlphaNumericChar:(NSString*)checkString;

#pragma mark Remove WhiteSpace for string
+(NSString*)removeWhiteSpaceForString:(NSString*)string;

#pragma mark Remove Currency formatter for string
+(NSString*)removeCurrencyFormatterForString:(NSString*)string;

#pragma mark Password Validation
+(BOOL)NSStringIsValidPassword:(NSString *)checkString;

#pragma mark - currency format
+(NSString *)getCurrencyFormatFor:(double)amount;

#pragma mark Print Json
+(void)printJsonStringFor:(NSDictionary *)data;

#pragma mark - Date methods
/* You can change @"yyyy-MM-dd" or @"MMM dd, yyyy" as per your requirement */
+(NSString*)formatDateFromString:(NSString*)dateTimeString;

/* You can change @"hh:mm:ss" or @"hh:mm a" as per your requirement */
+(NSString*)formatTimeFromString:(NSString*)dateTimeString;

+(NSString *)getLocalTime:(NSString *)strUTCDate;

+(NSString *) changeTheDateFormat:(NSString *)strDate;

#pragma mark - Captcha
/* This method random 5 digit captcha or random alphanumeric string. You can modify as per your requirement */
+(NSMutableDictionary *)getNewCaptcha;



#pragma mark - format phone number methods

#pragma mark get Formatted Phone Number
/* This method can be used to format any phone number like (541) 754-3010  having 10 characters. */
+(NSString *)getFormattedPhoneNumberWithoutCountryCodeFrom:(NSString *)phoneNumber;

#pragma mark get Unformatted Phone Number
/* This method can be used to unformat phone number*/
+(NSString*)getUnformattedStringFromFormattedNumber:(NSString*)mobileNumber;

#pragma mark get Unformatted Phone Number length
+(NSInteger)getLength:(NSString*)mobileNumber;

#pragma mark - Base 64 string
+(NSString *)encodeToBase64String:(UIImage *)image;

+(UIImage *)decodeBase64ToImage:(NSString *)strEncodeData;



#pragma mark - Views

#pragma mark Margin to TextField
+(void)addMarginsOnTextField:(UITextField*)textField;

#pragma mark Add right side image to Textfield
/* replace @"ImageName" with required image name */
+(void)addRightViewToTextField:(UITextField*)textField;

#pragma mark Margin to TextView
+(void)addMarginsOnTextView:(UITextView*)textView;

#pragma mark Button Border color
+(void)setButtonBorder:(UIButton*)button;

#pragma mark View Border color
+(void)setViewBorder:(UIView*)view;



#pragma mark - Camera & Library Permissions

+(NSInteger)isCameraPermissionsEnabled;
+(NSInteger)isPhotoLibrarypermissionsEnabled;
+(NSString *)handleErrorCodesForAssetLibrary:(NSInteger)errorCode;

#pragma mark - Mixed
#pragma mark get Country Code Dict
+ (NSDictionary *)getCountryCodeDictionary;
#pragma mark get Country Code
+(NSString *)getCountryCode;
@end

