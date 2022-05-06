import Vapor

func routes(_ app: Application) throws {
    app.get { req in
        return "ROOT"
    }
    
    app.get("hello") { req in
        return "HELLO"
    }
    
    // http://127.0.0.1:8080/movies/year/*YearParameter*/genre/*GenreParameter*
    app.get("movies", "year", ":year", "genre", ":genre") { req -> String in
        guard let year = req.parameters.get("year"), let genre = req.parameters.get("genre") else {
            throw Abort(.badRequest)
        }
        
        return "Year:\(year), Genre: \(genre)"
    }
    
    // http://127.0.0.1:8080/movies/genre/parameter
    app.get("movies", "genre", ":name") { req -> String in
        guard let name = req.parameters.get("name") else {
            throw Abort(.badRequest)
        }
        
        return name
    }
    
    // http://127.0.0.1:8080/movies/genre/fiction
    app.get("movies", "genre", "fiction") { req in
        return "/movies/genre/fiction"
    }
    
    // http://127.0.0.1:8080/search?keyword=aa&page=123
    app.get("search") { req -> String in
        guard let keyword = req.query["keyword"] as String?,
              let page = req.query["page"] as Int? else { throw Abort(.badRequest) }
        
        return "Keyword: \(keyword) Page: \(page)"
    }
    
    // GROUPS
    let users = app.grouped("users")
    
    users.get { req in
        return "/users"
    }
    
    users.get(":userId") { req -> String in
        guard let userId = req.parameters.get("userId") else { throw Abort(.badRequest) }
        
        return "userId: \(userId)"
    }
    
    users.post { req in
        return "POST"
    }
}
