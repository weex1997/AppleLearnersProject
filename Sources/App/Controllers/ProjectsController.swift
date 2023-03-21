//
//  ProjectsController.swift
//  
//
//  Created by Wedad Almehmadi on 20/03/2023.
//

import Foundation
import Vapor

struct ProjectsController: RouteCollection {
    func boot (routes: RoutesBuilder) throws {
        let Projects = routes.grouped ("projects")

        Projects.get(use: index) //show
        Projects.post(use: create) //create
        Projects.put( use: update) //update
        Projects.delete(":id", use: delete) // delete
    }
    
    //projects route
    func index (req: Request) throws -> EventLoopFuture<[Projects]> {
        return Projects.query(on: req.db).all()
    }
    
    //create projects
    func create (req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let project = try req.content.decode(Projects.self)
        return project.save (on: req.db).transform(to: .ok)
    }
    
    //update projects
    func update(req:Request) throws -> EventLoopFuture<Projects>
    {
    let input = try req.content.decode(Projects.self)
        return Projects.find(input.id, on: req.db)
    .unwrap(or : Abort( .notFound ))
    .flatMap { project in
        project.name = input.name
        project.link = input.link
    return project.save(on: req.db) .map {Projects (id : project.id, name :project.name , link :project.link)}}

    }
    
    //delete projects
    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
            guard let id = req.parameters.get("id", as: UUID.self) else {
                throw Abort(.badRequest)
            }
            return Projects.find(id, on: req.db)
                .unwrap(or: Abort(.notFound))
                .flatMap { $0.delete(on: req.db) }
                .map { .ok }
        }
}
