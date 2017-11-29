//
//  MarketVC.swift
//  coin-portfolio
//
//  Created by Nikita on 28/11/2017.
//  Copyright © 2017 Nikita. All rights reserved.
//

import UIKit

class MarketVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // Outlets
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    // Data
    var valutasMarket: [Valuta] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        valutasMarket=ApiDataService.instance.valutas
    }
    
    override func viewDidAppear(_ animated: Bool) {
        initSlideReveal()
        self.tableView.reloadData()
    }
    
    func initSlideReveal(){
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
    }
    
    //TODO: refresh on pull
    func updateValutas(){
        ApiDataService.instance.getTenValutas { (success) in
            if success {
                print(ApiDataService.instance.valutas)
                self.valutasMarket = ApiDataService.instance.valutas
                self.tableView.reloadData()
            }
        }
    }
    
//    TABLE VIEW START
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return valutasMarket.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("MarketTableViewCell", owner: self.tableView, options:nil)?.first as! MarketTableViewCell
        cell.name.text = valutasMarket[indexPath.row].name
        cell.price.text = valutasMarket[indexPath.row].price_nok.roundedValue
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! //1.
//        let cellData = valutasMarket[indexPath.row] //2.
//        cell.textLabel?.text = cellData.name //3.
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
//    TABLE VIEW END

}
