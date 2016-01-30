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
        let fetcher = ArticleFetcher()
        
        switch fetcher.findAll() {
        case .Success(let articles):
            return Response(status: .OK, body: ArticleListView.render(articles) >% root.render )
            
        case .Error(let error):
            let out = error?.localizedDescription ?? "Unknown"
            print("Error list : \(error)")
            return Response(status: .NoContent, body: ErrorView.render("No content", message: out))
        }
        
    }
    
}

