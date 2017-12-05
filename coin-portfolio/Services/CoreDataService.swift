//
//  CoreDataService.swift
//  coin-portfolio
//
//  Created by Nikita on 04/12/2017.
//  Copyright © 2017 Nikita. All rights reserved.
//

import Foundation
import CoreData

// Source: https://cocoacasts.com/reading-and-updating-managed-objects-with-core-data/
class CoreDataService {
    // singleton
    static let instance = CoreDataService()
    private let context : NSManagedObjectContext
    
    private init(){
        self.context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    func addToPortfolio(valuta: Valuta, amount: Double, spend: Double) {
        if let item = isAlreadyInPortfolio(id: valuta.id) {
            //            print("is already in portfolio:  \(item)")
            updateEntity(portfolioItem: item, amount: amount, spend: spend)
        } else {
            //            print("add new item: \(valuta.name)")
            createRecordForEntity(valuta: valuta, amount: amount, spend: spend)
        }
    }
    
    private func createRecordForEntity(valuta: Valuta, amount: Double, spend: Double) {
        let portfolioItem = PortfolioItem(entity: PortfolioItem.entity(), insertInto: self.context)
        portfolioItem.id = valuta.id
        portfolioItem.name = valuta.name
        portfolioItem.amount = amount
        portfolioItem.spend_money = spend
        portfolioItem.symbol = valuta.symbol
        // add img
        portfolioItem.image = UIImagePNGRepresentation(ApiDataService.instance.getImage(id: portfolioItem.id!))
        try? self.context.save()
        print("Added new item in core data")
    }
    
    private func fetchRecordsForEntity() -> [NSManagedObject] {
        // Create Fetch Request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PortfolioItem")
        fetchRequest.returnsObjectsAsFaults = false
        // Helpers
        var result = [NSManagedObject]()
        do {
            // Execute Fetch Request
            let records = try self.context.fetch(fetchRequest)
            if let records = records as? [NSManagedObject] {
                result = records
            }
        } catch {
            print("Unable to fetch managed objects for entity PortfolioItem.")
        }
        return result
    }
    
    private func updateEntity(portfolioItem: NSManagedObject, amount: Double, spend: Double) {
        
        let oldAmount = portfolioItem.value(forKey: "amount") as! Double
        let oldSpend_money = portfolioItem.value(forKey: "spend_money") as! Double
        let newAmount = oldAmount + amount
        let newSpend_money = oldSpend_money + spend
        
        print("""
            oldAmount: \(oldAmount)
            oldSpend_money: \(oldSpend_money)
            newAmount: \(newAmount)
            newSpend: \(newSpend_money)
            """)
        portfolioItem.setValue(Double(newSpend_money), forKey: "spend_money")
        portfolioItem.setValue(Double(newAmount), forKey: "amount")
    }
    
    func getItemById(id: String)-> NSManagedObject?{
        let items = fetchRecordsForEntity()
        for item in items {
            if let value : String = item.value(forKey: "id") as? String{
                if (value == id){
                    print("ur item \(item)")
                    return item
                }
            }
        }
        return nil
    }
    
    private func isAlreadyInPortfolio(id: String) -> NSManagedObject? {
        return getItemById(id: id)
    }
    
    func getPortfolioItems() -> [PortfolioItem] {
        let items = fetchRecordsForEntity() as? [PortfolioItem]
        if let portfolioItems : [PortfolioItem] = items {
            return portfolioItems
        }
        return [PortfolioItem]()
    }
    
    func deleteItemById(id: String){
        if let item = getItemById(id: id){
            context.delete(item)
        }
    }
    
   
    
    func getTotalSpend() -> Double {
        let items = getPortfolioItems()
        var spendTotal : Double = 0
        for item in items {
            spendTotal = spendTotal + item.spend_money
        }
        return spendTotal
    }
    
    func getTrendForPortfolio() -> Double {
        let items = getPortfolioItems()
        var totalMoneySpendForPortfolio : Double = 0
        for item in items {
            totalMoneySpendForPortfolio = totalMoneySpendForPortfolio + ApiDataService.instance.getTrend(item: item)
        }
        return totalMoneySpendForPortfolio
    }
}
