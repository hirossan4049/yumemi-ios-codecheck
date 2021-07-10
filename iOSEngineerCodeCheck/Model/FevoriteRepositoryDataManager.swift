//
//  FevoriteRepositoryModel.swift
//  iOSEngineerCodeCheck
//
//  Created by craptone on 2021/07/10.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import Foundation
import CoreData

class FevoriteRepositoryDataManager {
    static let shared: FevoriteRepositoryDataManager = FevoriteRepositoryDataManager()

    private var persistentContainer: NSPersistentContainer!
    
    private let entityName = "CoreDataRepository"

   init() {
       persistentContainer = NSPersistentContainer(name: entityName)
       persistentContainer.loadPersistentStores { (storeDescription, error) in
           if let error = error as NSError? {
               fatalError("Unresolved error \(error), \(error.userInfo)")
           }
       }
   }

   func create<T: NSManagedObject>() -> T {
       let context = persistentContainer.viewContext
       let object = NSEntityDescription.insertNewObject(forEntityName: String(describing: T.self), into: context) as! T
       return object
   }

   func delete<T: NSManagedObject>(_ object: T) {
       let context = persistentContainer.viewContext
       context.delete(object)
   }

   func saveContext() {
       let context = persistentContainer.viewContext
       do {
           try context.save()
       } catch {

           print("Failed save context: \(error)")
       }
   }
    
    func addItem(repository: Repository) {
        let context = persistentContainer.viewContext
        let coreData_repository = NSEntityDescription.insertNewObject(forEntityName: entityName, into: context) as! CoreDataRepository
        coreData_repository.id = Int32(repository.id ?? 0)
        coreData_repository.name = repository.name
        coreData_repository.descriptionText = repository.description
        coreData_repository.language = repository.language
        coreData_repository.starCount = Int64(repository.starCount ?? 0)
        coreData_repository.watcherCount = Int64(repository.watcherCount ?? 0)
        coreData_repository.forkCount = Int64(repository.forkCount ?? 0)
        coreData_repository.issueCount = Int64(repository.issueCount ?? 0)
        coreData_repository.avatarImageURL = repository.owner?.avatarImageURL
        coreData_repository.username = repository.owner?.username

        if context.hasChanges {
            do {
                try context.save()
            } catch let error as NSError {
                print("Core Data Error: \(error), \(error.userInfo)")
            }
        }
    }
    
    func fetchItems(completion: @escaping ([CoreDataRepository]?) -> ()) {
        let request = NSFetchRequest<CoreDataRepository>(entityName: entityName)
        let context = persistentContainer.viewContext
        if let repositories = try? context.fetch(request) {
            completion(repositories)
        } else {
            completion(nil)
        }
    }
    
    func getFetchedResultController<T: NSManagedObject>(with descriptor: [String] = []) -> NSFetchedResultsController<T> {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<T>(entityName: String(describing: T.self))
        fetchRequest.sortDescriptors = descriptor.map { NSSortDescriptor(key: $0, ascending: true) }
        return NSFetchedResultsController<T>(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
    }
}
