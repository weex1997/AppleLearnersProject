//
//  CreateProject.swift
//  
//
//  Created by Wedad Almehmadi on 20/03/2023.
//

import Fluent

struct CreateProject : Migration {
    func prepare(on database: FluentKit.Database) -> NIOCore.EventLoopFuture<Void> {
        return database.schema("projects")
            .id()
        .field("name", .string, .required)
        .field("link", .string, .required)
        .create()
    }
    
    func revert(on database: FluentKit.Database) -> NIOCore.EventLoopFuture<Void> {
        return database.schema("projects").delete()
    }
    
    
}
