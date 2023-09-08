//
//  BudgetViewModel.swift
//  App187
//
//  Created by Вячеслав on 9/7/23.
//

import SwiftUI
import CoreData

final class BudgetViewModel: ObservableObject {
    
    @Published var sum: String = ""
    @Published var title: String = ""
    
    @Published var budgets: [BudgetModel] = []
    
    @Published var isAddTransaction: Bool = false
    
    func addTrans(completion: @escaping () -> (Void)) {
        
        CoreDataStack.shared.modelName = "BudgetModel"
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let trans = NSEntityDescription.insertNewObject(forEntityName: "BudgetModel", into: context) as! BudgetModel
        
        trans.sum = Int16(sum) ?? 0
        trans.title = title
        
        CoreDataStack.shared.saveContext()
        
        completion()
    }
    
    func fetchBudgets() {
        
        CoreDataStack.shared.modelName = "BudgetModel"
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<BudgetModel>(entityName: "BudgetModel")

        do {
            
            let branch = try context.fetch(fetchRequest)
            
            self.budgets = branch
            
        } catch let error as NSError {
            
            print("Error fetching persons: \(error), \(error.userInfo)")
            
            self.budgets = []
        }
    }
}
