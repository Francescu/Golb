import HTTP
import Router
import Epoch
import Middleware

let db = Database()

let router = Router() { router in

    router.get("/", ArticleController().list)
    router.get("/article/:id", ArticleController().show)
    
    let responder = FileResponder(basePath: "./Client/Static/")
    router.fallback(responder)

}  >>> FailureRecoveryMiddleware() >>> AccessLoggerMiddleware()

let server = Server(port: 8002, responder: router )
print("Server ready http://127.0.0.1:8000")
server.start()
