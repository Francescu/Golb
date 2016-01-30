
import PackageDescription

let package = Package(
    name: "Golb",
    dependencies: [
        .Package(url: "https://github.com/Zewo/Epoch.git", majorVersion: 0),
        .Package(url: "https://github.com/Zewo/Middleware.git", majorVersion: 0),
//        .Package(url: "https://github.com/Zewo/PostgreSQL.git", majorVersion: 0),
        .Package(url: "https://github.com/Francescu/PostgreSQL.git", majorVersion: 0),
        .Package(url: "https://github.com/Zewo/Sideburns.git", majorVersion: 0),
        .Package(url: "https://github.com/Zewo/JSON.git", majorVersion: 0),
        ]
        )
