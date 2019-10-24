//
//  CoreDataManager+Trainer.swift
//  The"OfFiCiAl"TerryCrewsApp
//
//  Created by K Y on 10/22/19.
//  Copyright © 2019 K Y. All rights reserved.
//

import CoreData

private let entityName = "Trainer"

extension CoreDataManager {
    
    func loadTrainer(_ completion: @escaping (Trainer?)->Void) {
        let context = mainContext
        let desc = NSEntityDescription.entity(forEntityName: entityName,
                                              in: context)!
        context.perform {
            let request = NSFetchRequest<Trainer>()
            request.entity = desc
            request.fetchLimit = 1
            let results = try! context.fetch(request)
            completion(results.first)
        }
    }
    
    func saveTrainer(name: String?, image: String?) {
        
        let context = mainContext
        let desc = NSEntityDescription.entity(forEntityName: entityName,
                                              in: context)!
        context.perform {
            let trainer = Trainer(entity: desc, insertInto: context)
            trainer.name = name
            trainer.image = image
            self.saveMain()
        }
        
    }
    /*
    func fetchData(_ completion: @escaping ([Trainer])->Void) {
        let context = mainContext
        let desc = NSEntityDescription.entity(forEntityName: "Person",
                                              in: context)!
        // contexts can do work on their own thread
        context.perform {
            let request = NSFetchRequest<Person>()
            request.entity = desc
            // let request: NSFetchRequest<Person> = Person.fetchRequest()
            let results = try! context.fetch(request)
            completion(results)
        }
    }
    
    func makePerson() {
        let context = backgroundContext
        context.perform {
            let desc = NSEntityDescription.entity(forEntityName: "Person",
                                                  in: context)!
            let person = Person(entity: desc, insertInto: context)
            person.name = "Bob"
            person.age = 34
            person.occupation = "Builder"
            try! context.save()
        }
    }
     */
}
