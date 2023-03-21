//
//  Projects.swift
//  
//
//  Created by Wedad Almehmadi on 20/03/2023.
//

import Fluent
import Vapor

final class Projects: Model, Content{
    static let schema = "projects"
    
    @ID (key: .id)
    var id: UUID?
    
    @Field (key: "name")
    var name: String
    
    @Field (key: "link")
    var link: String
    
    init() { }
    
    init(id: UUID? = nil, name: String, link: String) {
        self.id = id
        self.name = name
        self.link = link
    }
}
