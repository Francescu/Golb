# Golb
Swift as a Webserver on Linux – Blog written in Swift

## WIP TODO
- [X] Spawn a Swift webserver on **Linux** 
- [X] Dev tools to quickly deploy in both local (OSX) and prod (Linux)
- [X] Add a **Mustache** template engine
- [X] Make project works with both **Swift Package Manager** and **Xcode**
- [X] Add a simple **design** and work with **static files**
- [X] Integrate with **PostgreSQL**
- [X] Create a page to **Show an article**
- [ ] Parse & Display **Markdown**
- [ ] Play with **Dates**, display article creation
- [ ] Create a simple **admin**, for at least create and edit posts
- [ ] Create a **migration system** for SQL
- [ ] Create Users
- [ ] Add comments / emoji reaction
- [ ] RSS feed

## Better dev tool
- [ ] Fully integrate docker-compose/Tutum for deployment (instead of external Postgres URL)
- [ ] Add an access/error log system and made it persist through a docker volume-container
- [ ] Create a cli to generate/scaffold project, models, routes, views, controllers 
- [ ] Add unit testing
- [ ] Run in Xcode
- [ ] Add front-end tools (Gulp + Bower at least)
- [ ] Add a Watcher which relaunch local server

## Technical stuff inside
### Global error response handler 

Simply using the `$.respond` method allow us to handle well errors.

For instance:
```swift
return $.respond("article list") {
            let articles = try fetcher.findAll()
            return try Response(status: .OK, body: ArticleViews.List.render(articles) >% root.render )
        }
```

Will handle multiple common errors:

```swift
static func respond(identifier: String, @noescape closure: (Void) throws -> Response) -> Response {
        $.log("Requested: \(identifier)")
        do {
            return try closure()
        }
        catch $.Error.Unwrap {
            return Response(status: .BadRequest, body: "Unwrap" >% $.error)
        }
        catch FetcherError.SQL(message: let error) {
            return Response(status: .BadRequest, body: error >% $.error)
        }
        catch FetcherError.NotFound {
            return Response(status: .NotFound, body: "404" >% $.error)
        }
        catch let error as NSError {
            return Response(status: .InternalServerError, body: error.localizedDescription >% $.error)
        }
    }
```



## Community

[![Slack](http://s13.postimg.org/ybwy92ktf/Slack.png)](http://slack.zewo.io)

The project heavily depends on the (so nice) [Zewo Stack](https://github.com/Zewo), the best way to reach me is on their [Slack](http://slack.zewo.io).
