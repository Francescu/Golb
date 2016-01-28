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
import Mustache

let router = Router() { router in
    router.get("/", ArticleController().list)
    
    let responder = FileResponder(basePath: "./Client/Static/")
    router.fallback(responder)
//
//
//    router.fallback() { request in
//        let path = request.uri.path ?? "Unknown"
//        return Response(status: .NotFound, body: ErrorView.render("404", message: "Path not found: \(path)"))
//    }
}

let server = Server(port: 8000, responder: router)
print("Server ready http://127.0.0.1:8000")
server.start()
