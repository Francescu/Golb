//
//  ArticleFetcher.swift
//  Golb
//
//  Created by Francescu Santoni on 28/01/16.
//  Copyright © 2016 Francescu. All rights reserved.
//

import Foundation
import PostgreSQL
import SQL

extension Article {
    static func create(fromRow row: PostgreSQL.Row) -> Article? {
        guard
            let identifier = row["id"]?.string,
            let title = row["title"]?.string,
            let content = row["content"]?.string else {
                return nil
        }
        
        return Article(identifier: identifier, title: title, content: content)
    }
    
    static let configuration = FetcherConfiguration(tableName: "articles",
                                                    defaultSelectFields: ["id", "content", "title", "created"],
                                                    create: Article.create)
}

//extension Article {
//    static func objectFromJSON(json: JSON) -> Article? {
//        guard let title = json["title"]?.stringValue,
//            let content = json["content"]?.stringValue else {
//                return nil
//        }
//        
//        return Article(title: title, content: content)
//    }
//}
// JSON Parsing
//    private let dataPath = "./Server/Utils/data.json"
//let content = try String(contentsOfFile: self.dataPath, encoding: NSUTF8StringEncoding)
//let json = try JSONParser.parse(content)
//
//guard let articlesRaw = json["articles"]?.arrayValue else { throw NSError(domain:"jsoncontent", code:1, userInfo:nil) }
//
//let articles = articlesRaw.map { Article.objectFromJSON($0) }.filter { $0 != nil }.map { $0! }
//print("ok")
//return articles