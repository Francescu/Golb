//
//  Article.swift
//  Golb
//
//  Created by Francescu Santoni on 27/01/16.
//  Copyright © 2016 Francescu. All rights reserved.
//

import Foundation
import JSON

struct Article {
    let title: String
    let content: String
}

extension Article {
    static func objectFromJSON(json: JSON) -> Article? {
        guard let title = json["title"]?.stringValue,
            let content = json["content"]?.stringValue else {
                return nil
        }
        
        return Article(title: title, content: content)
    }
    
    func mustache() -> [String : String] {
        return ["title" : self.title, "content" : self.content]
    }
}