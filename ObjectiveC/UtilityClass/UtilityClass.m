//
//  UtilityClass.m
//  Fonzee
//
//  Created by NavdeepSingh on 28/11/16.
//  Copyright © 2016 NavdeepSingh. All rights reserved.
//

#import "UtilityClass.h"
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>


#define kPermDisabled        0
#define kPermEnabled         1
#define kPermNotDetermined   2
#define kCamera     1
#define kPhotos     2

@implementation UtilityClass



#pragma mark - StoryBoard
+ (UIStoryboard *)getStoryBoard {
    
    @try {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"StoryBoardName" bundle:nil];
        return  storyBoard;
    }
    @catch (NSException *exception) {
        NSLog(@"Exception: %@",exception);
    }
}


#pragma mark - Display Alert having Message
+(id)displayAlertMessage:(NSString*)messsage
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:messsage preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:ok];
    return alertController ;
}




#pragma mark - Validations and Strings methods
#pragma mark Email Validation
+(BOOL)NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

#pragma mark Phone Validation
+(BOOL)NSStringIsValidPhone:(NSString *)checkString {
    NSString *phoneRegex = @"^(\([0-9]{3}\) |[0-9]{3}-)[0-9]{3}-[0-9]{4}$" ;
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:checkString];
}

#pragma mark Alpha-Numeric Validation
+(BOOL)checkForAlphaNumericChar:(NSString*)checkString {
    NSCharacterSet *alphaSet = [NSCharacterSet alphanumericCharacterSet];
    NSRange range = [checkString rangeOfCharacterFromSet:alphaSet];
    return (range.location != NSNotFound) ;
}



#pragma mark Remove WhiteSpace for string
+(NSString*)removeWhiteSpaceForString:(NSString*)string {
    NSString *returnStr = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return returnStr;
}

#pragma mark Remove Currency formatter for string
+(NSString*)removeCurrencyFormatterForString:(NSString*)string {
    NSString *returnStr = [string stringByReplacingOccurrencesOfString:@"$" withString:@""];
    returnStr = [returnStr stringByReplacingOccurrencesOfString:@"," withString:@""];
    return returnStr;
}

#pragma mark Password Validation




/* Check if password is 
 greater than 8 characters, 
 contains atleast one lowercase character,
 contains atleast one upper case character,
 contains atleast one digit,
 contains atleast one special character.
 */

// Using Regex
+(BOOL)NSStringIsValidPassword:(NSString *)checkString{
 
 // NSString *passwordRegex = @"^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=])(?=\\S+$).{8,25}$" ; // 8-25 characters
 NSString *passwordRegex = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=!])(?=\\S+$).{8,}$" //minimum 8 characters
 NSPredicate *passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passwordRegex];
 return [passwordTest evaluateWithObject:checkString];
}


/*
// Without Regex
+(BOOL)NSStringIsValidPassword:(NSString *)checkString{
    NSString *specialCharacterString = @"!~`@#$%^&*-+();:={}[],.<>?\\/\"\'";
    BOOL lowerCaseLetter = false,upperCaseLetter = false,digit = false,specialCharacter = 0;
    if([checkString length] >= 8)
    {
        for (int i = 0; i < [checkString length]; i++)
        {
            unichar c = [checkString characterAtIndex:i];
            if(!lowerCaseLetter)
            {
                lowerCaseLetter = [[NSCharacterSet lowercaseLetterCharacterSet] characterIsMember:c];
            }
            if(!upperCaseLetter)
            {
                upperCaseLetter = [[NSCharacterSet uppercaseLetterCharacterSet] characterIsMember:c];
            }
            if(!digit)
            {
                digit = [[NSCharacterSet decimalDigitCharacterSet] characterIsMember:c];
            }
        }
        if(!specialCharacter)
        {
            NSCharacterSet *specialCharacterSet = [NSCharacterSet characterSetWithCharactersInString:specialCharacterString] ;
            specialCharacter = [checkString.lowercaseString rangeOfCharacterFromSet:specialCharacterSet].length ;
        }
        if(specialCharacter && digit && lowerCaseLetter && upperCaseLetter) return YES ;
        
        else  return NO ;
        
    }
    else  return NO ;
   
    return NO ;
}
 */

