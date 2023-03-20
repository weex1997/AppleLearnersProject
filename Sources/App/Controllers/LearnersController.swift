//
//  LearnersController.swift
//  
//
//  Created by Wedad Almehmadi on 19/03/2023.
//

import Foundation
import Vapor

struct LearnersController: RouteCollection {
    func boot (routes: RoutesBuilder) throws {
        let learners = routes.grouped ("learners")
        
        learners.get(use: index) //show
        learners.post(use: create) //create
    }
    
    //learner route
    func index (req: Request) throws -> EventLoopFuture<[Learners]> {
        return Learners.query(on: req.db).all()
    }
    
    //create learners
    func create (req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let learner = try req.content.decode(Learners.self)
        return learner.save (on: req.db).transform(to: .ok)
    }
}

struct ProjectsController: RouteCollection {
    func boot (routes: RoutesBuilder) throws {
        let Projects = routes.grouped ("Projects")

        Projects.get(use: index) //show
        Projects.post(use: create) //create
    }
    
    //project route
    func index (req: Request) throws -> EventLoopFuture<[Projects]> {
        return Projects.query(on: req.db).all()
    }
    
    //create project
    func create (req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let project = try req.content.decode(Projects.self)
        return project.save (on: req.db).transform(to: .ok)
    }
}
