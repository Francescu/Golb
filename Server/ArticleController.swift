//
//  ArticleController.swift
//  Golb
//
//  Created by Francescu Santoni on 27/01/16.
//  Copyright © 2016 Francescu. All rights reserved.
//

import Foundation
struct Article {
    let title: String
    let content: String
    
    func mustache() -> [String : String] {
        return ["title" : self.title, "content" : self.content]
    }
    
}

struct ArticleController {
   
    func list() -> [Article] {
        return [Article(title: "test", content: "test content")]
    }
}