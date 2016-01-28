//
//  ArticleController.swift
//  Golb
//
//  Created by Francescu Santoni on 27/01/16.
//  Copyright © 2016 Francescu. All rights reserved.
//

import Foundation
import JSON
import HTTP

struct ArticleController {
    private let dataPath = "./Server/Utils/data.json"
    
    func list(request: Request) -> Response {
        do {
            let content = try String(contentsOfFile: self.dataPath, encoding: NSUTF8StringEncoding)
            let json = try JSONParser.parse(content)
            
            guard let articlesRaw = json["articles"]?.arrayValue else { throw NSError(domain:"jsoncontent", code:1, userInfo:nil) }
            let articles = articlesRaw.map { Article.objectFromJSON($0) }.filter { $0 != nil }.map { $0! }
            
            return Response(status: .OK, body:  ArticleListView.render(articles) >% RootView.render)
            
        }
        catch let error as NSError {
            print("Error list : \(error)")
            return Response(status: .NoContent, body: ErrorView.render("No content", message: error.localizedDescription))
        }
    }
}



extension Article {
    static func objectFromJSON(json: JSON) -> Article? {
        guard let title = json["title"]?.stringValue,
            let content = json["content"]?.stringValue else {
                return nil
        }
        
        return Article(title: title, content: content)
    }
}