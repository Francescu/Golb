//
//  FailureMiddleware.swift
//  Golb
//
//  Created by Francescu Santoni on 02/02/16.
//  Copyright © 2016 Francescu. All rights reserved.
//

import HTTP
import Middleware
import Foundation

struct FailureRecoveryMiddleware: FailureResponderType {
    
    func respond(error: ErrorType) -> Response {
        $.accessLog("Error: \(error)")
        switch error {
        case $.Error.Unwrap:
            return Response(status: .BadRequest, body: "Unwrap" >% $.error)
        case FetcherError.SQL(message: let error):
            return Response(status: .BadRequest, body: error >% $.error)
        case FetcherError.NotFound:
            return Response(status: .NotFound, body: "404" >% $.error)
        case let error as NSError:
            return Response(status: .InternalServerError, body: error.localizedDescription >% $.error)
        default:
            return Response(status: .InternalServerError, body: "Unwkown error" >% $.error)
        }
    }
}