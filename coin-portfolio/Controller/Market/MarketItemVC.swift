//
//  MarketItemVC.swift
//  coin-portfolio
//
//  Created by Nikita on 29/11/2017.
//  Copyright © 2017 Nikita. All rights reserved.
//

import UIKit

class MarketItemVC: UIViewController {
    
    // Outlets
    @IBOutlet weak var cardViewMarket: UIView!
    @IBOutlet weak var hourLbl: UILabel!
    @IBOutlet weak var dayLbl: UILabel!
    @IBOutlet weak var weekLbl: UILabel!
    @IBOutlet weak var valutaNameLbl: UILabel!
    @IBOutlet weak var valuteImg: UIImageView!
 
    @IBOutlet weak var priceLbl: UILabel!
    
    
    // Vars
    var previousVC = MarketVC()
    var selectedValuta : Valuta?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(selectedValuta)
        initCardDesign()
        initCardData()
    }
    
    func initCardDesign(){
        cardViewMarket.layer.cornerRadius = 3
        cardViewMarket.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        cardViewMarket.layer.shadowOffset = CGSize(width: 0, height: 1.75)
        cardViewMarket.layer.shadowRadius = 1.7
        cardViewMarket.layer.shadowOpacity = 0.45
    }
    
    func initCardData(){
        if let valuta = selectedValuta {
            valutaNameLbl.text=valuta.name
            hourLbl.text="\(valuta.percent_change_1h)%"
            dayLbl.text="\(valuta.percent_change_24h)%"
            weekLbl.text="\(valuta.percent_change_7d)%"
            valuteImg.image = ApiDataService.instance.getImage(id: valuta.id)
            priceLbl.text = valuta.price_nok.roundedValue
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
}