#pragma mark - currency format
+(NSString *)getCurrencyFormatFor:(double)amount {
    
    @try {
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
        [numberFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
        NSString *numberAsString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:amount]];
        return numberAsString;
    }
    @catch (NSException *exception) {
        NSLog(@"Exception: %@",exception);
    }
}
#pragma mark Print Json
+(void)printJsonStringFor:(NSDictionary *)data {
    if (data) {
        //For testing
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data
                                                           options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                             error:&error];
        
        if (! jsonData) {
            NSLog(@"Got an error: %@", error);
        } else {
            NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            NSLog(@"Json string -- %@", jsonString);
        }
    }
    
}


#pragma mark - Date methods

/* You can change @"yyyy-MM-dd" or @"MMM dd, yyyy" as per your requirement */
+(NSString*)formatDateFromString:(NSString*)dateTimeString {
    NSString *dateStr  = @"" ;
    NSRange range = [dateTimeString rangeOfString:@"T"];
    if (range.location != NSNotFound)
    {
        NSArray *dateArray = [dateTimeString componentsSeparatedByString:@"T"] ;
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *date = [formatter dateFromString:[NSString stringWithFormat:@"%@",[dateArray objectAtIndex:0]]] ;
        NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
        [formatter2 setDateFormat:@"MMM dd, yyyy"];
        return [formatter2 stringFromDate:date];
    }
    return dateStr ;
}


/* You can change @"hh:mm:ss" or @"hh:mm a" as per your requirement */
+(NSString*)formatTimeFromString:(NSString*)dateTimeString {
    NSString *timeStr  = @"" ;
    NSRange range = [dateTimeString rangeOfString:@"T"];
    if (range.location != NSNotFound)
    {
        NSArray *dateArray = [dateTimeString componentsSeparatedByString:@"T"] ;
        if(dateArray.count >1){
             NSString *str = [dateArray objectAtIndex:1] ;
             NSRange range2 = [str rangeOfString:@"+"];
            if (range2.location != NSNotFound){
                NSArray *timeArray = [str componentsSeparatedByString:@"+"] ;
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"hh:mm:ss"];
                NSDate *date = [formatter dateFromString:[NSString stringWithFormat:@"%@",[timeArray objectAtIndex:0]]] ;
                NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
                [formatter2 setDateFormat:@"hh:mm a"];
                return [formatter2 stringFromDate:date];
            }
        }
    }
    return timeStr ;
}


+(NSString *)getLocalTime:(NSString *)strUTCDate{
    NSString *format = @"yyyy-MM-dd'T'HH:mm:ssZ";//@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";//"2017-01-31T09:08:15+0000"
    // Set up an NSDateFormatter for UTC time zone
    NSDateFormatter* formatterUtc = [[NSDateFormatter alloc] init];
    [formatterUtc setDateFormat:format];
    //[formatterUtc setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [formatterUtc setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    
    // Cast the input string to NSDate
    NSDate* utcDate = [formatterUtc dateFromString:strUTCDate];
    
    // Set up an NSDateFormatter for the device's local time zone
    NSDateFormatter* formatterLocal = [[NSDateFormatter alloc] init];
    [formatterLocal setDateFormat:format];
    [formatterLocal setTimeZone:[NSTimeZone systemTimeZone]];
    
    // Create local NSDate with time zone difference
    //NSDate* localDate = [formatterUtc dateFromString:[formatterLocal stringFromDate:utcDate]];
    return [formatterLocal stringFromDate:utcDate];
    
}
+(NSString *) changeTheDateFormat:(NSString *)strDate{
    NSString *localDateTime = [self getLocalTime:strDate];
    //NSLog(@"Input Date:%@  outputDate:%@",strDate,localDateTime);
    NSString *st = @"";
    NSDateFormatter* dayFmt = [[NSDateFormatter alloc] init];
    //[dayFmt setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //[dayFmt setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    [dayFmt setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    [dayFmt setTimeZone:[NSTimeZone systemTimeZone]];
    NSDate *date = [dayFmt dateFromString:localDateTime];
    NSDate *toDate = [NSDate date];
    
    NSCalendarUnit units = NSCalendarUnitDay | NSCalendarUnitWeekOfYear | NSCalendarUnitMonth | NSCalendarUnitYear;
    
    // if `date` is before "now" (i.e. in the past) then the components will be positive
    NSDateComponents *components = [[NSCalendar currentCalendar] components:units
                                                                   fromDate:date
                                                                     toDate:toDate
                                                                    options:0];
    dayFmt = nil;
    if (components.year > 0 || components.month > 0 || components.weekOfYear > 0 || components.day > 1) {
        NSDateFormatter* toDateFmt = [[NSDateFormatter alloc] init];
        [toDateFmt setDateFormat:@"dd MMM yyyy"];
        [toDateFmt setTimeZone:[NSTimeZone systemTimeZone]];
        NSString *toReturnDate = [toDateFmt stringFromDate:date];
        
        toDateFmt = nil;
        return toReturnDate;
        
    } else if (components.day > 0) {
        return @"Yesterday";
    } else {
        
        st=@"Today";
        //NSLog(@"%@",[NSDate date]);
        NSTimeInterval time = [date timeIntervalSinceNow];
        
        if (time < 0) {
            time = -(time);
        }
        
        int minutes = -1;
        if (time < 60) {
            //NSLog(@"STR DATE: %@", localDateTime);
            //NSLog(@"DATE: %@", [NSDate date]);
            minutes = time;
            
            if(minutes == 1){
                st = [NSString stringWithFormat:@"%d second ago",minutes];
            }
            else{
                st = [NSString stringWithFormat:@"%d seconds ago",minutes];
            }
        }
        else if (time > 3600){
            minutes = time/3600;
            
            if(minutes == 1)
                st = [NSString stringWithFormat:@"%d hour ago",minutes];
            else
                st = [NSString stringWithFormat:@"%d hours ago",minutes];
        }
        else if (time > 60) {
            minutes = floor(time/60);
            
            if(minutes == 1)
                st = [NSString stringWithFormat:@"%d minute ago",minutes];
            else
                st = [NSString stringWithFormat:@"%d minutes ago",minutes];
        }
        //NSLog(@"date: %@",st);
        return st;
    }
}


