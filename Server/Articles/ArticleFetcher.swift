//
//  ArticleFetcher.swift
//  Golb
//
//  Created by Francescu Santoni on 28/01/16.
//  Copyright © 2016 Francescu. All rights reserved.
//

import Foundation
import PostgreSQL
//
//func sqlTest() {
//    let connection = Connection("postgresql://localhost/blog")
//    do {
//        try connection.open()
//        let result = try connection.execute("SELECT * FROM posts")
//        for row in result {
//            print(row)
//        }
//    } catch {
//        print(error)
//    }
//}
struct ArticleFetcher {
    let connection = db.connection
    
    func findAll() -> Result<[Article]> {
        do {
            try connection.open()
            print("open db")
            let result = try connection.execute("SELECT title, content FROM articles ORDER BY created DESC;")
            connection.close()
            return .Success(result.mapSome(Article.objectFromDB))
        }
        catch PostgreSQL.Result.Error.BadStatus(_, let error) {
            print("SQL Error \(error)")
            return .Error(nil)
        }
        catch let error as NSError {
            print("error \(error)")
            return .Error(error)
        }
    }
}



extension Article {
    static func objectFromDB(row: Row) -> Article? {
        guard let title = row["title"]?.string,
            let content = row["content"]?.string else {
                return nil
        }
        
        return Article(title: title, content: content)
    }
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