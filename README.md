# Golb
Swift as a Webserver on Linux – Blog written in Swift

## WIP TODO Blog
- [X] Spawn a Swift webserver on **Linux** 
- [X] **Mustache** template engine
- [X] Add a simple **design** and work with **static files**
- [X] PostgreSQL
- [X] Create a page to **Show an article**
- [ ] Parse & Display **Markdown**
- [ ] Create a simple **admin**, for at least create and edit posts
- [ ] Dates, (display article creation)
- [ ] Users
- [ ] Comments / emoji reaction
- [ ] RSS feed
- [ ] Categories
- [ ] First install setup page
- [ ] gzip static content
- [ ] serve content/type to static file
- [ ] add global timeout to requests

## Framework itself
- [ ] External Settings loading (e.g yml?)

## Better dev tool
- [X] Quickly deploy in both local (OSX) and prod (Linux) -- Makefile + Dockerfile
- [X] Make project works with both **Swift Package Manager** and **Xcode**
- [ ] Makefile to install dependencies on OSX/Linux
- [ ] Create a **migration system** for SQL
- [ ] Fully integrate docker-compose/Tutum for deployment (instead of external Postgres URL)
- [ ] Add an access/error log system and made it persist through a docker volume-container
- [ ] Create a cli to generate/scaffold project, models, routes, views, controllers 
- [ ] Add unit testing
- [ ] Add front-end tools (Gulp + Bower at least)
- [ ] Add a Watcher which relaunch local server

## Docs 
- [X] Initial README
- [ ] Get started document
- [ ] Contributing section
- [ ] Define the purpose of this repo (Blog engine vs. web framework)

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
