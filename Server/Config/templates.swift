//
//  MainViewTemplates.swift
//  Golb
//
//  Created by Francescu Santoni on 28/01/16.
//  Copyright © 2016 Francescu. All rights reserved.
//

import Foundation
import Mustache

//struct RootView: AnyTemplateViewYield {
//    static let path = "./Client/index.html"
//    static let field = "yield"
//    static let template = createTemplate(path)
//}

struct RootView {
    let header: String
    let footer: String
    
    init() {
       self.header = try! String(contentsOfFile: "./Client/header.html", encoding: 4)
       self.footer = try! String(contentsOfFile: "./Client/footer.html", encoding: 4)
    }
    
    func render(content: String) -> String {
        return header + content + footer
    }
}
let root = RootView()

struct ErrorView: AnyTemplateView {
    static let path = "./Client/error.html"
    static let template = createTemplate(path)
    
    static func render(error: String, message: String) -> String {
        return render(["error" : error, "message": message]) >% root.render
    }
}
