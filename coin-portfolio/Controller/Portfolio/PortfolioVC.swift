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
//        self.initMarketData()   //TODO: move to app delegate
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
    
    
    
    //    TABLE VIEW START
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return portfolioItems.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "portfolioCell", for: indexPath) as! pCell
        let val = portfolioItems[indexPath.row]
        cell.name.text = val.name
        cell.amount.text = val.amount.roundedValue
        if let imageCurrency = val.image {
           cell.img.image = UIImage(data: imageCurrency)
        }
        if ApiDataService.instance.getTrend(item: val) {
            cell.amount.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        } else {
            cell.amount.textColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        }
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let valuta : PortfolioItem = portfolioItems[indexPath.row]
    }
    //    TABLE VIEW END
    
    
    func loadPortfolio() {
        self.portfolioItems = CoreDataService.instance.getPortfolioItems()
        self.tableView.reloadData()
    }
    
    

}
