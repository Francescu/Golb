//
//  Utils.swift
//  Golb
//
//  Created by Francescu Santoni on 28/01/16.
//  Copyright © 2016 Francescu. All rights reserved.
//

import Foundation

extension SequenceType {
    func mapSome<T>(@noescape transform: (Self.Generator.Element) throws -> T?) rethrows -> [T] {
        return try self.map(transform).filter { $0 != nil }.map { $0! }
    }
}


func do_or_log(identifier: String, message: String? = nil, @noescape closure: (Void) throws -> Void) {
    do {
        try closure()
    }
    catch let error as NSError {
        print("Error \(identifier): \(error)")
        if let message = message {
            print(message)
        }
    }
}

struct $ {
    static let env = NSProcessInfo.processInfo().environment
}
    