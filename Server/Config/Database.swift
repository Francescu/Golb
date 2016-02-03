import PostgreSQL
import JSON

struct Database {
    let connection = Connection(Connection.Info(connectionString: Settings.PostgresConnection))
    
    let initial = Migration(identifier: "init")
    let migrations = ["0_users"].map(Migration.init)

    init() {
        self.migrate()
    }
    
    private func migrate() {
        do_or_log("DB Init") {
            try connection.open()
            try initial.apply(connection)
            
            connection.close()
        }
    }
}

struct Migration {
    static let basePath = "./Server/Config/DB/"
    static let ext = "sql"
    
    let identifier: String
    
    var fullPath: String {
        return Migration.basePath + self.identifier + "." + Migration.ext
    }
    
    func apply(connection: Connection) throws {
        try connection.executeFromFile(atPath: self.fullPath)
    }
}

extension Migration {
    static func create(fromRow row: PostgreSQL.Row) -> Migration? {
        guard
            let identifier = row["id"]?.string else {
                return nil
        }
        
        return Migration(identifier: identifier)
    }
    
    static let configuration = FetcherConfiguration(tableName: "migrations",
                                                    defaultSelectFields: ["id", "created"],
                                                    create: Migration.create)
}