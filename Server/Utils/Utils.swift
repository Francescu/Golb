//
//  Utils.swift
//  Golb
//
//  Created by Francescu Santoni on 28/01/16.
//  Copyright © 2016 Francescu. All rights reserved.
//

import Foundation
import HTTP

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
    catch let error as NSError {
        $.log("Error \(identifier): \(error)")
        if let message = message {
            $.log(message)
        }
    }
}


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
    }
    static let error: (content:String) -> String = { root.render(try! Views.Error.render($0)) }
        
    static func extract<A>(optional: A?) throws -> A {
        guard let value = optional else { throw Error.Unwrap }
        return value
    }
    
    
    static func respond(identifier: String, @noescape closure: (Void) throws -> Response) -> Response {
        $.log("Requested: \(identifier)")
        do {
            return try closure()
        }
        catch $.Error.Unwrap {
            $.log("Unwrap")
            return Response(status: .BadRequest, body: "Unwrap" >% $.error)
        }
        catch FetcherError.SQL(message: let error) {
            $.log("Error \(identifier): \(error)")
            return Response(status: .BadRequest, body: error >% $.error)
        }
        catch FetcherError.NotFound {
            return Response(status: .NotFound, body: "404" >% $.error)
        }
        catch let error as NSError {
            $.log("Error \(identifier): \(error)")
            return Response(status: .InternalServerError, body: error.localizedDescription >% $.error)
        }
    }
}
    