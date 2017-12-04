//
//  PortfolioItemVC.swift
//  coin-portfolio
//
//  Created by Nikita on 04/12/2017.
//  Copyright © 2017 Nikita. All rights reserved.
//

import UIKit

class PortfolioItemVC: UIViewController {
    
    // Vars
    var previousVC = PortfolioVC()
    var selectedItem : PortfolioItem?
    // Outlets
    @IBOutlet weak var cardViewItem: UIView!
    
    
    @IBOutlet weak var amountLbl: UILabel!
    @IBOutlet weak var moneySpendLbl: UILabel!
    @IBOutlet weak var trendLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var marketPriceLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initCardDesign()
        initCardData()
    }
    
    /*
     ******************************* navbar view START **********************************
     **/
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    /*
     ******************************* navbar view END **********************************
     **/
    
    
    
    /*
     ******************************* card view START **********************************
     **/
    func initCardDesign(){
        cardViewItem.layer.cornerRadius = 3
        cardViewItem.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        cardViewItem.layer.shadowOffset = CGSize(width: 0, height: 1.75)
        cardViewItem.layer.shadowRadius = 1.7
        cardViewItem.layer.shadowOpacity = 0.45
    }
    func initCardData(){
        if let item = selectedItem {
            
            amountLbl.text = item.amount.roundedValue
            moneySpendLbl.text = item.spend_money.roundedValue
            nameLbl.text = item.name
            
            if let image = item.image {
                img.image = UIImage(data: image)
            }
            
            // trend & marketPrice
            if let itemId = item.id {
                if let marketValuta = ApiDataService.instance.getValutaById(id: itemId) {
                    marketPriceLbl.text = marketValuta.price_nok.roundedValue
                    
                    let sellPrice = item.amount * marketValuta.price_nok
                    let trend = sellPrice - item.spend_money
                    
                    
                    if sellPrice >= item.spend_money {
                        trendLbl.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
                        trendLbl.text = "+\(trend.roundedValue)"
                    } else {
                        trendLbl.textColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
                        trendLbl.text = "\(trend.roundedValue)"
                    }
                }
            }
        }
    }
    /*
     ******************************* card view END **********************************
     **/
    
    
    
    
    
    
    
    /*
     ******************************* ACTIONS **********************************
     **/
    @IBAction func updateTapped(_ sender: Any) {
        ApiDataService.instance.getTenValutas { (success) in
            if success {
                // refresh view
                self.initCardData()
            }
        }
    }
    
    @IBAction func addMoreTapped(_ sender: Any) {
        
    }
    
    @IBAction func removeTapped(_ sender: Any) {
        if let itemId = selectedItem?.id {
            CoreDataService.instance.deleteItemById(id: itemId)
            navigationController?.popViewController(animated: true)
            previousVC.tableView.reloadData()
        }
    }
    
    
    
    
   
    
}
