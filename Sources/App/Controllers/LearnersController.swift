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
        learners.put( use: update) //update
        learners.delete(":id", use: delete) // delete
        
        
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
    
    //update learners
    func update(req:Request) throws -> EventLoopFuture<Learners>
    {
    let input = try req.content.decode(Learners.self)
        return Learners.find(input.id, on: req.db)
    .unwrap(or : Abort( .notFound ))
    .flatMap { learner in
    learner.name = input.name
    learner.path = input.path
    return learner.save(on: req.db) .map {Learners (id : learner.id, name :learner.name , path :learner.path)}}

    }
    
    //delete learners
    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
            guard let id = req.parameters.get("id", as: UUID.self) else {
                throw Abort(.badRequest)
            }
            return Learners.find(id, on: req.db)
                .unwrap(or: Abort(.notFound))
                .flatMap { $0.delete(on: req.db) }
                .map { .ok }
        }
}
