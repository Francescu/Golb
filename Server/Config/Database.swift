//
//  PostgreSQLTmp.swift
//  Golb
//
//  Created by Francescu Santoni on 28/01/16.
//  Copyright © 2016 Francescu. All rights reserved.
//

import Foundation
import PostgreSQL
import JSON

struct Database {
    let connection = Connection(Connection.Info(connectionString: Settings.PostgresConnection))

    init() {
        self.createTables()
    }
    
    private func createTables() {
        do_or_log("DB Init") {
            try connection.open()
            do {
                try connection.executeFromFile(atPath:"./Server/Config/db.sql")
            }
            catch PostgreSQL.Result.Error.BadStatus(_, let s) {
                print(s)
            }
            connection.close()
        }
    }
    
}

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
