//
//  ArticleViews.swift
//  Golb
//
//  Created by Francescu Santoni on 28/01/16.
//  Copyright © 2016 Francescu. All rights reserved.
//

import Foundation
import Mustache

class ArticleViews {
    static let List = ArticleListView()
    static let Show = ArticleShowView()
}

struct ArticleListView: AnyTemplateView {
    let path = "./Client/articles.html"
    let template: Template
    
    init() {
        self.template = createTemplate(self.path)
    }
    
    func render(articles: [Article]) throws -> String {
        return try render(["articles" : articles.map { $0.mustache() }])
    }
}

struct ArticleShowView: AnyTemplateView {
    let path = "./Client/article_show.html"
    let template: Template
    
    init() {
        self.template = createTemplate(self.path)
    }
    
    func render(article: Article) throws -> String {
        return try render(["article": article.mustache()])
    }
}

extension Article {
    func mustache() -> [String : String] {
        return ["identifier" : self.identifier, "title" : self.title, "content" : self.content]
    }
}