#pragma mark - Captcha
/* This method random 5 digit captcha or random alphanumeric string. You can modify as per your requirement */

+(NSMutableDictionary *)getNewCaptcha{
    
    @try {
        NSUInteger i1,i2,i3,i4,i5;
        NSMutableDictionary *captchaDict = [NSMutableDictionary new];
        
        NSArray *ar1 = [[NSArray alloc]initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l",@"m",@"n",@"o",@"p",@"q",@"r",@"s",@"t",@"u",@"v",@"w",@"x",@"y",@"z",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z", nil];
        
        CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
        CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
        CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
        UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
        
        
        
        [captchaDict setValue:color forKey:@"CaptchaColor"];
        
        i1 = arc4random() % ( [ar1 count] - 1);
        NSLog(@"RANDOM INDEX:%lu ",(unsigned long)i1);
        
        i2= arc4random() % ( [ar1 count] - 1);
        NSLog(@"RANDOM INDEX:%lu ",(unsigned long)i2);
        
        i3 = arc4random() % ( [ar1 count] - 1);
        NSLog(@"RANDOM INDEX:%lu ",(unsigned long)i3);
        
        i4 = arc4random() % ( [ar1 count] - 1);
        NSLog(@"RANDOM INDEX:%lu ",(unsigned long)i4);
        
        i5 = arc4random() % ( [ar1 count] - 1);
        NSLog(@"RANDOM INDEX:%lu ",(unsigned long)i5);
        
        
        NSString *captchaString = [NSString stringWithFormat:@"%@%@%@%@%@",[ar1 objectAtIndex:i1],[ar1 objectAtIndex:i2],[ar1 objectAtIndex:i3],[ar1 objectAtIndex:i4],[ar1 objectAtIndex:i5]];
        
        NSLog(@" Captcha String : %@",captchaString);
        
        [captchaDict setValue:captchaString forKey:@"CaptchaString"];
        return captchaDict;
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
    
}



#pragma mark - format phone number methods

#pragma mark get Formatted Phone Number
/* This method can be used to format any phone number like (541) 754-3010  having 10 characters. */
+(NSString *)getFormattedPhoneNumberWithoutCountryCodeFrom:(NSString *)phoneNumber{
    
    NSMutableString *formattedPhoneNumber;
    
    if (phoneNumber) {
        NSArray *components = [phoneNumber componentsSeparatedByCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]];
        NSString *decimalString = [components componentsJoinedByString:@""];
        
        NSUInteger length = decimalString.length;
        BOOL hasLeadingOne = length > 0 && [decimalString characterAtIndex:0] == '1';
        
        if (length == 0 || (length > 10 && !hasLeadingOne) || (length > 11)) {
            formattedPhoneNumber = [NSMutableString stringWithString:decimalString];
            //return NO;
        }
        
        NSUInteger index = 0;
        NSMutableString *formattedString = [NSMutableString string];
        
        //    if (hasLeadingOne) {
        //        [formattedString appendString:@"1 "];
        //        index += 1;
        //    }
        
        if (length - index > 3) {
            NSString *areaCode = [decimalString substringWithRange:NSMakeRange(index, 3)];
            [formattedString appendFormat:@"(%@) ",areaCode];
            index += 3;
        }
        
        if (length - index > 3) {
            NSString *prefix = [decimalString substringWithRange:NSMakeRange(index, 3)];
            [formattedString appendFormat:@"%@-",prefix];
            index += 3;
        }
        
        NSString *remainder = [decimalString substringFromIndex:index];
        [formattedString appendString:remainder];
        
        formattedPhoneNumber = formattedString;
        
    }
    return formattedPhoneNumber;
}

