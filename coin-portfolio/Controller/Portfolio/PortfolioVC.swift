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
    
    func loadPortfolio() {
        self.portfolioItems = CoreDataService.instance.getPortfolioItems()
        self.tableView.reloadData()
    }
    
    
    
    /*
     ******************************* reveal setup START **********************************
     **/
    override func viewDidAppear(_ animated: Bool) {
        initSlideReveal()
        loadPortfolio()
    }
    func initSlideReveal(){
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
    }
    /*
     ******************************* reveal setup END **********************************
     **/
    
    
    
    
    
    
    /*
     ******************************* table view START **********************************
     **/
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
        performSegue(withIdentifier: TO_PORTFOLIO_ITEM, sender: valuta)
    }
    
    // Editable raw
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = portfolioItems[indexPath.row]
            CoreDataService.instance.deleteItemById(id: item.id!)
            loadPortfolio()
            print("DELETED")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let portfolioItemVC = segue.destination as? PortfolioItemVC {
            if let portfolioItem = sender as? PortfolioItem {
                portfolioItemVC.selectedItem = portfolioItem
                portfolioItemVC.previousVC = self
            }
        }
    }
    /*
     ******************************* table view END **********************************
     **/
    
    
    

    
    /*
     ******************************* ACTIONS **********************************
     **/
    @IBAction func updateTapped(_ sender: Any) {
        ApiDataService.instance.getTenValutas { (success) in
            if success {
                self.tableView.reloadData()
                print("DATA RELOADED")
            }
        }
    }
    
    

}
