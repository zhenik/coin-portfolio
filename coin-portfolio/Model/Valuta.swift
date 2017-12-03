//
//  Valuta.swift
//  coin-portfolio
//
//  Created by Nikita on 28/11/2017.
//  Copyright © 2017 Nikita. All rights reserved.
//

import Foundation

class Valuta {
    
    var id : String = ""
    var name: String = ""
    var percent_change_24h : Double=0
    var percent_change_1h: Double=0
    var percent_change_7d: Double=0
    var symbol: String = ""
    var price_nok: Double=0
    
    var amount : Double = 0
    var spend_money : Double = 0
    
    init(id: String, name: String, percent_change_1h: String, percent_change_24h: String,  percent_change_7d: String, symbol: String, price_nok: String) {
        self.id = id
        self.name = name
        self.percent_change_1h = Double(percent_change_1h)!
        self.percent_change_24h = Double(percent_change_24h)!
        self.percent_change_7d = Double(percent_change_7d)!
        self.symbol = symbol
        self.price_nok = Double(price_nok)!
    }
}

extension Valuta : CustomStringConvertible {
    var description: String {
        return "Valuta: { id: \(id), name: \(name), percent_change_1h: \(percent_change_1h),  percent_change_24h: \(percent_change_24h), percent_change_7d: \(percent_change_7d), symbol: \(symbol), price_nok: \(price_nok), amount: \(amount), spend_money: \(spend_money) }"
    }
}

extension Double {
    var roundedValue: String {
        return String(format: "%.0f", self)
    }
}
