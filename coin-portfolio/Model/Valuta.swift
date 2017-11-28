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
    var percent_change_24h : String = ""
    var percent_change_1h: String = ""
    var percent_change_7d: String = ""
    var symbol: String = ""
    var price_nok: String = ""
    
    init(id: String, name: String, percent_change_1h: String, percent_change_24h: String,  percent_change_7d: String, symbol: String, price_nok: String) {
        self.id=id
        self.name=name
        self.percent_change_1h=percent_change_1h
        self.percent_change_24h=percent_change_24h
        self.percent_change_7d = percent_change_7d
        self.symbol=symbol
        self.price_nok=price_nok
    }
}

extension Valuta : CustomStringConvertible {
    var description: String {
        return "Valuta: { id: \(id), name: \(name), percent_change_1h: \(percent_change_1h),  percent_change_24h: \(percent_change_24h), percent_change_7d: \(percent_change_7d), symbol: \(symbol), price_nok: \(price_nok) }"
    }
}
