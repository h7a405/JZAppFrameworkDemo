//
//  Log.swift
//  JRiOSAppFramework
//
//  Created by Jason Raylegih on 28/9/15.
//  Copyright (c) 2015 Jason Raylegih. All rights reserved.
//

import UIKit

class Log {
    /*
    *   Description: Print the string while under DEBUG model.
    *   @param1 message: The message String to print.
    *   @param2 withNewLine isWithNewLine: If there's a new line at the end of the message.
    *   @param3 fromFunction function: Name of the invoking function.
    */
    class func DLog(message: String?, fromFile file: String = __FILE__, fromFunction function: String = __FUNCTION__, atLine line: Int = __LINE__, logType type: LogType = LogType.Common) {
        #if DEBUG
            
            print("==========\(NSDate().toString())==========\n(In file \(file) at line \(line).)\n[func \(function)]\n\(type.toString)\n\(message)\n")
            
        #endif
    }
    /*
    *   Description: Print the any values while under DEBUG model.
    *   @param1 message: The message to print.
    *   @param2 withNewLine isWithNewLine: If there's a new line at the end of the message.
    *   @param3 fromFunction function: Name of the invoking function.
    */
    class func VLog<T>(value: T, fromFile file: String = __FILE__,  fromFunction function: String = __FUNCTION__, atLine line: Int = __LINE__, logType type: LogType = LogType.Common) {
        #if DEBUG
            
            print("==========\(NSDate().toString())==========\n(In file \(file) at line \(line).)\n[func \(function)]\n\(value)\n")
            
        #endif
    }
}