#pragma mark get Unformatted Phone Number
/* This method can be used to unformat phone number*/
+(NSString*)getUnformattedStringFromFormattedNumber:(NSString*)mobileNumber {
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"(" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@")" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"+" withString:@""];
    
    NSLog(@"%@", mobileNumber);
    NSInteger length = [mobileNumber length];
    if(length > 10) {
        mobileNumber = [mobileNumber substringFromIndex: length-10];
        NSLog(@"%@", mobileNumber);
    }
    return mobileNumber;
}

#pragma mark get Unformatted Phone Number length
+(NSInteger)getLength:(NSString*)mobileNumber {
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"(" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@")" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"+" withString:@""];
    
    NSInteger length = [mobileNumber length];
    return length;
}


#pragma mark - Base 64 string
+(NSString *)encodeToBase64String:(UIImage *)image {
    
    @try {
        return [UIImagePNGRepresentation(image) base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
        
    }
    @catch (NSException *exception) {
        NSLog(@"Exception: %@",exception);
    }
}

+(UIImage *)decodeBase64ToImage:(NSString *)strEncodeData {
    
    @try {
        NSData *data = [[NSData alloc]initWithBase64EncodedString:strEncodeData options:NSDataBase64DecodingIgnoreUnknownCharacters];
        return [UIImage imageWithData:data];
    }
    @catch (NSException *exception) {
        NSLog(@"Exception: %@",exception);
    }
}


#pragma mark - Views

#pragma mark Margin to TextField
+(void)addMarginsOnTextField:(UITextField*)textField
{
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0,0, 10, textField.frame.size.height)];
    textField.leftView = paddingView;
    textField.leftViewMode = UITextFieldViewModeAlways ;
    textField.rightView = paddingView;
    textField.rightViewMode = UITextFieldViewModeAlways ;
}

#pragma mark Add right side image to Textfield
/* replace @"ImageName" with required image name */
+(void)addRightViewToTextField:(UITextField*)textField {
    textField.rightViewMode = UITextFieldViewModeAlways;
    textField.rightView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ImageName"]];
}

#pragma mark Margin to TextView
+(void)addMarginsOnTextView:(UITextView*)textView {
    [textView setTextContainerInset:UIEdgeInsetsMake(0,10,0,30)];
}

#pragma mark Button Border color
+(void)setButtonBorder:(UIButton*)button
{
    button.layer.borderColor=[[UIColor colorWithRed:202.0/255.0f green:202.0/255.0f blue:202.0/255.0f alpha:1]CGColor];
    button.layer.borderWidth=1.0;
}

#pragma mark View Border color
+(void)setViewBorder:(UIView*)view
{
    view.layer.borderColor=[[UIColor colorWithRed:202.0/255.0f green:202.0/255.0f blue:202.0/255.0f alpha:1]CGColor];
    view.layer.borderWidth=1.0;
}






#pragma mark - Camera & Library Permissions

