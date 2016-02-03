//

//  LoggerMiddleware.swift
//  Golb
//
//  Created by Francescu Santoni on 02/02/16.
//  Copyright © 2016 Francescu. All rights reserved.
//

import Middleware
import HTTP
import Core

struct FileLogger {
    let path: String
    func log(string: String) {
        // TODO: Add current date
        do {
            let file = try File(path: self.path, mode: File.Mode.AppendUpdate)
            try file.write(Data(bytes: "\(string)\n".data))
            file.close()
        }
        catch {
            print("FILE ERROR: \(error)")
        }
    }
}

struct AccessLoggerMiddleware: RequestResponseMiddlewareType {
    func respond(request: Request, response: Response) {
        let log = "\(request.method) \(request.uri.path ?? "")"
        $.accessLog(log)
    }
}

