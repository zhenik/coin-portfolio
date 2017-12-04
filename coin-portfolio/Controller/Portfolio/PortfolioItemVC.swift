//
//  PortfolioItemVC.swift
//  coin-portfolio
//
//  Created by Nikita on 04/12/2017.
//  Copyright © 2017 Nikita. All rights reserved.
//

import UIKit

class PortfolioItemVC: UIViewController, UITextFieldDelegate {
    
    // Vars
    var previousVC = PortfolioVC()
    var selectedItem : PortfolioItem?
    // Outlets
    @IBOutlet weak var cardViewItem: UIView!
    // Outlets: data
    @IBOutlet weak var amountLbl: UILabel!
    @IBOutlet weak var moneySpendLbl: UILabel!
    @IBOutlet weak var trendLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var marketPriceLbl: UILabel!
    // Outlets: popup
    
    @IBOutlet var popupView: UIView!
    @IBOutlet weak var popupImg: UIImageView!
    @IBOutlet weak var popupInputField: UITextField!
    
    
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
     ******************************* popup START **********************************
     * https://youtu.be/CXvOS6hYADc
     **/
    func initPopupDesign(){
        
        popupInputField.delegate = self
        
        if let imgData = selectedItem?.image {
            popupImg.image = UIImage(data: imgData)
        }
        popupView.layer.cornerRadius = 3
        popupView.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        popupView.layer.shadowOffset = CGSize(width: 0, height: 1.75)
        popupView.layer.shadowRadius = 1.7
        popupView.layer.shadowOpacity = 0.45
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let charSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: charSet)
    }
    
    func animateIn() {
        self.view.addSubview(popupView)
        popupView.center = self.view.center
        popupView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        popupView.alpha = 0
        UIView.animate(withDuration: 0.4) {
            // animate effects
            self.popupView.alpha = 1
            self.popupView.transform = CGAffineTransform.identity
        }
    }
    
    func animateOut(){
        UIView.animate(withDuration: 0.4, animations: {
            self.popupView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        }) { (success: Bool) in
            self.popupView.removeFromSuperview()
        }
    }
    
    /*
     ******************************* popup END **********************************
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
    
    @IBAction func removeTapped(_ sender: Any) {
        if let itemId = selectedItem?.id {
            CoreDataService.instance.deleteItemById(id: itemId)
            navigationController?.popViewController(animated: true)
            previousVC.tableView.reloadData()
        }
    }
    /*
     ******************************* ACTIONS **********************************
     **/
    
    
    // ******** popup ACTIONS *******
    
    @IBAction func addMoreTapped(_ sender: Any) {
        animateIn()
    }
    
    @IBAction func popupAddTapped(_ sender: Any) {
        animateOut()
        guard let id = selectedItem?.id else {return}
        guard let valuta = ApiDataService.instance.getValutaById(id: id) else {return}
        
        if let text = popupInputField.text {
            print(text)
            if let amount = Double(text) {
                print(amount)
                let spend_money = amount * (valuta.price_nok)
                CoreDataService.instance.addToPortfolio(valuta: valuta, amount: amount, spend: spend_money)
            }
        }
        
        popupInputField.text = ""
        initCardData()
    }
    
    
    
    
    
    
    
   
    
}
