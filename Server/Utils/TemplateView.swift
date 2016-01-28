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
    static var path: String { get }
    static var template: Template { get }
    
    static func render(params: [String : MustacheBoxable]) -> String
}

protocol AnyTemplateViewYield: AnyTemplateView {
    static var field: String { get }
    
    static func render(content: String, params: [String : MustacheBoxable]) -> String
    static func render(content: String) -> String
}

extension AnyTemplateView {
    static var template: Template {
        let fileContent = try! String(contentsOfFile: path, encoding: 4)
        return try! Template(string: fileContent)
        
    }
    
    static func render(params: [String : MustacheBoxable]) -> String {
        return try! self.template.render(Box(boxable: params))
    }
}

extension AnyTemplateViewYield {
    static func render(content: String) -> String {
        let p: [String : MustacheBoxable] = [field : content]
        return try! self.template.render(Box(boxable: p))
    }
    
    static func render(content: String, params: [String : MustacheBoxable]) -> String {
        var p = params
        p[field] = content
        
        return try! self.template.render(Box(boxable: p))
    }

}

infix operator >% { associativity left precedence 120 }

func >%(left: String, right: (String) -> String) -> String {
   return right(left)
}