+(NSInteger)isCameraPermissionsEnabled{
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if(authStatus == AVAuthorizationStatusAuthorized) {
        NSLog(@"AVAuthorizationStatusAuthorized");
        return kPermEnabled;
    } else if(authStatus == AVAuthorizationStatusDenied) {
        NSLog(@"AVAuthorizationStatusDenied");
        return kPermDisabled;
    } else if(authStatus == AVAuthorizationStatusRestricted) {
        NSLog(@"AVAuthorizationStatusRestricted");
        return kPermDisabled;
    } else if(authStatus == AVAuthorizationStatusNotDetermined) {
        NSLog(@"AVAuthorizationStatusNotDetermined");
        // not determined?!
        return kPermNotDetermined;
    }
    
    //impossible this line exceutes, its just for to remove compiler warning
    return kPermNotDetermined;
}

+(NSInteger)isPhotoLibrarypermissionsEnabled{
    
    ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
    switch (status) {
        case ALAuthorizationStatusNotDetermined: {
            // not determined
            return kPermNotDetermined;
            break;
        }
        case ALAuthorizationStatusRestricted: {
            // restricted
            return kPermDisabled;
            break;
        }
        case ALAuthorizationStatusDenied: {
            // denied
            return kPermDisabled;
            break;
        }
        case ALAuthorizationStatusAuthorized: {
            // authorized
            return kPermEnabled;
            break;
        }
        default: {
            return kPermDisabled;
            break;
        }
    }
}

+(NSString *)handleErrorCodesForAssetLibrary:(NSInteger)errorCode{
    
    NSString *strMessage = @"";
    
    switch (errorCode) {
        case ALAssetsLibraryUnknownError: {
            strMessage = @"Not able to open Library.";
            break;
        }
        case ALAssetsLibraryDataUnavailableError: {
            strMessage = @"Library is currently unavailable.";
            break;
        }
        case ALAssetsLibraryAccessUserDeniedError: {
            strMessage = @"Please allow the Photos access under global settings.";
            break;
        }
        case ALAssetsLibraryAccessGloballyDeniedError: {
            strMessage = @"Please allow the global access under settings.";
            break;
        }
        default: {
            strMessage = @"Not able to open Library.";
            break;
        }
    }
    
    return strMessage;
}







#pragma mark - Mixed

