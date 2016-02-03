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
    
    func list(request: Request) throws -> Response {
        let articles = try fetcher.findAll()
        return try Response(status: .OK, body: ArticleViews.List.render(articles) >% root.render )
    }
    
    func show(request: Request) throws -> Response {
        let identifier = try $.extract(request.parameters["id"])
        let article = try fetcher.find(identifier)
        return try Response(status: .OK, body: ArticleViews.Show.render(article) >% root.render )
    }
}

