//
//  CreateLearners.swift
//  
//
//  Created by Wedad Almehmadi on 19/03/2023.
//

import Fluent

struct CreateLearners : Migration {
    func prepare(on database: FluentKit.Database) -> NIOCore.EventLoopFuture<Void> {
        return database.schema("learners")
            .id()
        .field("name", .string, .required)
        .field("name", .string, .required)
        .create()
    }
    
    func revert(on database: FluentKit.Database) -> NIOCore.EventLoopFuture<Void> {
        return database.schema("learners").delete()
    }
    
    
}
