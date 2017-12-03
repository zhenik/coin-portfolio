//
//  PortfolioService.swift
//  coin-portfolio
//
//  Created by Nikita on 28/11/2017.
//  Copyright © 2017 Nikita. All rights reserved.
//

import Foundation
class PortfolioService {
    static let instance = PortfolioService()
    
    func addToPortfolio(valuta: Valuta, amount: Double, spend: Double) {
        if let item = isAlreadyInPortfolio(id: valuta.id) {
            print("is already in portfolio:  \(item)")
        } else {
            addNewItem(valuta: valuta, amount: amount, spend: spend)
        }
    }
    
    func getPortfolioItems() -> [PortfolioItem] {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let items = try? context.fetch(PortfolioItem.fetchRequest()) as? [PortfolioItem] {
                if let theItems = items {
                    print(" \(theItems.first?.name)) : amount: \(theItems.first?.amount)")
                    return theItems
                }
            }
            print("it fetched in core data")
        }
        
        return [PortfolioItem]()
    }
    
    private func addNewItem(valuta: Valuta, amount: Double, spend: Double){
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            let portfolioItem = PortfolioItem(entity: PortfolioItem.entity(), insertInto: context)
            portfolioItem.id = valuta.id
            portfolioItem.name = valuta.name
            portfolioItem.amount = amount
            portfolioItem.spend_money = spend
            portfolioItem.symbol = valuta.symbol
            try? context.save
            
            print("Added new item in core data")
        }
    }
    
    private func isAlreadyInPortfolio(id: String) -> PortfolioItem? {
        let portfolio = getPortfolioItems()
        for item in portfolio {
            if(item.id == id){
                return item
            }
        }
        return nil
    }
}
