//
//  PostgreSQLTmp.swift
//  Golb
//
//  Created by Francescu Santoni on 28/01/16.
//  Copyright © 2016 Francescu. All rights reserved.
//

import Foundation
import PostgreSQL

func sqlTest() {
    let connection = Connection("postgresql://localhost/blog")
    do {
        try connection.open()
        let result = try connection.execute("SELECT * FROM posts")
        for row in result {
            print(row)
        }
    } catch {
        print(error)
    }
}