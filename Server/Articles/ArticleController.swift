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
    private let fetcher: Fetcher<Article>
    
    init() {
        fetcher = Fetcher(configuration: Article.configuration)
    }
    
    func list(request: Request) -> Response {
        do {
            let articles = try fetcher.findAll()
            return Response(status: .OK, body: ArticleListView.render(articles) >% root.render )
        }
        catch let error as NSError {
            print("Error: \(error)")
            return Response(status: .NoContent, body: ErrorView.render("No content", message: error.localizedDescription))
        }
        
    }
    
}

