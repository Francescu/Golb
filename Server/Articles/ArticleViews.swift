//
//  ArticleViews.swift
//  Golb
//
//  Created by Francescu Santoni on 28/01/16.
//  Copyright © 2016 Francescu. All rights reserved.
//

import Foundation
import Mustache

struct ArticleListView: AnyTemplateView {
    static let path = "./Client/articles.html"
    static let template = createTemplate(path)
    
    static func render(articles: [Article]) -> String {
        return render(["articles" : articles.map { $0.mustache() }])
    }
}

extension Article {
    func mustache() -> [String : String] {
        return ["title" : self.title, "content" : self.content]
    }
}