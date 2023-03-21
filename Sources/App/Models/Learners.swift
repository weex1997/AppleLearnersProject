//
//  Learners.swift
//  
//
//  Created by Wedad Almehmadi on 19/03/2023.
//

import Fluent
import Vapor

final class Learners: Model, Content{
    static let schema = "learners"
    
    @ID (key: .id)
    var id: UUID?
    
    @Field (key: "name")
    var name: String
    
    @Field (key: "path")
    var path: String
    
    init() { }
    
    init(id: UUID? = nil, name: String, path: String) {
        self.id = id
        self.name = name
        self.path = path
    }
    
}
