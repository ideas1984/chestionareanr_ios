//
//  CoreDataManager.swift
//  Chestionare ANR
//
//  Created by Marius Tanasoiu on 1/19/21.
//  Copyright © 2021 NavyMasters. All rights reserved.
//
import UIKit
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager();
    
    private init() {}
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ChestionareANR");
        
        container.loadPersistentStores(completionHandler: { _, error in
            _ = error.map { fatalError("Unresolved error \($0)") }
        })
        return container;
    }()
    
    var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext;
    }
    
    func backgroundContext() -> NSManagedObjectContext {
        return persistentContainer.newBackgroundContext();
    }
    
    func saveWrongQuestion(questionId: Int, wrongAnswerId: Int) {
        let context = CoreDataManager.shared.backgroundContext();
        
        context.perform {
            let wrongAnswer = WrongAnswer(entity: WrongAnswer.entity(), insertInto: context);
            wrongAnswer.id = Int64(questionId);
            wrongAnswer.wrongAnswerID = Int64(wrongAnswerId);
            wrongAnswer.timestamp = Date();
            do {
                try context.save();
            }  catch {
                debugPrint("Cannot save context for questionId=\(questionId) and wrongAnswerId=\(wrongAnswerId) and error=\(error)");
            }
        }
    }
    
    func loadWrongAnswers() -> [WrongAnswer] {
        let mainContext = CoreDataManager.shared.mainContext;
        let fetchRequest: NSFetchRequest<WrongAnswer> = WrongAnswer.fetchRequest();
        do {
            var results = try mainContext.fetch(fetchRequest);
            results.sort(by: { $0.timestamp! > $1.timestamp! });
            return results;
        }
        catch {
            debugPrint(error);
        }
        return [];
    }
    
    func deleteWrongAnswer(wrongAnswer: WrongAnswer) {
        let context = CoreDataManager.shared.mainContext;
        
        context.delete(wrongAnswer);
        
        do {
            try context.save();
        }  catch {
            debugPrint("Cannot delete from context for questionId=\(wrongAnswer.id) and wrongAnswerId=\(wrongAnswer.wrongAnswerID) and error=\(error)");
        }
    }
    
    
    public func resetCoreData() {
        // get all entities and loop over them
        let entityNames = self.persistentContainer.managedObjectModel.entities.map({ $0.name!})
        entityNames.forEach { [weak self] entityName in
           let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
           let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)

           do {
            try self?.backgroundContext().execute(deleteRequest);
                try self?.backgroundContext().save();
           } catch {
            debugPrint("Cannot reset core data");
           }
       }
    }
    
}
