//
//  GoalsViewModel.swift
//  App187
//
//  Created by Вячеслав on 9/7/23.
//

import SwiftUI
import CoreData

final class GoalsViewModel: ObservableObject {
    
    @Published var goalAmount: String = ""
    @Published var title: String = ""
    
    @Published var goals: [GoalsModel] = []
    
    @Published var isAddTrans: Bool = false
    @Published var isAddGoal: Bool = false
    
    @Published var amounts: [String] = ["20", "50", "100", "200", "500"]
    
    @Published var transAmount: String = ""
    
    @Published var selectedGoalForTrans: GoalsModel?
    
    func addGoals(completion: @escaping () -> (Void)) {
        
        CoreDataStack.shared.modelName = "GoalsModel"
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let trans = NSEntityDescription.insertNewObject(forEntityName: "GoalsModel", into: context) as! GoalsModel
        
        trans.goalAmount = Int16(goalAmount) ?? 0
        trans.title = title
        trans.currentAmount = 0
        
        CoreDataStack.shared.saveContext()
        
        completion()
    }
    
    func addTransaction(for goalModel: GoalsModel, completion: @escaping () -> Void) {
        
        CoreDataStack.shared.modelName = "GoalsModel"
        let context = CoreDataStack.shared.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<GoalsModel>(entityName: "GoalsModel")
        
        fetchRequest.predicate = NSPredicate(format: "SELF == %@", goalModel)
        
        do {
            
            if let fetchedGoals = try context.fetch(fetchRequest).first {
                
                fetchedGoals.currentAmount += Int16(transAmount) ?? 0
                
                try context.save()
            }
        } catch {
            
            print("Ошибка при обновлении goalAmount: \(error.localizedDescription)")
        }
        
        completion()
    }

    
    func fetchGoals() {
        
        CoreDataStack.shared.modelName = "GoalsModel"
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<GoalsModel>(entityName: "GoalsModel")

        do {
            
            let branch = try context.fetch(fetchRequest)
            
            self.goals = branch
            
        } catch let error as NSError {
            
            print("Error fetching persons: \(error), \(error.userInfo)")
            
            self.goals = []
        }
    }
}
