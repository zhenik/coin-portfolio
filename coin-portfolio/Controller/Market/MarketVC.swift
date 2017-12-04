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
        self.tableView.delegate = self
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
    
    //    TABLE VIEW START
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return valutasMarket.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "marketCell", for: indexPath) as! mCell
        cell.name.text = valutasMarket[indexPath.row].symbol
        cell.price.text = valutasMarket[indexPath.row].price_nok.roundedValue
        cell.img.image = ApiDataService.instance.getImage(id: valutasMarket[indexPath.row].id)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let valuta : Valuta = valutasMarket[indexPath.row]
        //        print(valuta)
        performSegue(withIdentifier: TO_MARKET_ITEM, sender: valuta)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let marketItemVC = segue.destination as? MarketItemVC {
            if let valuta = sender as? Valuta {
                marketItemVC.selectedValuta = valuta
                marketItemVC.previousVC = self
            }
        }
    }
    //    TABLE VIEW END
    
    @IBAction func updateTapped(_ sender: Any) {
        ApiDataService.instance.getTenValutas { (success) in
            if success {
                self.valutasMarket = ApiDataService.instance.valutas
                self.tableView.reloadData()
                print("DATA RELOADED")
            }
        }
    }

}


