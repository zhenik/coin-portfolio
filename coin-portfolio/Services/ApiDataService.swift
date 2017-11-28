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
    public private(set) var arr: [Valuta]=[]
    
    
    func getTenValutas(completion: @escaping CompletionHandler){
        let header = [
            "Content-Type":"application/json; charset=utf-8"
        ]
        
        Alamofire.request(BASE_URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else {return}
                
                let json = JSON(data: data)
                var arr: [JSON] = json.arrayValue
//                print(arr)
//                arr.map(item in
//                    let valuta = Valuta(item.)
//                )
                
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
}
