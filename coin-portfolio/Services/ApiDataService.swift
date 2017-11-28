//
//  ApiService.swift
//  coin-portfolio
//
//  Created by Nikita on 28/11/2017.
//  Copyright © 2017 Nikita. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ApiDataService {
    static let instance = ApiDataService()
    public private(set) var valutas: [Valuta]=[]
    
    func getTenValutas(completion: @escaping CompletionHandler){
        let header = [
            "Content-Type":"application/json; charset=utf-8"
        ]
        
        Alamofire.request(BASE_URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).validate().responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else {return}
                let json = JSON(data: data)
                self.parseJsonAndUpdateValutas(arr: json.arrayValue)
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func parseJsonAndUpdateValutas(arr: [JSON]){
        var temp:[Valuta]=[]
        
        temp = arr.map({
            let id = $0["id"].stringValue
            let name = $0["name"].stringValue
            let percent_change_1h = $0["percent_change_1h"].stringValue
            let percent_change_24h = $0["percent_change_24h"].stringValue
            let percent_change_7d = $0["percent_change_7d"].stringValue
            let symbol = $0["symbol"].stringValue
            let price_nok = $0["price_nok"].stringValue
            
            return Valuta(id: id, name: name, percent_change_1h: percent_change_1h, percent_change_24h: percent_change_24h, percent_change_7d: percent_change_7d, symbol: symbol, price_nok:price_nok)
        })
        
        self.valutas=temp
    }
}
