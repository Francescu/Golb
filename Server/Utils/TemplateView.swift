//
//  View.swift
//  Golb
//
//  Created by Francescu Santoni on 28/01/16.
//  Copyright © 2016 Francescu. All rights reserved.
//

import Foundation
import Mustache
import HTTP


protocol AnyTemplateView {
    var path: String { get }
    var template: Template { get }
    
    func render(params: [String : MustacheBoxable]) throws -> String
}

protocol AnyTemplateViewYield: AnyTemplateView {
    var field: String { get }
    
    func render(content: String, params: [String : MustacheBoxable]) throws -> String
    func render(content: String) throws -> String
}

extension AnyTemplateView {
    func render(params: [String : MustacheBoxable]) throws -> String {
        let boxed = Box(boxable: params)
        return try self.template.render(boxed)
    }
}

func createTemplate(path: String) -> Template {
    let fileContent = try! String(contentsOfFile: path, encoding: 4)
    let t = try! Template(string: fileContent)
    return t
}

extension AnyTemplateViewYield {
    func render(content: String) throws -> String {
        let p: [String : MustacheBoxable] = [field : content]
        return try self.template.render(Box(boxable: p))
    }
    
    func render(content: String, params: [String : MustacheBoxable]) throws -> String {
        var p = params
        p[field] = content
        
        return try self.template.render(Box(boxable: p))
    }

}

infix operator >% { associativity left precedence 120 }

func >%(left: String, right: (String) -> String) -> String {
   return right(left)
}
