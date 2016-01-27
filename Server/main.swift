#if os(Linux)
    import Glibc
#else
    import Darwin.C
#endif
import HTTP
import Router
import Epoch
import CHTTPParser
import CLibvenice
import Sideburns

let router = Router() { router in
    router.get("/") { request in
        let controller = ArticleController()
        let data = ["articles" : controller.list().map { $0.mustache() } ]
        return try Response(status: .OK, templatePath: "./Client/index.html", templateData: data)
    }
    
    router.fallback() { request in
        let data = ["path" : request.uri.path]
        return try Response(status: .NotFound, templatePath: "./Client/404.html", templateData: data)
    }
}

let server = Server(port: 8000, responder: router)
print("Server ready http://127.0.0.1:8000")
server.start()
