//
//  PortfolioVC.swift
//  coin-portfolio
//
//  Created by Nikita on 26/11/2017.
//  Copyright © 2017 Nikita. All rights reserved.
//

import UIKit

class PortfolioVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // Outlets
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    // Vars
    var valutasMarket: [Valuta] = []
    var portfolioItems: [PortfolioItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initMarketData()   //TODO: move to app delegate
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        
        
        
    }
    
    // REVEAL setup START
    override func viewDidAppear(_ animated: Bool) {
        initSlideReveal()
        loadPortfolio()
    }
    
    func initSlideReveal(){
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
    }
    // REVEAL setup END
    
    
    //TODO: refresh on pull
//    func updateValutas(){
//        ApiDataService.instance.getTenValutas { (success) in
//            if success {
//                print(ApiDataService.instance.valutas)
//                self.valutasMarket = ApiDataService.instance.valutas
//                self.tableView.reloadData()
//            }
//        }
//    }
    
    //    TABLE VIEW START
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return portfolioItems.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "portfolioCell", for: indexPath)
        let val = portfolioItems[indexPath.row]
        cell.textLabel?.text = val.name
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let valuta : PortfolioItem = portfolioItems[indexPath.row]
//        print(valuta)
    }
    //    TABLE VIEW END
    
    
    func initMarketData(){
        ApiDataService.instance.getTenValutas { (success) in
            if success {
                print("success")
                ApiDataService.instance.getImages { (success) in
                    if success {
                        print("images loaded")
                    }
                }
            }
        }
        
    }
    
    func loadPortfolio() {
        self.portfolioItems = PortfolioService.instance.getPortfolioItems()
//        valutasMarket.append(Valuta(id:"bitcoin",name: "name", percent_change_1h: "1.1", percent_change_24h: "1.2", percent_change_7d: "-2.2", symbol: "bitcoin", price_nok: "123123"))
//        valutasMarket.append(Valuta(id:"bitcoin",name: "another name", percent_change_1h: "1.1", percent_change_24h: "1.2", percent_change_7d: "-2.2", symbol: "bitcoin", price_nok: "123123"))
        self.tableView.reloadData()
    }
    

}
