//
//  Settings.swift
//  Golb
//
//  Created by Francescu Santoni on 28/01/16.
//  Copyright © 2016 Francescu. All rights reserved.
//

import Foundation

struct Settings {
    // Free instance on elephantsql during the dev
    static let PostgresConnection = $.env["GOLB_POSTGRES_CONNECTION"] ?? "postgres://bylaocol:1VqSF6oYlCFDbZioyr0oo3iopUSwL_2E@horton.elephantsql.com:5432/bylaocol"
}