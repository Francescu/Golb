//
//  Fetcher.swift
//  Golb
//
//  Created by Francescu Santoni on 31/01/16.
//  Copyright © 2016 Francescu. All rights reserved.
//

import Foundation
import PostgreSQL
import SQL


enum FetcherError: ErrorType {
    case NotFound
    case SQL(message: String)
}

struct FetcherConfiguration<Entity> {
    let tableName: String
    let defaultSelectFields: [String]
    let create: (fromRow: PostgreSQL.Row) -> Entity?
}

struct Fetcher<Entity> {
    
    typealias SQLError = PostgreSQL.Result.Error
    
    let configuration: FetcherConfiguration<Entity>
    private let connection = db.connection
    
    init(configuration: FetcherConfiguration<Entity>) {
        self.configuration = configuration
    }
    
    func findAll() throws -> [Entity] {
        return try select(configuration.defaultSelectFields, request: "ORDER BY created DESC")
    }
    
    func find(identifier: String) throws -> Entity {
        guard let result = try select(configuration.defaultSelectFields, request: "WHERE id = $1 LIMIT 1", parameters: identifier).first else {
            throw FetcherError.NotFound
        }
        return result
    }
    
    private func select(fields: [String]? = nil, request: String?, parameters: SQL.SQLParameterConvertible...) throws -> [Entity] {
        try connection.open()
        
        let requestFields = fields ?? self.configuration.defaultSelectFields
        
        var statement = "SELECT " + requestFields.joinWithSeparator(", ") + " FROM " + configuration.tableName
        if let request = request {
            statement += " " + request
        }
        
        do {
            let result = try connection.execute(statement, parameters: parameters)
            return result.mapSome(configuration.create)
        }
        catch SQLError.BadStatus(_, let string) {
            throw FetcherError.SQL(message: string)
        }
    }
   
    
}
