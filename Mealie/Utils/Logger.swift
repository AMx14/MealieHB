//
//  Logger.swift
//  Mealie
//
//  Created by Akshat Maithani on 18/02/25.
//

import Foundation
import OSLog

enum LogCategory: String {
    case database = "📀 Database"
    case navigation = "🧭 Navigation"
    case networking = "🌐 Network"
    case userAction = "👤 User Action"
    case error = "❌ Error"
}

final class AppLogger {
    static let shared = AppLogger()
    private let logger: Logger
    
    private init() {
        self.logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "com.mealie", category: "app")
    }
    
    func log(_ message: String, category: LogCategory, type: OSLogType = .default, file: String = #file, function: String = #function, line: Int = #line) {
        let sourceFileName = (file as NSString).lastPathComponent
        let logMessage = "[\(category.rawValue)] [\(sourceFileName):\(line)] \(function) - \(message)"
        
        logger.log(level: type, "\(logMessage)")
        
        #if DEBUG
        print(logMessage)
        #endif
    }
    
    func error(_ error: Error, category: LogCategory = .error, file: String = #file, function: String = #function, line: Int = #line) {
        log(error.localizedDescription, category: category, type: .error, file: file, function: function, line: line)
    }
}

// Usage example:
// AppLogger.shared.log("Recipe saved successfully", category: .database)
// AppLogger.shared.error(error, category: .networking)
