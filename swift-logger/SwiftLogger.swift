//
//  SwiftLogger.swift
//  swift-logger
//
//  Created by Jayson Kish on 12/1/24.
//

import ArgumentParser
import OSLog

@main
struct App: ParsableCommand {
    static var configuration: CommandConfiguration {
        CommandConfiguration(commandName: "swift-logger", abstract: "A command-line tool for writing to the unified logging system.", version: "1.4")
    }

    enum LogLevel: String, CaseIterable, ExpressibleByArgument {
        case `default`, info, debug, error, fault
        
        init?(argument: String) {
            self.init(rawValue: argument.lowercased())
        }
        
        var osLogType: OSLogType {
            switch self {
            case .default:
                return .default
            case .info:
                return .info
            case .debug:
                return .debug
            case .error:
                return .error
            case .fault:
                return .fault
            }
        }
    }

    @Argument(help: "The message to be logged.")
    var message: String
    
    @Option(help: "The log level to use.")
    var level: LogLevel = .default
    
    @Option(name: .long, help: "An identifier that represents the script subsystem that’s logging information.")
    var subsystem: String?
    
    @Option(name: .long, help: "A category within the specified subsystem.")
    var category: String?
    
    func run() throws {
        let logger = (subsystem != nil && category != nil) ? Logger(subsystem: subsystem!, category: category!) : Logger()
        logger.log(level: level.osLogType, "\(message, privacy: .public)")
    }
}
