//
//  main.swift
//  swift-logger
//
//  Created by Jayson Kish on 12/1/24.
//

import ArgumentParser
import Foundation
import OSLog

@main
struct App: ParsableCommand {
    static var configuration: CommandConfiguration {
        CommandConfiguration(commandName: "swift-logger", abstract: "", version: "1.0")
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

    @Option(name: .shortAndLong, help: "The message's log level.")
    var level: LogLevel = .default

    @Option(name: .shortAndLong, help: "The message to log.")
    var message: String
    
    @Option(name: .long, help: "The subsystem.")
    var subsystem: String?
    
    @Option(name: .long, help: "The category.")
    var category: String?
    
    func run() throws {
        let logger = (subsystem != nil && category != nil) ? Logger(subsystem: subsystem!, category: category!) : Logger()
        logger.log(level: level.osLogType, "\(message, privacy: .public)")
    }
}
