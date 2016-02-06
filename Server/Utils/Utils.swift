//
//  Utils.swift
//  Golb
//
//  Created by Francescu Santoni on 28/01/16.
//  Copyright © 2016 Francescu. All rights reserved.
//

import Foundation
import HTTP
import PostgreSQL

extension SequenceType {
    func mapSome<T>(@noescape transform: (Self.Generator.Element) throws -> T?) rethrows -> [T] {
        return try self.map(transform).filter { $0 != nil }.map { $0! }
    }
}

func do_or_log(identifier: String, message: String? = nil, @noescape closure: (Void) throws -> Void) {
    do {
        try closure()
    }
    catch FetcherError.SQL(message: let error) {
        $.log("Error \(identifier): \(error)")
        if let message = message {
            $.log(message)
        }
    }
    catch PostgreSQL.Result.Error.BadStatus(_, let error) {
        $.log("Error \(identifier): \(error)")
        if let message = message {
            $.log(message)
        }
    }
    catch let error as NSError {
        $.log("Error \(identifier): \(error)")
        if let message = message {
            $.log(message)
        }
    }
}

let accessLogger = FileLogger(path: "./access.log")
let debugLogger = FileLogger(path: "./debug.log")

struct $ {
    enum Error: ErrorType {
        case Unwrap
    }
    
    private struct Views {
        static let Error = ErrorView()
    }
    static let env = NSProcessInfo.processInfo().environment
    static func log(message: String) {
        print(message)
//        debugLogger.log(message)
    }
    
    static func accessLog(message: String) {
        print(message)
//        accessLogger.log(message)
    }
    
    static let error: (content:String) -> String = { root.render(try! Views.Error.render($0)) }
        
    static func extract<A>(optional: A?) throws -> A {
        guard let value = optional else { throw Error.Unwrap }
        return value
    }
}
    