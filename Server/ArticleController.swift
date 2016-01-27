//
//  ArticleController.swift
//  Golb
//
//  Created by Francescu Santoni on 27/01/16.
//  Copyright © 2016 Francescu. All rights reserved.
//

import Foundation
import JSON

struct ArticleController {
   
    func list() -> [Article] {
        do {
            let content =  try String(contentsOfFile: "./Server/data.json", usingEncodig: NSUTF8StringEncoding)
            let json = try JSONParser.parse(content)
            
            guard let articles = json["articles"]?.arrayValue else { return [Article]() }
            
            return articles.map { Article.objectFromJSON($0) }.filter { $0 != nil }.map { $0! }
        }
        catch let error as NSError {
            print("Error list : \(error)")
            return [Article]()
        }
    }
}