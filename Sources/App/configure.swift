import Fluent
import FluentPostgresDriver
import Vapor

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    app.databases.use(.postgres(hostname: "localhost", username: "wedadalmehmadi",
                                password: "1003", database: "AppleLearners"), as: .psql)
    
    app.migrations.add(CreateLearners())
    try app.autoMigrate() .wait()
    
    // register routes
    try routes(app)
}
