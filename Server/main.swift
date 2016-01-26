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

    router.post("/users") { request in
        // do something based on the Request
        return Response(status: .Created)
    }

    router.get("/users/:id") { request in
        let id = request.parameters["id"]
        // do something based on the Request and id
        return Response(status: .OK, body: "YYY")
    } 

    router.fallback() { request in
        let data = ["path" : request.parameters["path"]]
        return Response(status: .NotFound, templatePath: "./Client/404.html", templateData: data)
    }


}

let server = Server(port: 8080, responder: router)
server.start()
