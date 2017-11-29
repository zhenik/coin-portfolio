//
//  MarketVC.swift
//  coin-portfolio
//
//  Created by Nikita on 28/11/2017.
//  Copyright © 2017 Nikita. All rights reserved.
//

import UIKit

class MarketVC: UIViewController {

    // Outlets
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    // Data
    var valutasMarket: [Valuta] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        initSlideReveal()
        updateValutas()
    }
    
    func initSlideReveal(){
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
    }
    
    func updateValutas(){
        ApiDataService.instance.getTenValutas { (success) in
            if success {
                print(ApiDataService.instance.valutas)
                self.valutasMarket = ApiDataService.instance.valutas
            }
        }
    }
        
    
//    init(id: String, name: String, percent_change_1h: String, percent_change_24h: String,  percent_change_7d: String, symbol: String, price_nok: String)
    
    func mockItems(){
        var items: [Valuta] = []
        let valuta1 = Valuta(id:"bitcoin", name:"BTC",percent_change_1h:"0.7",percent_change_24h: "0.21",percent_change_7d: "0.02",symbol:"BTC", price_nok: "80324.2")
        items.append(valuta1)
        
        
    }


}
