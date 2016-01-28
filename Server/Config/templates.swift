//
//  MainViewTemplates.swift
//  Golb
//
//  Created by Francescu Santoni on 28/01/16.
//  Copyright © 2016 Francescu. All rights reserved.
//

import Foundation
import Mustache

struct RootView: AnyTemplateViewYield {
    static let path = "./Client/index.html"
    static let field = "yield"
}

struct ErrorView: AnyTemplateView {
    static let path = "./Client/error.html"
    
    static func render(error: String, message: String) -> String {
        return render(["error" : error, "message": message]) >% RootView.render
    }
}
