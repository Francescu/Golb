//
//  MainViewTemplates.swift
//  Golb
//
//  Created by Francescu Santoni on 28/01/16.
//  Copyright © 2016 Francescu. All rights reserved.
//

import Foundation
import Mustache

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

struct ErrorView: AnyTemplateViewYield {
    let path = "./Client/error.html"
    let template: Template
    let field = "yield"
    init() {
       self.template = createTemplate(self.path)
    }
}

