//
//  ApiService.swift
//  coin-portfolio
//
//  Created by Nikita on 28/11/2017.
//  Copyright © 2017 Nikita. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage
import SwiftyJSON

struct currImage {
    var id: String
    var img: UIImage
}

class ApiDataService {
    static let instance = ApiDataService()
    
    public private(set) var valutas: [Valuta]=[]
    
    private var images: [currImage] = []
    var img: UIImage = UIImage()
    
    func getImages(completion: @escaping CompletionHandler){
        for item in valutas{
//            print("\(IMG_API_URL)\(item.id).png")
            Alamofire.request("\(IMG_API_URL)\(item.id).png").responseImage { response in
//                debugPrint(response)
                if let image = response.result.value {
                    self.img=image
                    self.images.append(currImage(id: item.id, img: image))
                }
            }
        }
    }
    
    func getImage(id: String) -> UIImage{
        for item in images {
            if(item.id==id){
                return item.img
            }
        }
        return UIImage()
    }
    
    func getTenValutas(completion: @escaping CompletionHandler){
        let header = [
            "Content-Type":"application/json; charset=utf-8"
        ]
        
        Alamofire.request(BASE_API_URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
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
    
    func getValutaById(id: String) -> Valuta? {
        for item in valutas {
            if item.id == id {
                return item
            }
        }
        return nil
    }
    
    // True -> positive trend, false -> negative trend
    // return true if cellPrice > spend_money
    func getTrend(item : PortfolioItem) -> Bool {
        guard let valuta = getValutaById(id: item.id!) else {return false}
        let sellPrice = item.amount * valuta.price_nok
        if sellPrice >= item.spend_money {
            return true
        }
        return false
    }
}

