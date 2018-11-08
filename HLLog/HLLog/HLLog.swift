//
//  HLLog.swift
//  HLLog
//
//  Created by zcon on 2018/10/24.
//  Copyright © 2018 liangJun. All rights reserved.
//

import Foundation

public class HLLog: NSObject {
    public static var buildMode: BuildConfiguration = .debug
    public static func debug<T>(_ message: T, file: String = #file, function: String = #function, line: Int = #line) {
        if buildMode == .debug {
            let fileName = (file as NSString).lastPathComponent
            print("➡️Debug: \(fileName) (line:\(line)) | \(message)")
        }
    }
    
    
    public static func info<T>(_ message: T, file: String = #file, function: String = #function, line: Int = #line) {
        if buildMode == .debug {
            let fileName = (file as NSString).lastPathComponent
            print("ℹ️Info: \(fileName) (line:\(line)) | \(message)")
        }
    }
    
    
    public static func error<T>(_ message: T, file: String = #file, function: String = #function, line: Int = #line) {
        if buildMode == .debug {
            let fileName = (file as NSString).lastPathComponent
            print("‼️Error: \(fileName) (line:\(line)) | \(message)")
        }
    }
    
    
    public enum BuildConfiguration {
        case release
        case debug
    }
}