#pragma mark get Country Code Dict
+ (NSDictionary *)getCountryCodeDictionary {
    return [NSDictionary dictionaryWithObjectsAndKeys:@"972", @"IL",
            @"93", @"AF", @"355", @"AL", @"213", @"DZ", @"1", @"AS",
            @"376", @"AD", @"244", @"AO", @"1", @"AI", @"1", @"AG",
            @"54", @"AR", @"374", @"AM", @"297", @"AW", @"61", @"AU",
            @"43", @"AT", @"994", @"AZ", @"1", @"BS", @"973", @"BH",
            @"880", @"BD", @"1", @"BB", @"375", @"BY", @"32", @"BE",
            @"501", @"BZ", @"229", @"BJ", @"1", @"BM", @"975", @"BT",
            @"387", @"BA", @"267", @"BW", @"55", @"BR", @"246", @"IO",
            @"359", @"BG", @"226", @"BF", @"257", @"BI", @"855", @"KH",
            @"237", @"CM", @"1", @"CA", @"238", @"CV", @"345", @"KY",
            @"236", @"CF", @"235", @"TD", @"56", @"CL", @"86", @"CN",
            @"61", @"CX", @"57", @"CO", @"269", @"KM", @"242", @"CG",
            @"682", @"CK", @"506", @"CR", @"385", @"HR", @"53", @"CU",
            @"537", @"CY", @"420", @"CZ", @"45", @"DK", @"253", @"DJ",
            @"1", @"DM", @"1", @"DO", @"593", @"EC", @"20", @"EG",
            @"503", @"SV", @"240", @"GQ", @"291", @"ER", @"372", @"EE",
            @"251", @"ET", @"298", @"FO", @"679", @"FJ", @"358", @"FI",
            @"33", @"FR", @"594", @"GF", @"689", @"PF", @"241", @"GA",
            @"220", @"GM", @"995", @"GE", @"49", @"DE", @"233", @"GH",
            @"350", @"GI", @"30", @"GR", @"299", @"GL", @"1", @"GD",
            @"590", @"GP", @"1", @"GU", @"502", @"GT", @"224", @"GN",
            @"245", @"GW", @"595", @"GY", @"509", @"HT", @"504", @"HN",
            @"36", @"HU", @"354", @"IS", @"91", @"IN", @"62", @"ID",
            @"964", @"IQ", @"353", @"IE", @"972", @"IL", @"39", @"IT",
            @"1", @"JM", @"81", @"JP", @"962", @"JO", @"77", @"KZ",
            @"254", @"KE", @"686", @"KI", @"965", @"KW", @"996", @"KG",
            @"371", @"LV", @"961", @"LB", @"266", @"LS", @"231", @"LR",
            @"423", @"LI", @"370", @"LT", @"352", @"LU", @"261", @"MG",
            @"265", @"MW", @"60", @"MY", @"960", @"MV", @"223", @"ML",
            @"356", @"MT", @"692", @"MH", @"596", @"MQ", @"222", @"MR",
            @"230", @"MU", @"262", @"YT", @"52", @"MX", @"377", @"MC",
            @"976", @"MN", @"382", @"ME", @"1", @"MS", @"212", @"MA",
            @"95", @"MM", @"264", @"NA", @"674", @"NR", @"977", @"NP",
            @"31", @"NL", @"599", @"AN", @"687", @"NC", @"64", @"NZ",
            @"505", @"NI", @"227", @"NE", @"234", @"NG", @"683", @"NU",
            @"672", @"NF", @"1", @"MP", @"47", @"NO", @"968", @"OM",
            @"92", @"PK", @"680", @"PW", @"507", @"PA", @"675", @"PG",
            @"595", @"PY", @"51", @"PE", @"63", @"PH", @"48", @"PL",
            @"351", @"PT", @"1", @"PR", @"974", @"QA", @"40", @"RO",
            @"250", @"RW", @"685", @"WS", @"378", @"SM", @"966", @"SA",
            @"221", @"SN", @"381", @"RS", @"248", @"SC", @"232", @"SL",
            @"65", @"SG", @"421", @"SK", @"386", @"SI", @"677", @"SB",
            @"27", @"ZA", @"500", @"GS", @"34", @"ES", @"94", @"LK",
            @"249", @"SD", @"597", @"SR", @"268", @"SZ", @"46", @"SE",
            @"41", @"CH", @"992", @"TJ", @"66", @"TH", @"228", @"TG",
            @"690", @"TK", @"676", @"TO", @"1", @"TT", @"216", @"TN",
            @"90", @"TR", @"993", @"TM", @"1", @"TC", @"688", @"TV",
            @"256", @"UG", @"380", @"UA", @"971", @"AE", @"44", @"GB",
            @"1", @"US", @"598", @"UY", @"998", @"UZ", @"678", @"VU",
            @"681", @"WF", @"967", @"YE", @"260", @"ZM", @"263", @"ZW",
            @"591", @"BO", @"673", @"BN", @"61", @"CC", @"243", @"CD",
            @"225", @"CI", @"500", @"FK", @"44", @"GG", @"379", @"VA",
            @"852", @"HK", @"98", @"IR", @"44", @"IM", @"44", @"JE",
            @"850", @"KP", @"82", @"KR", @"856", @"LA", @"218", @"LY",
            @"853", @"MO", @"389", @"MK", @"691", @"FM", @"373", @"MD",
            @"258", @"MZ", @"970", @"PS", @"872", @"PN", @"262", @"RE",
            @"7", @"RU", @"590", @"BL", @"290", @"SH", @"1", @"KN",
            @"1", @"LC", @"590", @"MF", @"508", @"PM", @"1", @"VC",
            @"239", @"ST", @"252", @"SO", @"47", @"SJ", @"963", @"SY",
            @"886", @"TW", @"255", @"TZ", @"670", @"TL", @"58", @"VE",
            @"84", @"VN", @"1", @"VG", @"1", @"VI", nil];
}


#pragma mark get Country Code
+(NSString *)getCountryCode{
    NSString *countryIdentifier = [[NSLocale currentLocale] objectForKey: NSLocaleCountryCode];
    NSLog(@"%@",[NSString stringWithFormat:@"+%@",[[self getCountryCodeDictionary] objectForKey:countryIdentifier]]);
    NSString *code = [[self getCountryCodeDictionary] objectForKey:countryIdentifier];
    
    return code;
}

@end
